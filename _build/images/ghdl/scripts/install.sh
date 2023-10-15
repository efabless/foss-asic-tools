#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$GHDL_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${GHDL_REPO_URL}" "${GHDL_NAME}"
cd "${GHDL_NAME}"
git checkout "${GHDL_REPO_COMMIT}"

# LLVM compile (needs LLVM<15)
./configure  --with-llvm-config --prefix="${TOOLS}/${GHDL_NAME}/${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install
