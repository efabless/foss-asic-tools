#!/bin/bash

set -e
source scl_source enable gcc-toolset-11

REPO_COMMIT_SHORT=$(echo $GTKWAVE_REPO_COMMIT | cut -c 1-7)

git clone ${GTKWAVE_REPO_URL} ${GTKWAVE_NAME}
cd ${GTKWAVE_NAME}/gtkwave3-gtk3/
git checkout ${GTKWAVE_REPO_COMMIT}
./autogen.sh
#FIXME Need to disable TCL due to compile error
./configure --prefix=/foss/tools/${GTKWAVE_NAME}/${REPO_COMMIT_SHORT} --enable-gtk3 --disable-tcl
make -j$(nproc)
make install
