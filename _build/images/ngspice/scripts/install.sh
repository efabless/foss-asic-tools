#!/bin/bash

REPO_COMMIT_SHORT=$(echo "$NGSPICE_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${NGSPICE_REPO_URL}" "${NGSPICE_NAME}"
cd "${NGSPICE_NAME}"
git checkout "${NGSPICE_REPO_COMMIT}"
./autogen.sh
#FIXME 2nd run of autogen needed
set -e
./autogen.sh

# Define common compile options
NGSPICE_COMPILE_OPTS=("--disable-debug" "--enable-openmp" "--with-x" "--with-readline=yes" "--enable-pss" "--enable-xspice" "--with-fftw3=yes" "--enable-osdi")

# Compile ngspice executable
./configure "${NGSPICE_COMPILE_OPTS[@]}" --prefix="${TOOLS}/${NGSPICE_NAME}/${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install

# cleanup between builds to prevent strange missing symbols in libngspice.
make distclean

# Now compile lib
./configure "${NGSPICE_COMPILE_OPTS[@]}" --with-ngshared --prefix="${TOOLS}/${NGSPICE_NAME}/${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install
