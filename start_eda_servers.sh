#!/bin/bash
#
# (c) 2023 Harald Pretl, Institute for Integrated Circuits, Johannes Kepler University, Linz, Austria
#
# Spins up multiple IIC-OSIC-TOOLS containers for many EDA users

# general settings for all users
export DOCKER_EXTRA_PARAMS="--cpus 4 --memory 4G"
export VNC_PORT=0

# variables for script control
DEBUG=0
DO_CLEAN=0
DO_KILL=0
START_PORT=50001
NUMBER_USERS=20
PASSWD_DIGITS=20
USER_GROUP=2000
CREDENTIAL_FILE="eda_user_credentials.json"

while getopts "hcdkp:n:s:f:g:" flag; do
	case $flag in
		c)
			[ $DEBUG = 1 ] && echo "[INFO] flag -c is set"
			DO_CLEAN=1
			;;
		p)	
			[ $DEBUG = 1 ] && echo "[INFO] flag -p is set to $OPTARG"
			START_PORT=${OPTARG}
			;;
		d)
			echo "[INFO] DEBUG is enabled"
			DEBUG=1
			;;
		n)
			[ $DEBUG = 1 ] && echo "[INFO] flag -n is set to $OPTARG"
			NUMBER_USERS=${OPTARG}
			;;
		s)
			[ $DEBUG = 1 ] && echo "[INFO] flag -s is set to $OPTARG"
			PASSWD_DIGITS=${OPTARG}
			;;
		f)
			[ $DEBUG = 1 ] && echo "[INFO] flag -f is set to $OPTARG"
			CREDENTIAL_FILE=${OPTARG}
			;;
		g)
			[ $DEBUG = 1 ] && echo "[INFO] flag -g is set to $OPTARG"
			USER_GROUP=${OPTARG}
			;;
		k)
			[ $DEBUG = 1 ] && echo "[INFO] flag -k is set"
			DO_KILL=1
			;;
		h)
			echo "Spinning up Docker instances for EDA users"
			echo "(c) 2023 Harald Pretl, Institute for Integrated Circuits, JKU"
			echo ""
			echo "Usage: $0 [-h] [-d] [-c] [-k] [-p port_number] [-n number_instances] [-g user_group] [-s passwd_digits] [-f credential_file]"
			echo ""
			echo "       -h shows a help screen"
			echo "       -d enables the debug mode"
			echo "       -c cleans the user-file directories"
			echo "       -k stops and removes running containers"
			echo "       -p sets the starting port number (default $START_PORT)"
			echo "       -n sets the number of container instances that are generated (default $NUMBER_USERS)"
			echo "       -g sets the used group-ID (default $USER_GROUP)"
			echo "       -s sets the number of digits of the auto-generated user passwords (default $PASSWD_DIGITS)"
			echo "       -f sets the name of the credentials file (default $CREDENTIAL_FILE)"
			echo "" 
			exit
			;;
		*)
			;;
    esac
done
shift $((OPTIND-1))

# print a bit of status information
[ $DEBUG = 1 ] && [ $DO_CLEAN = 1 ] && echo "[INFO] cleaning user directories is selected"
[ $DEBUG = 1 ] && [ $DO_KILL = 1 ] && echo "[INFO] stopping and removing the running containers is selected"
[ $DEBUG = 1 ] && echo "[INFO] starting port number is $START_PORT"
[ $DEBUG = 1 ] && echo "[INFO] use group is $USER_GROUP"
[ $DEBUG = 1 ] && echo "[INFO] number of instances is $NUMBER_USERS"
[ $DEBUG = 1 ] && echo "[INFO] number of password digits is $PASSWD_DIGITS"
[ $DEBUG = 1 ] && echo "[INFO] user credentials are stored in $CREDENTIAL_FILE"

