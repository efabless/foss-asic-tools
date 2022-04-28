#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $QFLOW_REPO_COMMIT | cut -c 1-7)

git clone ${QFLOW_REPO_URL} ${QFLOW_NAME}
cd ${QFLOW_NAME}
git checkout ${QFLOW_REPO_COMMIT}
./configure
cd src
make -j$(($(nproc) / 2)) vlog2Verilog
mkdir -p /foss/tools/${QFLOW_NAME}/${REPO_COMMIT_SHORT}/bin/
cp vlog2Verilog /foss/tools/${QFLOW_NAME}/${REPO_COMMIT_SHORT}/bin/
