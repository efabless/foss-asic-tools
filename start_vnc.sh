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

# Set the host ports, disable with 0. Only used if not set as a shell variables!
if [ -z ${WEBSERVER_PORT+z} ]; then
	WEBSERVER_PORT=80
fi
if [ -z ${VNC_PORT+z} ]; then
	VNC_PORT=5901
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

PORT_PARAMS=""
if [ $WEBSERVER_PORT -gt 0 ]; then
	PORT_PARAMS="$PORT_PARAMS -p $WEBSERVER_PORT:80"
fi
if [ $VNC_PORT -gt 0 ]; then
	PORT_PARAMS="$PORT_PARAMS -p $VNC_PORT:5901"
fi

docker run -d --user $(id -u):$(id -g) $PORT_PARAMS -v $DESIGNS:/foss/designs:rw ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}
