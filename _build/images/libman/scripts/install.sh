#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$LIBMAN_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${LIBMAN_REPO_URL}" "${LIBMAN_NAME}"
cd "${LIBMAN_NAME}"
git checkout "${LIBMAN_REPO_COMMIT}"
qmake libman.pro
make
mkdir -p "${TOOLS}/${LIBMAN_NAME}"
mv libman "${TOOLS}/${LIBMAN_NAME}"
