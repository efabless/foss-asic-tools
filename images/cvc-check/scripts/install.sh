#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

autoreconf -i
./configure --disable-nls --prefix=/foss/tools/${NAME}/${REPO_COMMIT}
make -j$(nproc)
make install
