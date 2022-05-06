#!/bin/bash
# Harald Pretl & Georg Zachl, IIC, JKU, 2022
#
# Build script for IIC docker images

set -e

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

if [ -z ${ARM64_BUILDER_STR+z} ]; then
	AMD64_BUILDER_STR="host=unix:///var/run/docker.sock"
fi

if [ -z ${AMD64_BUILDER_STR+z} ]; then
	ARM64_BUILDER_STR="host=ssh://pretl@buildx86"
fi

if [ -z ${BUILDER_NAME+z} ]; then
	BUILDER_NAME="iic-osic-tools-builder"
fi

DATE_TAG=$(date +"%Y.%m")

set -e

# if a builder already exists (either from a previous run or manually created), we directly run the build command.
# if not, we check for the components and create them if required.
if ! docker buildx inspect ${BUILDER_NAME} ; then
	# Create the amd64 build context
	if ! docker context inspect ${BUILDER_NAME}-amd64 ; then
		echo "Creating docker context ${BUILDER_NAME}-amd64"
		docker context create ${BUILDER_NAME}-amd64 --docker ${AMD64_BUILDER_STR}
	fi
	# create the arm64 build context
	if ! docker context inspect ${BUILDER_NAME}-arm64 ; then
		echo "Creating docker context ${BUILDER_NAME}-arm64"
		docker context create ${BUILDER_NAME}-arm64 --docker ${ARM64_BUILDER_STR}
	fi

	#docker buildx create --name iic-osic-tools-builder --node iic-osic-tools-builder0 --bootstrap --config ./buildkitd.toml
	echo "Creating docker buildx builder ${BUILDER_NAME}"
	docker buildx create --name ${BUILDER_NAME} --config ./buildkitd.toml --platform linux/amd64 ${BUILDER_NAME}-amd64
	docker buildx create --name ${BUILDER_NAME} --config ./buildkitd.toml --platform linux/arm64 --append ${BUILDER_NAME}-arm64
fi
docker buildx build --platform ${DOCKER_PLATFORMS} --builder ${BUILDER_NAME} ${load_or_push} --tag ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG} --tag ${DOCKER_USER}/${DOCKER_IMAGE}:${DATE_TAG} .

