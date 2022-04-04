#!/usr/bin/env bash
set -e

echo "Add OpenLane version to SOURCES"

export PDK_ROOT=/foss/pdk
export PDK=sky130A
export PDKPATH=$PDK_ROOT/$PDK

printf "openlane " >> "$PDKPATH/SOURCES"
cd "$TOOLS/openlane" && git rev-parse HEAD >> "$PDKPATH/SOURCES"