# here is a function for the actual work
spin_up_server () {
	# $1 = username (e.g. user01)
	# $2 = passwd
	# $3 = webserver port (in the range of 50000-50200)

	export VNC_PW="$2"
	export DESIGNS="$HOME/eda/$1"
	export CONTAINER_NAME="iic-osic-tools_eda_$1"
	export WEBSERVER_PORT="$3"
	export CONTAINER_GROUP="$USER_GROUP"

	if [ "$(docker ps -q -f name="${CONTAINER_NAME}")" ]; then
		if [ $DO_KILL = 0 ]; then
			echo "[ERROR] Running container instances detected without the -k option, stopping now!"
			exit 1
		fi
		[ $DEBUG = 1 ] && echo "[INFO] Container $CONTAINER_NAME running, will now stop and remove it!"
		docker stop "${CONTAINER_NAME}" > /dev/null
		docker rm "${CONTAINER_NAME}" > /dev/null
	fi

	[ $DO_CLEAN = 1 ] && rm -rf "DESIGNS"
	mkdir -p "$DESIGNS"

	# shellcheck source=/dev/null
	source start_vnc.sh
}

write_credentials () {
	# $1 = username
	# $2 = passwd
	# $3 = webserver port
	# $4 = credentials file

	# get local IP of server
	HOSTIP=$(hostname -I | awk '{print $1}')

	# write a JSON file
	jq ". + [{ \"user\": \"$1\", \"password\": \"$2\", \"port\": $3, \"url\": \"http://$HOSTIP:$3/?password=$2\" }]" "$4" > "$4.tmp"
	mv "$4.tmp" "$4"
}

# sanitize input parameters
# check if parameters are integers
[ -n "$START_PORT" ] && [ "$START_PORT" -eq "$START_PORT" ] 2>/dev/null
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
   echo "[ERROR] -p requires an integer!"
   exit 1
fi
[ -n "$NUMBER_USERS" ] && [ "$NUMBER_USERS" -eq "$NUMBER_USERS" ] 2>/dev/null
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
   echo "[ERROR] -n requires an integer!"
   exit 1
fi
[ -n "$USER_GROUP" ] && [ "$USER_GROUP" -eq "$USER_GROUP" ] 2>/dev/null
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
   echo "[ERROR] -g requires an integer!"
   exit 1
fi
[ -n "$PASSWD_DIGITS" ] && [ "$PASSWD_DIGITS" -eq "$PASSWD_DIGITS" ] 2>/dev/null
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
   echo "[ERROR] -s requires an integer!"
   exit 1
fi
# check if parameters are in a useful range
if [ "$START_PORT" -lt 1024 ] || [ "$START_PORT" -gt 65535 ]; then
	echo "[ERROR] Illegal starting port number (range is 1024...65535)!"
	exit 1
fi
if [ "$NUMBER_USERS" -lt 1 ] || [ "$NUMBER_USERS" -gt 200 ]; then
	echo "[ERROR] Illegal number of container instances (must be between 1 and 200)!"
	exit 1
fi
if [ "$PASSWD_DIGITS" -lt 6 ] || [ "$PASSWD_DIGITS" -gt 64 ]; then
	echo "[ERROR] Illegal number of password digits (must be between 6 and 64)!"
	exit 1
fi
if [ -z "$(getent group "$USER_GROUP")" ]; then
	echo "[ERROR] Illegal user group!"
	exit 1
fi

# here is the loop
echo "[]" > "$CREDENTIAL_FILE"

echo "[INFO] Starting to spin up EDA server instances."
for i in $(seq 1 "$NUMBER_USERS")
do
	PASSWD=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c"${1:-$PASSWD_DIGITS}")	
	PORTNO=$((START_PORT + i - 1))
	USERNAME="user$PORTNO"

	[ $DEBUG = 1 ] && echo "[INFO] Creating container with user=$USERNAME, using port=$PORTNO, with password=$PASSWD"
	
	write_credentials $USERNAME "$PASSWD" $PORTNO "$CREDENTIAL_FILE"

	spin_up_server "$USERNAME" "$PASSWD" "$PORTNO"
done

echo ""
echo "[INFO] EDA containers are up and running!"
echo "[INFO] User credentials can be found in $CREDENTIAL_FILE."
echo "[DONE] Bye!"
