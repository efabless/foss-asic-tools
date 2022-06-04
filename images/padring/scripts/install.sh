#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $PADRING_REPO_COMMIT | cut -c 1-7)

git clone ${PADRING_REPO_URL} ${PADRING_NAME}
cd ${PADRING_NAME}
git checkout ${PADRING_REPO_COMMIT}
bash ./bootstrap.sh
cd build
ninja
mkdir -p /foss/tools/${PADRING_NAME}/${REPO_COMMIT_SHORT}/bin
cp padring /foss/tools/${PADRING_NAME}/${REPO_COMMIT_SHORT}/bin
