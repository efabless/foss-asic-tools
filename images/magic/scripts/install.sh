#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $MAGIC_REPO_COMMIT | cut -c 1-7)

git clone ${MAGIC_REPO_URL} ${MAGIC_NAME}
cd ${MAGIC_NAME}
git checkout ${MAGIC_REPO_COMMIT}
./configure --prefix=/foss/tools/${MAGIC_NAME}/${REPO_COMMIT_SHORT}
make -j$(nproc)
make install

echo "$MAGIC_NAME $MAGIC_REPO_COMMIT" > /foss/tools/${MAGIC_NAME}/${REPO_COMMIT_SHORT}/SOURCES
