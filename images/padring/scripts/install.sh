#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $REPO_COMMIT | cut -c 1-7)

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}
bash ./bootstrap.sh
cd build
ninja
mkdir -p /foss/tools/${NAME}/${REPO_COMMIT_SHORT}/bin
cp padring /foss/tools/${NAME}/${REPO_COMMIT_SHORT}/bin
