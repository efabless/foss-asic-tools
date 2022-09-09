#!/bin/bash

set -e

yosys_version=$(ls /foss/tools/yosys/)
ghdl_version=$(ls /foss/tools/ghdl/)

export PATH=$PATH:/foss/tools/yosys/$yosys_version/bin:/foss/tools/ghdl/$ghdl_version/bin

REPO_COMMIT_SHORT=$(echo $GHDL_YOSYS_PLUGIN_REPO_COMMIT | cut -c 1-7)

git clone ${GHDL_YOSYS_PLUGIN_REPO_URL} ${GHDL_YOSYS_PLUGIN_NAME}
cd ${GHDL_YOSYS_PLUGIN_NAME}
git checkout ${GHDL_YOSYS_PLUGIN_REPO_COMMIT}
make -j$(nproc)
mkdir -p /foss/tools_add/yosys/$yosys_version/share/yosys/plugins
cp ghdl.so /foss/tools_add/yosys/$yosys_version/share/yosys/plugins
