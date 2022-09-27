#!/bin/bash
# Harald Pretl & Georg Zachl, IIC, JKU, 2022

if [ -n "${DRY_RUN}" ]; then
	echo "This is a dry run, all commands will be printed to the shell (Commands printed but not executed are marked with $)!"
	ECHO_IF_DRY_RUN="echo $"
fi

# SET YOU DESIGN PATH RIGHT!
if [ -z ${DESIGNS+z} ]; then
	DESIGNS=$HOME/eda/designs
	if [ ! -d "$DESIGNS" ]; then
		${ECHO_IF_DRY_RUN} mkdir -p "$DESIGNS"
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

if [ -z ${CONTAINER_USER+z} ]; then
	CONTAINER_USER=$(id -u)
fi

if [ -z ${CONTAINER_GROUP+z} ]; then
	CONTAINER_GROUP=$(id -g)
fi

if [ -z ${CONTAINER_NAME+z} ]; then
	CONTAINER_NAME="iic-osic-tools_xvnc_uid_"$(id -u)
fi

# Processing ports
PORT_PARAMS=""
if [ $WEBSERVER_PORT -gt 0 ]; then
	PORT_PARAMS="$PORT_PARAMS -p $WEBSERVER_PORT:80"
fi
if [ $VNC_PORT -gt 0 ]; then
	PORT_PARAMS="$PORT_PARAMS -p $VNC_PORT:5901"
fi

# Check if the container exists and if Status is running. (|& redirects both stderr and stdout, -q makes the output quiet)
if docker container inspect "${CONTAINER_NAME}" |& grep "Status" | grep -i -q "running" ; then
	echo "Container is running! If required, stop with \"docker stop ${CONTAINER_NAME}\" and remove with \"docker rm ${CONTAINER_NAME}\""
# If the container exists but is exited, it is restarted.
elif docker container inspect "${CONTAINER_NAME}" |& grep "Status" | grep -i -q "exited" ; then
	echo "Container ${CONTAINER_NAME} exists, restarting... (remove with \"docker rm ${CONTAINER_NAME}\" if required, e.g. for updating)"
	${ECHO_IF_DRY_RUN} docker start "${CONTAINER_NAME}"
else
	echo "Container does not exist, creating ${CONTAINER_NAME} ..."
	# Finally, run the container, sets DISPLAY to the local display number
	${ECHO_IF_DRY_RUN} docker pull "${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}"
	# Disable SC2086, $PARAMS must be globbed and splitted.
	# shellcheck disable=SC2086
	${ECHO_IF_DRY_RUN} docker run -d --user "${CONTAINER_USER}:${CONTAINER_GROUP}" $PORT_PARAMS -v "$DESIGNS:/foss/designs:rw" --name "${CONTAINER_NAME}" "${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}"
fi
