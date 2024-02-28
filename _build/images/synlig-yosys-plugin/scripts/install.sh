#!/bin/bash

#set -e

# shellcheck disable=SC2010
YOSYS_VERSION=$(ls "${TOOLS}/yosys" | grep -v bin | grep -v share)

# shellcheck disable=SC2034
REPO_COMMIT_SHORT=$(echo "$SYNLIG_YOSYS_PLUGIN_REPO_COMMIT" | cut -c 1-7)
git clone --filter=blob:none "${SYNLIG_YOSYS_PLUGIN_REPO_URL}" "${SYNLIG_YOSYS_PLUGIN_NAME}"
cd "${SYNLIG_YOSYS_PLUGIN_NAME}"
git checkout "${SYNLIG_YOSYS_PLUGIN_REPO_COMMIT}"
git submodule sync
git submodule update --init --recursive third_party/{surelog,yosys}
make -j"$(nproc)" @systemverilog-plugin
mkdir -p "${TOOLS}_add/yosys/$YOSYS_VERSION/share/yosys/plugins"
cp out/current/share/yosys/plugins/systemverilog.so "${TOOLS}_add/yosys/$YOSYS_VERSION/share/yosys/plugins"
