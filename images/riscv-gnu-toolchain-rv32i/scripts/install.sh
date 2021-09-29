#!/bin/bash

source scl_source enable devtoolset-8

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

git submodule update --init --recursive
mkdir build
cd build
../configure --with-arch=rv32i --prefix=/foss/tools/${NAME}/${REPO_COMMIT}
make -j$(nproc)
