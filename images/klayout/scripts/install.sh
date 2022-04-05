#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

prefix=/foss/tools/${NAME}/${REPO_COMMIT}
mkdir -p $prefix
./build.sh -j$(nproc) -prefix "$prefix"
#./build.sh -j$(nproc) -prefix "$prefix"

