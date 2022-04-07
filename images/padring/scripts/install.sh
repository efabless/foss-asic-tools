#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

bash ./bootstrap.sh
cd build
ninja
mkdir -p /foss/tools/${NAME}/${REPO_COMMIT}/bin
cp padring /foss/tools/${NAME}/${REPO_COMMIT}/bin
