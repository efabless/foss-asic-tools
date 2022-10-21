#!/bin/bash

# `-e` should not be set as something exits with an error code, but the run is still OK
#set -e

MAGIC_VERSION=$(ls /foss/tools/magic/)
export PATH=$PATH:/foss/tools/magic/$MAGIC_VERSION/bin
export SCRIPT_DIR=/foss/tools/iic-osic
export PDK_ROOT=/foss/pdk
# select version 'A', or 'B', or 'all'
SKY130_VERSION=all

cd $PDK_ROOT || exit
git clone "${OPEN_PDKS_REPO_URL}" "${OPEN_PDKS_NAME}"
cd "${OPEN_PDKS_NAME}" || exit
git checkout -qf "${OPEN_PDKS_REPO_COMMIT}"

./configure \
	--enable-sky130-pdk=$PDK_ROOT/skywater-pdk \
	--enable-alpha-sky130 \
	--enable-xschem-sky130 \
	--enable-sram-sky130 \
	--with-sky130-variants=$SKY130_VERSION \
	--datadir=/foss/

make -j"$(nproc)"
make install

if [ "$SKY130_VERSION" = "all" ]; then
	cp $PDK_ROOT/"$OPEN_PDKS_NAME"/sky130/sky130A_make.log $PDK_ROOT/sky130A
	cp $PDK_ROOT/"$OPEN_PDKS_NAME"/sky130/sky130B_make.log $PDK_ROOT/sky130B

	echo "$OPEN_PDKS_NAME $OPEN_PDKS_REPO_COMMIT"	> "$PDK_ROOT/sky130A/SOURCES"
	cat "$PDK_ROOT/skywater-pdk/SOURCES" 			>> "$PDK_ROOT/sky130A/SOURCES"
	cat "/foss/tools/magic/$MAGIC_VERSION/SOURCES" 	>> "$PDK_ROOT/sky130A/SOURCES"	
	cp "$PDK_ROOT/sky130A/SOURCES" "$PDK_ROOT/sky130B/SOURCES" 

	cd "$PDK_ROOT/sky130A/libs.tech/ngspice" || exit 1
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice tt
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ss
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ff

	cd "$PDK_ROOT/sky130B/libs.tech/ngspice" || exit 1
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice tt
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ss
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ff
else
	cp $PDK_ROOT/"$OPEN_PDKS_NAME"/sky130/sky130${SKY130_VERSION}_make.log $PDK_ROOT/sky130${SKY130_VERSION}
	echo "$OPEN_PDKS_NAME $OPEN_PDKS_REPO_COMMIT"	> "$PDK_ROOT/sky130${SKY130_VERSION}/SOURCES"
	cat "$PDK_ROOT/skywater-pdk/SOURCES" 			>> "$PDK_ROOT/sky130${SKY130_VERSION}/SOURCES"
	cat "/foss/tools/magic/$MAGIC_VERSION/SOURCES" 	>> "$PDK_ROOT/sky130${SKY130_VERSION}/SOURCES"

	cd "$PDK_ROOT/sky130${SKY130_VERSION}/libs.tech/ngspice" || exit 1
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice tt
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ss
	"$SCRIPT_DIR/iic-spice-model-red.py" sky130.lib.spice ff
fi

make veryclean

cd $PDK_ROOT || exit
rm -rf skywater-pdk open_pdks 
chmod -R 755 $PDK_ROOT
