#!/bin/bash

set -e
source scl_source enable gcc-toolset-11

magic_version=$(ls /foss/tools/magic/)
export PATH=$PATH:/foss/tools/magic/$magic_version/bin

export PDK_ROOT=/foss/pdk
# select version 'A', or 'B', or 'all'
export SKY130_VERSION=A

cd $PDK_ROOT
git clone ${OPEN_PDKS_REPO_URL} ${OPEN_PDKS_NAME}
cd ${OPEN_PDKS_NAME}
git checkout -qf ${OPEN_PDKS_REPO_COMMIT}

./configure \
	--enable-sky130-pdk=$PDK_ROOT/skywater-pdk \
       	--enable-alpha-sky130 \
	--enable-xschem-sky130 \
	--enable-sram-sky130 \
	--with-sky130-variants=$SKY130_VERSION \
	--datadir=/foss/

make -j$(nproc)
make install

cp $PDK_ROOT/$OPEN_PDKS_NAME/sky130/sky130${SKY130_VERSION}_make.log $PDK_ROOT/sky130${SKY130_VERSION}

echo "$OPEN_PDKS_NAME $OPEN_PDKS_REPO_COMMIT" 	> "$PDK_ROOT/sky130${SKY130_VERSION}/SOURCES"
cat "$PDK_ROOT/skywater-pdk/SOURCES" 		>> "$PDK_ROOT/sky130${SKY130_VERSION}/SOURCES"
cat "/foss/tools/magic/$magic_version/SOURCES" 	>> "$PDK_ROOT/sky130${SKY130_VERSION}/SOURCES"

make veryclean

cd $PDK_ROOT 
rm -rf skywater-pdk open_pdks 
chmod -R 755 $PDK_ROOT
