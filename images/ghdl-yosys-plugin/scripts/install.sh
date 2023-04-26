#!/bin/bash

set -e

yosys_version=$(ls "${TOOLS}"/yosys/)
ghdl_version=$(ls "${TOOLS}"/ghdl/)

export PATH=$PATH:$TOOLS/yosys/$yosys_version/bin:$TOOLS/ghdl/$ghdl_version/bin

REPO_COMMIT_SHORT=$(echo "$GHDL_YOSYS_PLUGIN_REPO_COMMIT" | cut -c 1-7)

git clone "${GHDL_YOSYS_PLUGIN_REPO_URL}" "${GHDL_YOSYS_PLUGIN_NAME}"
cd "${GHDL_YOSYS_PLUGIN_NAME}"
git checkout "${GHDL_YOSYS_PLUGIN_REPO_COMMIT}"
make -j"$(nproc)"
mkdir -p "${TOOLS}_add/yosys/$yosys_version/share/yosys/plugins"
cp ghdl.so "${TOOLS}_add/yosys/$yosys_version/share/yosys/plugins"
