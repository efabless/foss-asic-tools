#!/bin/bash

set -e

export LC_ALL=en_US.utf8 && export LANG=en_US.utf8
export SCRIPT_DIR=/foss/tools/iic-osic

if [ ! -d "$PDK_ROOT" ]; then
    mkdir -p "$PDK_ROOT"
fi

volare enable "${OPEN_PDKS_REPO_COMMIT}"

# apply SPICE mode file reduction (for the variants that exist)
# add custom IIC bind keys to magicrc

if [ -d "$PDK_ROOT/sky130A" ]; then
    cd "$PDK_ROOT/sky130A/libs.tech/ngspice" || exit 1
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice tt
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ss
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ff

    echo "# Custom bindkeys for IIC" 		        >> "$PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc"
    echo "source $SCRIPT_DIR/iic-magic-bindkeys" 	>> "$PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc"
fi

if [ -d "$PDK_ROOT/sky130B" ]; then
	cd "$PDK_ROOT/sky130B/libs.tech/ngspice" || exit 1
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice tt
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ss
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ff

    echo "# Custom bindkeys for IIC" 		        >> "$PDK_ROOT/sky130B/libs.tech/magic/sky130B.magicrc"
    echo "source $SCRIPT_DIR/iic-magic-bindkeys" 	>> "$PDK_ROOT/sky130B/libs.tech/magic/sky130B.magicrc"
fi

# FIXME Remove extra large dirs until fix is rolled into open_pdks
rm -rf /foss/pdks/volare/sky130/versions/*/*/libs.tech/klayout/lvs/testing
rm -rf /foss/pdks/volare/sky130/versions/*/*/libs.tech/xschem/decred_hash_macro
