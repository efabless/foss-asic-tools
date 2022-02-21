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
            --enable-sram-sky130 --with-sky130-variants=all --datadir=$PDK_ROOT/../
	    
make -j$(nproc)
make install
make distclean


#touch $pdk_path/sky130A/SOURCES	
#printf "skywater-pdk " >> $pdk_path/sky130A/SOURCES	
#cd $pdk_path/skywater-pdk && git rev-parse HEAD >> $pdk_path/sky130A/SOURCES	
#printf "open_pdks " >> $pdk_path/sky130A/SOURCES	
#cd $pdk_path/open_pdks && git rev-parse HEAD >> $pdk_path/sky130A/SOURCES	
#printf "magic $magic_version" >> $pdk_path/sky130A/SOURCES

#cp $pdk_path/sky130A/SOURCES $pdk_path/sky130B/SOURCES 

cd $PDK_ROOT 
rm -rf skywater-pdk open_pdks 
#\rm -rf skywater-pdk open_pdks share

