#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $KLAYOUT_REPO_COMMIT | cut -c 1-7)

git clone ${KLAYOUT_REPO_URL} ${KLAYOUT_NAME}
cd ${KLAYOUT_NAME}
git checkout ${KLAYOUT_REPO_COMMIT}
prefix=/foss/tools/${KLAYOUT_NAME}/${REPO_COMMIT_SHORT}
mkdir -p "$prefix"
./build.sh -j$(($(nproc) / 2)) -prefix "$prefix"
