#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$VERILATOR_REPO_COMMIT" | cut -c 1-7)

git clone "${VERILATOR_REPO_URL}" "${VERILATOR_NAME}"
cd "${VERILATOR_NAME}"
git checkout "${VERILATOR_REPO_COMMIT}"
autoconf
unset VERILATOR_ROOT
./configure --prefix="/foss/tools/${VERILATOR_NAME}/${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install
