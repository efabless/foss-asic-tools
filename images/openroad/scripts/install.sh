#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $OPENROAD_REPO_COMMIT | cut -c 1-7)

git clone --recursive ${OPENROAD_REPO_URL} ${OPENROAD_NAME}
cd ${OPENROAD_NAME}
git checkout ${OPENROAD_REPO_COMMIT}
mkdir -p build/
cd build
CFLAGS='-Wno-narrowing' cmake .. "-DCMAKE_INSTALL_PREFIX=/foss/tools/${OPENROAD_NAME}/${REPO_COMMIT_SHORT}"
make -j$(($(nproc) / 2))
make install
