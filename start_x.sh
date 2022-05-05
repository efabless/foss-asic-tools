#!/bin/bash
# Harald Pretl & Georg Zachl, IIC, JKU, 2022

# SET YOU DESIGN PATH RIGHT!
if [ -z ${DESIGNS+z} ]; then
        DESIGNS=$HOME/eda/designs

	if [ ! -d "$DESIGNS" ]; then
		mkdir -p "$DESIGNS"
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


exec_exists() {
	type "$1" >/dev/null >/dev/null
}

PARAMS=""
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	echo "Auto detected Linux"
	# Should also be a senseful default
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
		XAUTH_TMP="/tmp/.iic-osic-docker_xauthority"
		#create empty file
		echo -n > ${XAUTH_TMP}
		xauth -f ${XAUTH} nlist ${DISP} | sed -e 's/^..../ffff/' | xauth -f ${XAUTH_TMP} nmerge -
		XAUTH=${XAUTH_TMP}
	fi
	PARAMS="$PARAMS -v $XAUTH:/headless/.xauthority:rw -e XAUTHORITY=/headless/.xauthority"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	if [ -z ${DISP+z} ]; then
		DISP="host.docker.internal:0"
		if [[ $(type -P "xhost") ]]; then
			xhost localhost
		else
			echo "WARNING: xhost could not be found, access control to the X server must be managed manually!"
		fi
	fi
else
	echo "Not setup for $OSTYPE"
	exit 1
fi


# Finally, run the container, sets DISPLAY to the local display number
docker run -d --user $(id -u):$(id -g) -e DISPLAY=$DISP -v $DESIGNS:/foss/designs:rw $PARAMS ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}

