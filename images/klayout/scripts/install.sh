#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$KLAYOUT_REPO_COMMIT" | cut -c 1-7)

git clone "${KLAYOUT_REPO_URL}" "${KLAYOUT_NAME}"
cd "${KLAYOUT_NAME}"
git checkout "${KLAYOUT_REPO_COMMIT}"
prefix=${TOOLS}/${KLAYOUT_NAME}/${REPO_COMMIT_SHORT}
mkdir -p "$prefix"
./build.sh -j"$(nproc)" -prefix "$prefix" -without-qtbinding
