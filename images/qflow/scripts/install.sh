#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$QFLOW_REPO_COMMIT" | cut -c 1-7)

git clone "${QFLOW_REPO_URL}" "${QFLOW_NAME}"
cd "${QFLOW_NAME}"
git checkout "${QFLOW_REPO_COMMIT}"
./configure
cd src
make vlog2Verilog && make vlog2Spice
mkdir -p "${TOOLS}/${QFLOW_NAME}/${REPO_COMMIT_SHORT}/bin/"
cp vlog2Verilog "${TOOLS}/${QFLOW_NAME}/${REPO_COMMIT_SHORT}/bin/"
cp vlog2Spice "${TOOLS}/${QFLOW_NAME}/${REPO_COMMIT_SHORT}/bin/"
cd ../scripts
make spi2xspice.py
chmod +x spi2xspice.py
cp spi2xspice.py "${TOOLS}/${QFLOW_NAME}/${REPO_COMMIT_SHORT}/bin/"
