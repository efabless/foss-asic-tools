#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$GTKWAVE_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${GTKWAVE_REPO_URL}" "${GTKWAVE_NAME}"
cd "${GTKWAVE_NAME}/gtkwave3-gtk3/"
git checkout "${GTKWAVE_REPO_COMMIT}"
./autogen.sh
./configure --prefix="${TOOLS}/${GTKWAVE_NAME}/${REPO_COMMIT_SHORT}" --enable-gtk3
make -j"$(nproc)"
make install
