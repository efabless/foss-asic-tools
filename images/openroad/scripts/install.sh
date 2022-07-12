#!/bin/bash

set -e
source scl_source enable gcc-toolset-11

REPO_COMMIT_SHORT=$(echo $OPENROAD_APP_REPO_COMMIT | cut -c 1-7)

git clone ${OPENROAD_APP_REPO_URL} ${OPENROAD_APP_NAME}
cd ${OPENROAD_APP_NAME}
git checkout ${OPENROAD_APP_REPO_COMMIT}
git submodule update --init --recursive

mkdir -p build/
cd build
CFLAGS='-Wno-narrowing' cmake .. "-DCMAKE_INSTALL_PREFIX=/foss/tools/${OPENROAD_APP_NAME}/${REPO_COMMIT_SHORT}"
make -j$(nproc)
make install
