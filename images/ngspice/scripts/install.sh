#!/bin/bash

source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $REPO_COMMIT | cut -c 1-7)

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}
./autogen.sh
#FIXME 2nd run of autogen needed
set -e
./autogen.sh
./configure --disable-debug --enable-openmp --with-x --with-readline=no --enable-xspice --with-fftw3=yes --prefix=/foss/tools/${NAME}/${REPO_COMMIT_SHORT}
make -j$(nproc) 
make install
