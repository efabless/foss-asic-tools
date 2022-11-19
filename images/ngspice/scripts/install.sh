#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$NGSPICE_REPO_COMMIT" | cut -c 1-7)

git clone "${NGSPICE_REPO_URL}" "${NGSPICE_NAME}"
cd "${NGSPICE_NAME}"
git checkout "${NGSPICE_REPO_COMMIT}"
./autogen.sh
./configure --disable-debug --enable-openmp --with-x --with-readline=yes --enable-pss --enable-xspice --with-fftw3=yes --prefix="/foss/tools/${NGSPICE_NAME}/${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install
