#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo $OPENSTA_REPO_COMMIT | cut -c 1-7)

mkdir -p /foss/tools/
git clone ${OPENSTA_REPO_URL} /foss/tools/${OPENSTA_NAME}/${REPO_COMMIT_SHORT}
cd /foss/tools/${OPENSTA_NAME}/${REPO_COMMIT_SHORT}

git checkout ${OPENSTA_REPO_COMMIT}

mkdir build
cd build
cmake ..
make -j$(nproc)
cd ..
mkdir bin
cp app/sta bin
