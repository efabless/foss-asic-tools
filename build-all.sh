#!/bin/bash
# Harald Pretl & Georg Zachl, IIC, JKU, 2022
#
# Build script for IIC docker images

set -e

if [ -n "${DRY_RUN}" ]; then
	echo "This is a dry run, all commands will be printed to the shell (Commands printed but not executed are marked with $)!"
	ECHO_IF_DRY_RUN="echo $"
fi

if [ -z ${DOCKER_USER+z} ]; then
	DOCKER_USER="hpretl"
fi

if [ -z ${DOCKER_IMAGE+z} ]; then
        DOCKER_IMAGE="iic-osic-tools"
fi

if [ -z ${DOCKER_TAGS+z} ]; then
        DOCKER_TAGS="latest $(date +"%Y.%m")"
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
	ARM64_BUILDER_STR="host=unix:///var/run/docker.sock"
fi

if [ -z ${AMD64_BUILDER_STR+z} ]; then
	AMD64_BUILDER_STR="host=ssh://pretl@buildx86"
fi

if [ -z ${BUILDER_NAME+z} ]; then
	BUILDER_NAME="iic-osic-tools-builder"
fi

# Process set tags:
TAG_PARAMS=""
IFS=' ' read -ra P_TAGS <<< "$DOCKER_TAGS"
for i in "${P_TAGS[@]}"; do
	echo "Using Tag \"$i\""
	TAG_PARAMS="${TAG_PARAMS} --tag ${DOCKER_USER}/${DOCKER_IMAGE}:${i}"
done

if [ -z "${TAG_PARAMS}" ]; then
	echo "WARNING: No tags set!"
fi

# if a builder already exists (either from a previous run or manually created), we directly run the build command.
# if not, we check for the components and create them if required.
if ! docker buildx inspect ${BUILDER_NAME} ; then
	# Create the amd64 build context
	if ! docker context inspect ${BUILDER_NAME}-amd64 ; then
		echo "Creating docker context ${BUILDER_NAME}-amd64"
		${ECHO_IF_DRY_RUN} docker context create ${BUILDER_NAME}-amd64 --docker ${AMD64_BUILDER_STR}
	fi
	# create the arm64 build context
	if ! docker context inspect ${BUILDER_NAME}-arm64 ; then
		echo "Creating docker context ${BUILDER_NAME}-arm64"
		${ECHO_IF_DRY_RUN} docker context create ${BUILDER_NAME}-arm64 --docker ${ARM64_BUILDER_STR}
	fi

	#docker buildx create --name iic-osic-tools-builder --node iic-osic-tools-builder0 --bootstrap --config ./buildkitd.toml
	echo "Creating docker buildx builder ${BUILDER_NAME}"
	${ECHO_IF_DRY_RUN} docker buildx create --name ${BUILDER_NAME} --config ./buildkitd.toml --platform linux/amd64 ${BUILDER_NAME}-amd64
	${ECHO_IF_DRY_RUN} docker buildx create --name ${BUILDER_NAME} --config ./buildkitd.toml --platform linux/arm64 --append ${BUILDER_NAME}-arm64
fi
${ECHO_IF_DRY_RUN} docker buildx build --platform ${DOCKER_PLATFORMS} --builder ${BUILDER_NAME} ${load_or_push} ${TAG_PARAMS} .

