#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$PADRING_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${PADRING_REPO_URL}" "${PADRING_NAME}"
cd "${PADRING_NAME}"
git checkout "${PADRING_REPO_COMMIT}"
bash ./bootstrap.sh
cd build
ninja
mkdir -p "${TOOLS}/${PADRING_NAME}/${REPO_COMMIT_SHORT}/bin"
cp padring "${TOOLS}/${PADRING_NAME}/${REPO_COMMIT_SHORT}/bin"
