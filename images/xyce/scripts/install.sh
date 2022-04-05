#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}
./bootstrap

git clone https://github.com/trilinos/Trilinos trilinos
cd trilinos
git checkout trilinos-release-12-12-1
mkdir -p parallel_build && cd parallel_build
cp /trilinos.reconfigure.sh ./reconfigure
chmod +x reconfigure
./reconfigure
make -j$(nproc)
make install

cd /${NAME}
mkdir -p parallel_build && cd parallel_build
cp /xyce.reconfigure.sh ./reconfigure
chmod +x reconfigure
./reconfigure
make -j$(nproc)
make install

