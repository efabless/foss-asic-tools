#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

git clone ${XYCE_REPO_URL} ${XYCE_NAME}
cd ${XYCE_NAME}
git checkout ${XYCE_REPO_COMMIT}
./bootstrap

git clone https://github.com/trilinos/Trilinos trilinos
cd trilinos
git checkout trilinos-release-12-12-1
mkdir -p parallel_build && cd parallel_build
cp /trilinos.reconfigure.sh ./reconfigure
chmod +x reconfigure
./reconfigure
make -j$(($(nproc) / 2))
make install

cd /${XYCE_NAME}
mkdir -p parallel_build && cd parallel_build
cp /xyce.reconfigure.sh ./reconfigure
chmod +x reconfigure
./reconfigure
make -j$(($(nproc) / 2))
make install
