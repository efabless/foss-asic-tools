#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$GAW3_XSCHEM_REPO_COMMIT" | cut -c 1-7)

git clone "${GAW3_XSCHEM_REPO_URL}" "${GAW3_XSCHEM_NAME}"
cd "${GAW3_XSCHEM_NAME}"
git checkout "${GAW3_XSCHEM_REPO_COMMIT}"
chmod +x configure
autoreconf -f -i
./configure --prefix="/foss/tools/${GAW3_XSCHEM_NAME}/${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install
