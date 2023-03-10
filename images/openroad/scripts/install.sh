#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$OPENROAD_APP_REPO_COMMIT" | cut -c 1-7)

git clone "${OPENROAD_APP_REPO_URL}" "${OPENROAD_APP_NAME}"
cd "${OPENROAD_APP_NAME}"
git checkout "${OPENROAD_APP_REPO_COMMIT}"
git submodule update --init --recursive

#FIXME remove -m64 option in par, otherwise build fails on arm64
sed -i 's/-m64 //g' src/par/CMakeLists.txt

mkdir -p build && cd build
cmake .. "-DCMAKE_INSTALL_PREFIX=/foss/tools/${OPENROAD_APP_NAME}/${REPO_COMMIT_SHORT}" "-DUSE_SYSTEM_BOOST=ON"
make -j"$(nproc)"
make install
