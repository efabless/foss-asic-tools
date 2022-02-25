#!/bin/bash

source scl_source enable devtoolset-8

magic_version=$(ls /foss/tools/magic/ )
export PATH=$PATH:/foss/tools/magic/$magic_version/bin/

export PDK_ROOT=/foss/pdk

cd $PDK_ROOT 
git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout master
git pull
git checkout -qf ${REPO_COMMIT}

./configure --enable-sky130-pdk=$PDK_ROOT/skywater-pdk  --enable-alpha-sky130 --enable-xschem-sky130 \
            --enable-sram-sky130 --with-sky130-variants=all --datadir=/foss/
	    
make -j$(nproc)
make install
make distclean

cd $PDK_ROOT 
rm -rf skywater-pdk open_pdks 
#\rm -rf skywater-pdk open_pdks share

