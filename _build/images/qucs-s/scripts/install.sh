#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$QUCS_S_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "$QUCS_S_REPO_URL" "$QUCS_S_NAME"
cd "$QUCS_S_NAME"
git checkout "$QUCS_S_REPO_COMMIT"
mkdir build && cd build
cmake ..  -DCMAKE_INSTALL_PREFIX="$TOOLS/$QUCS_S_NAME/$REPO_COMMIT_SHORT"
make -j"$(nproc)"
make install
