#!/bin/bash

source scl_source enable gcc-toolset-9

set -e
set -u

REPO_COMMIT_SHORT=$(echo $CVC_CHECK_REPO_COMMIT | cut -c 1-7)

git clone ${CVC_CHECK_REPO_URL} ${CVC_CHECK_NAME}
cd ${CVC_CHECK_NAME}
git checkout ${CVC_CHECK_REPO_COMMIT}
autoreconf -i
./configure --disable-nls --prefix=/foss/tools/${CVC_CHECK_NAME}/${REPO_COMMIT_SHORT}
make -j$(($(nproc) / 2))
make install
