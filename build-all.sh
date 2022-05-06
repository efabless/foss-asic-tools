#!/bin/bash
# Harald Pretl & Georg Zachl, IIC, JKU, 2022
#
# Build script for IIC docker images

if [ -z ${DOCKER_USER+z} ]; then
	DOCKER_USER="hpretl"
fi

if [ -z ${DOCKER_IMAGE+z} ]; then
        DOCKER_IMAGE="iic-osic-tools"
fi

if [ -z ${DOCKER_TAG+z} ]; then
        DOCKER_TAG="latest"
fi

if [ -z ${DOCKER_PLATFORMS+z} ]; then
	DOCKER_PLATFORMS="linux/amd64,linux/arm64/v8"
fi

if [ -z ${DOCKER_LOAD+z} ]; then
	load_or_push="--push"
else
	load_or_push="--load"
fi

DATE_TAG=$(date +"%Y.%m")

set -e

BUILDER_NAME="iic-builder"

# Create the local build context (on arm)
docker context create ${BUILDER_NAME}-arm64
# Create the remote build context (on x86)
docker context create ${BUILDER_NAME}-amd64 --docker host=ssh://pretl@buildx86

docker buildx create --name ${BUILDER_NAME} --config ./buildkitd.toml --platform linux/arm64 ${BUILDER_NAME}-arm64
docker buildx create --name ${BUILDER_NAME} --config ./buildkitd.toml --platform linux/amd64 --append ${BUILDER_NAME}-amd64
docker buildx build --platform ${DOCKER_PLATFORMS} --builder ${BUILDER_NAME} ${load_or_push} --tag ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG} --tag ${DOCKER_USER}/${DOCKER_IMAGE}:${DATE_TAG} .
