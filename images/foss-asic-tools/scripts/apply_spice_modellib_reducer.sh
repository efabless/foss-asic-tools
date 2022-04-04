#!/usr/bin/env bash
set -e

echo "Apply SPICE model library reducer"

export PDK_ROOT=/foss/pdk
export PDK=sky130A
export PDKPATH=$PDK_ROOT/$PDK
export SCRIPT_DIR=/foss/tools/iic-osic

cd "$PDKPATH/libs.tech/ngspice" || exit
"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice tt
"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ss
"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ff

