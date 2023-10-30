#!/bin/bash

set -e

# shellcheck disable=SC2010
YOSYS_VERSION=$(ls "${TOOLS}/yosys" | grep -v bin | grep -v share)
GHDL_VERSION=$(ls "${TOOLS}/ghdl")
export PATH="$PATH:$TOOLS/yosys/$YOSYS_VERSION/bin:$TOOLS/ghdl/$GHDL_VERSION/bin"
echo "PATH=$PATH"

# shellcheck disable=SC2034
REPO_COMMIT_SHORT=$(echo "$GHDL_YOSYS_PLUGIN_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${GHDL_YOSYS_PLUGIN_REPO_URL}" "${GHDL_YOSYS_PLUGIN_NAME}"
cd "${GHDL_YOSYS_PLUGIN_NAME}"
git checkout "${GHDL_YOSYS_PLUGIN_REPO_COMMIT}"
make -j"$(nproc)"
mkdir -p "${TOOLS}_add/yosys/$YOSYS_VERSION/share/yosys/plugins"
cp ghdl.so "${TOOLS}_add/yosys/$YOSYS_VERSION/share/yosys/plugins"
