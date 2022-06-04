#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $IVERILOG_REPO_COMMIT | cut -c 1-7)

git clone ${IVERILOG_REPO_URL} ${IVERILOG_NAME}
cd ${IVERILOG_NAME}
git checkout ${IVERILOG_REPO_COMMIT}
chmod +x autoconf.sh
./autoconf.sh
./configure --prefix=/foss/tools/${IVERILOG_NAME}/${REPO_COMMIT_SHORT}
make -j$(nproc)
make install
