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

DATE_TAG=$(date +"%Y.%m")

set -e
docker buildx create --name iic-osic-tools-builder --node iic-osic-tools-builder0 --bootstrap --config ./buildkitd.toml
docker buildx build --platform ${DOCKER_PLATFORMS} --builder iic-osic-tools-builder --push --tag ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG} --tag ${DOCKER_USER}/${DOCKER_IMAGE}:${DATE_TAG} .
