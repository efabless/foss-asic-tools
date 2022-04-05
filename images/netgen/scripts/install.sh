#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}

cd ${NAME}
git checkout ${REPO_COMMIT}

./configure CFLAGS="-O2 -g" --prefix=/foss/tools/${NAME}/${REPO_COMMIT}
make clean
make -j$(nproc)
make install

