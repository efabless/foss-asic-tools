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

if [ -z ${DOCKER_USER+z} ]; then
	DOCKER_USER="hpretl"
fi

if [ -z ${DOCKER_IMAGE+z} ]; then
	DOCKER_IMAGE="iic-osic-tools"
fi

if [ -z ${DOCKER_TAG+z} ]; then
	DOCKER_TAG="latest"
fi

# Shell starts as root per default.
if [ -z ${CONTAINER_USER+z} ]; then
	CONTAINER_USER="0"
fi

if [ -z ${CONTAINER_GROUP+z} ]; then
	CONTAINER_GROUP="0"
fi

if [ -z ${CONTAINER_NAME+z} ]; then
	CONTAINER_NAME="iic-osic-tools_shell_uid_"$(id -u)
fi

# Check if the container exists and if it is running.
if [ "$(docker ps -q -f name="${CONTAINER_NAME}")" ]; then
	echo "Container is running! If required, stop with \"docker stop ${CONTAINER_NAME}\" and remove with \"docker rm ${CONTAINER_NAME}\""
# If the container exists but is exited, it is restarted.
elif [ "$(docker ps -aq -f name="${CONTAINER_NAME}")" ]; then
	echo "Container ${CONTAINER_NAME} exists, restarting... (remove with \"docker rm ${CONTAINER_NAME}\" if required, e.g. for updating)"
	${ECHO_IF_DRY_RUN} docker start -a -i "${CONTAINER_NAME}"
else
	echo "Container does not exist, creating ${CONTAINER_NAME} ..."
	# Finally, run the container, sets DISPLAY to the local display number
	${ECHO_IF_DRY_RUN} docker pull "${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}"
	# Disable SC2086, $PARAMS must be globbed and splitted.
	${ECHO_IF_DRY_RUN} docker run -it --name "${CONTAINER_NAME}" --user "${CONTAINER_USER}:${CONTAINER_GROUP}" -e "DISPLAY=${DISP}" -v "${DESIGNS}:/foss/designs:rw" "${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}" -s /bin/bash
fi
