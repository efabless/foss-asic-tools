#!/usr/bin/env bash
set -e

echo "Add OpenLane version to SOURCES"

PDK_ROOT=/foss/pdk
PDK=sky130A
PDKPATH=$PDK_ROOT/$PDK

printf "openlane " >> $(PDKPATH)/SOURCES
cd "$TOOLS/openlane" && git rev-parse HEAD >> $(PDKPATH)/SOURCES
