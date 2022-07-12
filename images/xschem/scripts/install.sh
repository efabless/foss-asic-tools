#!/bin/bash

set -e
source scl_source enable gcc-toolset-11

REPO_COMMIT_SHORT=$(echo $XSCHEM_REPO_COMMIT | cut -c 1-7)

git clone ${XSCHEM_REPO_URL} ${XSCHEM_NAME}
cd ${XSCHEM_NAME}
git checkout ${XSCHEM_REPO_COMMIT}
./configure --prefix=/foss/tools/${XSCHEM_NAME}/${REPO_COMMIT_SHORT}
make -j$(nproc)
make install
