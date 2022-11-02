#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$GTKWAVE_REPO_COMMIT" | cut -c 1-7)

git clone "${GTKWAVE_REPO_URL}" "${GTKWAVE_NAME}"
cd "${GTKWAVE_NAME}/gtkwave3-gtk3/"
git checkout "${GTKWAVE_REPO_COMMIT}"
./autogen.sh
#FIXME we need to disable TCL due to compile error on aarch64
./configure --prefix="/foss/tools/${GTKWAVE_NAME}/${REPO_COMMIT_SHORT}" --enable-gtk3 --disable-tcl
make -j"$(nproc)"
make install
