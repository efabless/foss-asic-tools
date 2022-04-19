#!/usr/bin/env bash
# Harald Pretl, IIC, JKU
set -e

echo "Add custom bindkeys to magicrc"

export PDK_ROOT=/foss/pdk
export PDK=sky130A
export PDKPATH=$PDK_ROOT/$PDK
export SCRIPT_DIR=/foss/tools/iic-osic

echo "# Custom bindkeys for IIC" 		>> "$PDKPATH/libs.tech/magic/$PDK.magicrc"
echo "source $SCRIPT_DIR/iic-magic-bindkeys" 	>> "$PDKPATH/libs.tech/magic/$PDK.magicrc"

