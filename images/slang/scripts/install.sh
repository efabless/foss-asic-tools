#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$SLANG_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${SLANG_REPO_URL}" "${SLANG_NAME}"
cd "${SLANG_NAME}"
git checkout "${SLANG_REPO_COMMIT}"
cmake -B build -DSLANG_INCLUDE_TESTS=OFF
cmake --build build -j"$(nproc)"
cmake --install build --strip --prefix="${TOOLS}/${SLANG_NAME}/${REPO_COMMIT_SHORT}"
