#!/bin/bash

#source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}/gtkwave3-gtk3/

git checkout ${REPO_COMMIT}

./autogen.sh
./configure --prefix=/foss/tools/${NAME}/${REPO_COMMIT} --enable-gtk3
make -j$(nproc)
make install
