#!/bin/bash

set -e
set -u

REPO_COMMIT_SHORT=$(echo "$CVC_RV_REPO_COMMIT" | cut -c 1-7)

git clone "${CVC_RV_REPO_URL}" "${CVC_RV_NAME}"
cd "${CVC_RV_NAME}"
git checkout "${CVC_RV_REPO_COMMIT}"
autoreconf -vif
./configure --disable-nls --prefix="${TOOLS}/${CVC_RV_NAME}/${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install
