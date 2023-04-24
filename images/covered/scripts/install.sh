#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$COVERED_REPO_COMMIT" | cut -c 1-7)

git clone "${COVERED_REPO_URL}" "${COVERED_NAME}"
cd "${COVERED_NAME}"
git checkout "${COVERED_REPO_COMMIT}"
./configure --prefix="${TOOLS}/${COVERED_NAME}/${REPO_COMMIT_SHORT}"
make # -j$(nproc) Using -j option leads to random fails on many-core machines
make install
