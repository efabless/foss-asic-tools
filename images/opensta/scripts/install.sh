#!/bin/bash

source scl_source enable devtoolset-8


mkdir -p /foss/tools/
git clone ${REPO_URL} /foss/tools/${NAME}/${REPO_COMMIT}
cd /foss/tools/${NAME}/${REPO_COMMIT}

git checkout ${REPO_COMMIT}

mkdir build
cd build
cmake ..
make -j$(nproc)
cd ..
mkdir bin
cp app/sta bin
