#!/bin/bash
# Harald Pretl & Georg Zachl, IIC, JKU, 2022

if [ -n "${DRY_RUN}" ]; then
	echo "This is a dry run, all commands will be printed to the shell (Commands printed but not executed are marked with $)!"
	ECHO_IF_DRY_RUN="echo $"
fi

if [ -z ${CONTAINER_NAME+z} ]; then
	CONTAINER_NAME="iic-osic-tools_xserver_uid_"$(id -u)
fi

# Check if the container exists and if it is running.
if [ "$(docker ps -q -f name="${CONTAINER_NAME}")" ]; then
	echo "Container is running! (Hint: It can also be stopped with \"docker stop ${CONTAINER_NAME}\" and removed with \"docker rm ${CONTAINER_NAME}\" if required.)"
	echo -n "Press \"s\" to stop, and \"r\" to stop & remove: "
	read -n 1 k <&1
	echo ""
	if [[ $k = s ]] ; then
		${ECHO_IF_DRY_RUN} docker stop "${CONTAINER_NAME}"
	elif [[ $k = r ]] ; then
		${ECHO_IF_DRY_RUN} docker stop "${CONTAINER_NAME}"
		${ECHO_IF_DRY_RUN} docker rm "${CONTAINER_NAME}"
	fi
fi

# SET YOU DESIGN PATH RIGHT!
if [ -z ${DESIGNS+z} ]; then
	DESIGNS=$HOME/eda/designs
	if [ ! -d "$DESIGNS" ]; then
		${ECHO_IF_DRY_RUN} mkdir -p "$DESIGNS"
	fi
	echo "Design directory auto-set to $DESIGNS"
fi

if [ -z ${DOCKER_USER+z} ]; then
	DOCKER_USER="hpretl"
fi

if [ -z ${DOCKER_IMAGE+z} ]; then
	DOCKER_IMAGE="iic-osic-tools"
fi

if [ -z ${DOCKER_TAG+z} ]; then
	DOCKER_TAG="latest"
fi

PARAMS="--security-opt seccomp=unconfined"
if [[ "$OSTYPE" == "linux"* ]]; then
	echo "Auto detected Linux"
	# Should also be a senseful default
	if [ -z ${CONTAINER_USER+z} ]; then
	        CONTAINER_USER=$(id -u)
	fi

	if [ -z ${CONTAINER_GROUP+z} ]; then
	        CONTAINER_GROUP=$(id -g)
	fi
	if [ -z ${XSOCK+z} ]; then
		if [ -d "/tmp/.X11-unix" ]; then
			XSOCK="/tmp/.X11-unix"
		else
			echo "X socket could not be found. Please set manually!"
			exit 1
		fi
	fi
	PARAMS="$PARAMS -v $XSOCK:/tmp/.X11-unix:rw"
	if [ -z ${DISP+z} ]; then
		if [ -z ${DISPLAY+z} ]; then
			echo "No DISPLAY set"
			exit 1
		else
			DISP=$DISPLAY
		fi
	fi
	if [ -z ${XAUTH+z} ]; then
		# Senseful defaults (uses XAUTHORITY Shell variable if set, or the default .Xauthority -file in the caller home directory)
		if [ -z ${XAUTHORITY+z} ]; then
			if [ -f "$HOME/.Xauthority" ]; then
				XAUTH="$HOME/.Xauthority"
			else
				echo "Xauthority could not be found. Please set manually!"
				exit 1
			fi
		else
			XAUTH=$XAUTHORITY
		fi
		# Thanks to https://stackoverflow.com/a/25280523
		XAUTH_TMP="/tmp/.${CONTAINER_NAME}_xauthority"
		#create empty file
		${ECHO_IF_DRY_RUN} echo -n > "${XAUTH_TMP}"
		if [ -z "${ECHO_IF_DRY_RUN}" ]; then
			xauth -f "${XAUTH}" nlist "${DISP}" | sed -e 's/^..../ffff/' | xauth -f "${XAUTH_TMP}" nmerge -
		else
			${ECHO_IF_DRY_RUN} "xauth -f ${XAUTH} nlist ${DISP} | sed -e 's/^..../ffff/' | xauth -f ${XAUTH_TMP} nmerge -"
		fi
		XAUTH=${XAUTH_TMP}
		if [ -d "/dev/dri" ]; then
			echo "/dev/dri detected, forwarding GPU for graphics acceleration."
			PARAMS="${PARAMS} --device=/dev/dri:/dev/dri"
		else
			echo "No /dev/dri detected!"
			FORCE_LIBGL_INDIRECT=1
		fi
	fi
	PARAMS="$PARAMS -v $XAUTH:/headless/.xauthority:rw -e XAUTHORITY=/headless/.xauthority"

