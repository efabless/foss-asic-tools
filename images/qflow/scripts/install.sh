#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

./configure
cd src
make -j$(nproc) vlog2Verilog
mkdir -p /foss/tools/${NAME}/${REPO_COMMIT}/bin/
cp vlog2Verilog /foss/tools/${NAME}/${REPO_COMMIT}/bin/
