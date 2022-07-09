#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $VLOGTOVERILOG_REPO_COMMIT | cut -c 1-7)

git clone ${VLOGTOVERILOG_REPO_URL} ${VLOGTOVERILOG_NAME}
cd ${VLOGTOVERILOG_NAME}
git checkout ${VLOGTOVERILOG_REPO_COMMIT}
./configure
cd src
make -j$(nproc) vlog2Verilog
mkdir -p /foss/tools/${VLOGTOVERILOG_NAME}/${REPO_COMMIT_SHORT}/bin/
cp vlog2Verilog /foss/tools/${VLOGTOVERILOG_NAME}/${REPO_COMMIT_SHORT}/bin/
