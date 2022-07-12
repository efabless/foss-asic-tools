#!/bin/bash

set -e
source scl_source enable gcc-toolset-11

REPO_COMMIT_SHORT=$(echo $MAGIC_REPO_COMMIT | cut -c 1-7)

git clone ${MAGIC_REPO_URL} ${MAGIC_NAME}
cd ${MAGIC_NAME}
git checkout ${MAGIC_REPO_COMMIT}
./configure --prefix=/foss/tools/${MAGIC_NAME}/${REPO_COMMIT_SHORT}
make database/database.h
make -j$(nproc)
make install

cp ../magic-cheatsheet.txt /foss/tools/${MAGIC_NAME}/${REPO_COMMIT_SHORT}/

echo "$MAGIC_NAME $MAGIC_REPO_COMMIT" > /foss/tools/${MAGIC_NAME}/${REPO_COMMIT_SHORT}/SOURCES
