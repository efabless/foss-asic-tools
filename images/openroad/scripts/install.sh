#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$OPENROAD_APP_REPO_COMMIT" | cut -c 1-7)

git clone "${OPENROAD_APP_REPO_URL}" "${OPENROAD_APP_NAME}"
cd "${OPENROAD_APP_NAME}"
git checkout "${OPENROAD_APP_REPO_COMMIT}"
git submodule update --init --recursive

# FIXME WA for OpenSTA segfault (will be fixed in OpenROAD later), see https://github.com/The-OpenROAD-Project/OpenLane/issues/1739
cd src/sta && curl -L https://github.com/jjcherry56/OpenSTA/commit/974d9f43e7ba15a56f8534b36d7a107ef690602d.diff | patch --strip=1 
cd ../..

mkdir -p build && cd build
cmake .. "-DCMAKE_INSTALL_PREFIX=/foss/tools/${OPENROAD_APP_NAME}/${REPO_COMMIT_SHORT}" "-DUSE_SYSTEM_BOOST=ON"
make -j"$(nproc)"
make install
