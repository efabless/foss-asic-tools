#!/bin/bash
# Harald Pretl & Georg Zachl, IIC, JKU, 2022
#
# Build script for IIC docker images

set -e

if [ -n "${DRY_RUN}" ]; then
	echo "This is a dry run, all commands will be printed to the shell (Commands printed but not executed are marked with $)!"
	ECHO_IF_DRY_RUN="echo $"
fi

if [ -z ${BUILDER_NAME+z} ]; then
	BUILDER_NAME="iic-osic-tools-builder"
fi

if [ -z ${DOCKER_PLATFORMS+z} ]; then
        DOCKER_PLATFORMS="linux/amd64,linux/arm64/v8"
fi

# delete the builders in the reversed creation order
if docker buildx inspect ${BUILDER_NAME} > /dev/null 2>&1 ; then
	echo "Deleting docker buildx builder ${BUILDER_NAME}"
	${ECHO_IF_DRY_RUN} docker buildx rm ${BUILDER_NAME}
fi
P_PLATS=""
IFS=',' read -ra P_PLATS <<< "$DOCKER_PLATFORMS"
for i in "${!P_PLATS[@]}"; do
	if docker context inspect ${BUILDER_NAME}-${P_PLATS[i]//\//-} > /dev/null 2>&1 ; then
		echo "Deleting docker context ${BUILDER_NAME}-${P_PLATS[i]//\//-}"
		${ECHO_IF_DRY_RUN} docker context rm ${BUILDER_NAME}-${P_PLATS[i]//\//-}
	fi
done
