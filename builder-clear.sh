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

# delete the builders in the reversed creation order
if docker buildx inspect ${BUILDER_NAME} ; then
	echo "Deleting docker buildx builder ${BUILDER_NAME}"
	${ECHO_IF_DRY_RUN} docker buildx rm ${BUILDER_NAME}
fi
if docker context inspect ${BUILDER_NAME}-amd64 ; then
	echo "Deleting docker context ${BUILDER_NAME}-amd64"
	${ECHO_IF_DRY_RUN} docker context rm ${BUILDER_NAME}-amd64
fi
if docker context inspect ${BUILDER_NAME}-arm64 ; then
	echo "Deleting docker context ${BUILDER_NAME}-arm64"
	${ECHO_IF_DRY_RUN} docker context rm ${BUILDER_NAME}-arm64
fi

