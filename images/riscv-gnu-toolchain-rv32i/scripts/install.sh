#!/bin/bash

source scl_source enable devtoolset-8

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

git submodule update --init --recursive
mkdir build
cd build
../configure --with-arch=rv32ia --prefix=/foss/tools/${NAME}/${REPO_COMMIT}
make linux -j$(nproc)
