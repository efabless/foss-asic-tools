#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $GHDL_REPO_COMMIT | cut -c 1-7)

git clone ${GHDL_REPO_URL} ${GHDL_NAME}
cd ${GHDL_NAME}
git checkout ${GHDL_REPO_COMMIT}
./configure  --with-llvm-config --prefix=/foss/tools/${GHDL_NAME}/${REPO_COMMIT_SHORT}
make -j$(($(nproc) / 2))
make install
