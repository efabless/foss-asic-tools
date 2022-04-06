#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}/gtkwave3-gtk3/

git checkout ${REPO_COMMIT}

./autogen.sh
#FIXME Need to disable TCL due to compile error
./configure --prefix=/foss/tools/${NAME}/${REPO_COMMIT} --enable-gtk3 --disable-tcl
make -j$(nproc)
make install
