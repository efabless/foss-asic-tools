#!/bin/bash

source scl_source enable gcc-toolset-9

magic_version=$(ls /foss/tools/magic/ )
export PATH=$PATH:/foss/tools/magic/$magic_version/bin/

export PDK_ROOT=/foss/pdk
export SKY130_VERSION=A

cd $PDK_ROOT 
git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout master
git pull
git checkout -qf ${REPO_COMMIT}git clone https://github.com/RTimothyEdwards/open_pdks.git

./configure --enable-sky130-pdk=$PDK_ROOT/skywater-pdk  --enable-alpha-sky130 --enable-xschem-sky130 \
            --enable-sram-sky130 --with-sky130-variants=$SKY130_VERSION --datadir=/foss/
	    
#make -j$(nproc)
#make install
make -j$(nproc)
make install

echo "$NAME $REPO_COMMIT" 		> "$PDK_ROOT/sky130$SKY130_VERSION/SOURCES"
echo "magic $magic_version" 		>> "$PDK_ROOT/sky130$SKY130_VERSION/SOURCES"
cat "$PDK_ROOT/skywater-pdk/SOURCES" 	>> "$PDK_ROOT/sky130$SKY130_VERSION/SOURCES"

make distclean

cd $PDK_ROOT 
rm -rf skywater-pdk open_pdks 
chmod -R 755 $PDK_ROOT 

