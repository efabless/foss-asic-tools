#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$QUCS_REPO_COMMIT" | cut -c 1-7)

git clone "$QUCS_REPO_URL" "$QUCS_NAME"
cd "$QUCS_NAME"
git checkout "$QUCS_REPO_COMMIT"
mkdir build && cd build
cmake ..  -DCMAKE_INSTALL_PREFIX="$TOOLS/$QUCS_NAME/$REPO_COMMIT_SHORT"
make -j"$(nproc)"
make install
