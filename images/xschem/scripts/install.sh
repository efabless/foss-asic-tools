#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$XSCHEM_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${XSCHEM_REPO_URL}" "${XSCHEM_NAME}"
cd "${XSCHEM_NAME}"
git checkout "${XSCHEM_REPO_COMMIT}"
./configure --prefix="${TOOLS}/${XSCHEM_NAME}/${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install
