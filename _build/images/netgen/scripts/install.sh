#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$NETGEN_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${NETGEN_REPO_URL}" "${NETGEN_NAME}"
cd "${NETGEN_NAME}"
git checkout "${NETGEN_REPO_COMMIT}"
./configure CFLAGS="-O2 -g" --prefix="${TOOLS}/${NETGEN_NAME}/${REPO_COMMIT_SHORT}"
make clean
make -j"$(nproc)"
make install
