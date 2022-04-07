#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

mkdir -p build
cd build
cmake ../src
make -j$(nproc)
mkdir -p /foss/tools/${NAME}/${REPO_COMMIT}/bin/
cp ispd19dr /foss/tools/${NAME}/${REPO_COMMIT}/bin/drcu