elif [[ "$OSTYPE" == "darwin"* ]]; then
	if [ -z ${CONTAINER_USER+z} ]; then
	        CONTAINER_USER=1000
	fi

	if [ -z ${CONTAINER_GROUP+z} ]; then
	        CONTAINER_GROUP=1000
	fi
	if [ -z ${DISP+z} ]; then
		DISP="host.docker.internal:0"
		if [[ $(type -P "xhost") ]]; then
			${ECHO_IF_DRY_RUN} xhost +localhost
		else
			echo "WARNING: xhost could not be found, access control to the X server must be managed manually!"
		fi
	fi
	if [ "$(defaults read org.xquartz.x11 enable_iglx)" = 0 ]; then
		${ECHO_IF_DRY_RUN} defaults write org.xquartz.x11 enable_iglx 1
		echo "Enabled XQuartz OpenGL for indirect rendering."
		echo "WARNING: Please restart XQuartz!"
		exit 1
	fi
	FORCE_LIBGL_INDIRECT=1
else
	echo "Not setup for ${OSTYPE}"
	exit 1
fi

if [ -n "${FORCE_LIBGL_INDIRECT}" ]; then
	echo "Using indirect rendering."
	PARAMS="${PARAMS} -e LIBGL_ALWAYS_INDIRECT=1"
fi

if [ -n "${DOCKER_EXTRA_PARAMS}" ]; then
	PARAMS="${PARAMS} ${DOCKER_EXTRA_PARAMS}"
fi

# Check for UIDs and GIDs below 1000, except 0 (root)
if [[ ${CONTAINER_USER} -ne 0 ]]  &&  [[ ${CONTAINER_USER} -lt 1000 ]]; then
        prt_str="# WARNING: Selected User ID ${CONTAINER_USER} is below 1000. This ID might interfere with User-IDs inside the container and cause undefined behaviour! #"
        printf -- '#%.0s' $(seq 1 ${#prt_str})
        echo ""
        echo ${prt_str}
        printf -- '#%.0s' $(seq 1 ${#prt_str})
        echo ""
fi

if [[ ${CONTAINER_GROUP} -ne 0 ]]  && [[ ${CONTAINER_GROUP} -lt 1000 ]]; then
        prt_str="# WARNING: Selected Group ID ${CONTAINER_GROUP} is below 1000. This ID might interfere with Group-IDs inside the container and cause undefined behaviour! #"
        printf -- '#%.0s' $(seq 1 ${#prt_str})
        echo ""
        echo ${prt_str}
        printf -- '#%.0s' $(seq 1 ${#prt_str})
        echo ""
fi

# If the container exists but is exited, it can restarted.
if [ "$(docker ps -aq -f name="${CONTAINER_NAME}")" ]; then
	echo    "Container ${CONTAINER_NAME} exists. (Hint: It can also be restarted with \"docker start ${CONTAINER_NAME}\" or removed with \"docker rm ${CONTAINER_NAME}\" if required.)"
	echo -n "Press \"s\" to start, and \"r\" to remove: "
	read -n 1 k <&1
	echo ""
	if [[ $k = s ]] ; then
		${ECHO_IF_DRY_RUN} docker start "${CONTAINER_NAME}"
	elif [[ $k = r ]] ; then
		${ECHO_IF_DRY_RUN} docker rm "${CONTAINER_NAME}"
	fi
else
	echo "Container does not exist, creating ${CONTAINER_NAME} ..."
	# Finally, run the container, sets DISPLAY to the local display number
	${ECHO_IF_DRY_RUN} docker pull "${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}"
	# Disable SC2086, $PARAMS must be globbed and splitted.
	# shellcheck disable=SC2086
	${ECHO_IF_DRY_RUN} docker run -d --user "${CONTAINER_USER}:${CONTAINER_GROUP}" -e "DISPLAY=${DISP}" -v "${DESIGNS}:/foss/designs:rw" ${PARAMS} --name "${CONTAINER_NAME}" "${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}"
fi

