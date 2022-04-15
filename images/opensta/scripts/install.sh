#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $REPO_COMMIT | cut -c 1-7)

mkdir -p /foss/tools/
git clone ${REPO_URL} /foss/tools/${NAME}/${REPO_COMMIT_SHORT}
cd /foss/tools/${NAME}/${REPO_COMMIT_SHORT}

git checkout ${REPO_COMMIT}

mkdir build
cd build
cmake ..
make -j$(nproc)
cd ..
mkdir bin
cp app/sta bin
