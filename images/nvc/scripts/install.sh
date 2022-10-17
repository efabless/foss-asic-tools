#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$NVC_REPO_COMMIT" | cut -c 1-7)

git clone "${NVC_REPO_URL}" "${NVC_NAME}"
cd "${NVC_NAME}"
git checkout "${NVC_REPO_COMMIT}"
./autogen.sh
mkdir build && cd build
../configure --prefix=/foss/tools/"${NVC_NAME}"/"${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install
