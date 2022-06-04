#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $RV_TOOLCHAIN_REPO_COMMIT | cut -c 1-7)

git clone ${RV_TOOLCHAIN_REPO_URL} ${RV_TOOLCHAIN_NAME}
cd ${RV_TOOLCHAIN_NAME}
git checkout ${RV_TOOLCHAIN_REPO_COMMIT}
git submodule update --init --recursive
mkdir build
cd build
../configure --with-arch=rv32ia --prefix=/foss/tools/${RV_TOOLCHAIN_NAME}/${REPO_COMMIT_SHORT}
make linux -j$(nproc)
