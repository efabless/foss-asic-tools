#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$YOSYS_REPO_COMMIT" | cut -c 1-7)

git clone "${YOSYS_REPO_URL}" "${YOSYS_NAME}"
cd "${YOSYS_NAME}"
git checkout "${YOSYS_REPO_COMMIT}"
make PREFIX="/foss/tools/${YOSYS_NAME}/${REPO_COMMIT_SHORT}" config-gcc
make PREFIX="/foss/tools/${YOSYS_NAME}/${REPO_COMMIT_SHORT}" -j"$(nproc)"
make PREFIX="/foss/tools/${YOSYS_NAME}/${REPO_COMMIT_SHORT}" install
