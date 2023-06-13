#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$VERILATOR_REPO_COMMIT" | cut -c 1-7)

git clone "${VERILATOR_REPO_URL}" "${VERILATOR_NAME}"
cd "${VERILATOR_NAME}"
git checkout "${VERILATOR_REPO_COMMIT}"
autoconf
unset VERILATOR_ROOT
./configure --prefix="${TOOLS}/${VERILATOR_NAME}/${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install

# FIXME a WA is needed for OpenLane, otherwise the flow crashes
# see https://github.com/The-OpenROAD-Project/OpenLane/issues/1811 and
# https://github.com/The-OpenROAD-Project/OpenLane/blob/791366fed781bd6480fdc574cd5ee6a25e1838b3/docker/verilator/Dockerfile
rm "${TOOLS}/${VERILATOR_NAME}/${REPO_COMMIT_SHORT}/share/verilator/include/verilated_std.sv" && \
touch "${TOOLS}/${VERILATOR_NAME}/${REPO_COMMIT_SHORT}/share/verilator/include/verilated_std.sv"
