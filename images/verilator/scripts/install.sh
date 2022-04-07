#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}
autoconf
unset VERILATOR_ROOT
./configure --prefix=/foss/tools/${NAME}/${REPO_COMMIT}
make -j$(nproc)
make install