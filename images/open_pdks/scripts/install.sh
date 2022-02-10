#!/bin/bash

source scl_source enable devtoolset-8

magic_version=$(ls /foss/tools/magic/ )
export PATH=$PATH:/foss/tools/magic/$magic_version/bin/

pdk_path=/foss/pdks/
cd $pdk_path
git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout master
git pull
git checkout -qf ${REPO_COMMIT}

##./configure --enable-sky130-pdk=$pdk_path/skywater-pdk/libraries --enable-sram-sky130="disabled"

./configure --enable-sky130-pdk=$pdk_path/skywater-pdk/libraries --enable-alpha-sky130 --enable-xschem-sky130 \
            --enable-sram-sky130 --with-sky130-variants= all --datadir=$pdk_path

cd sky130
make veryclean
make prerequisites
make -j$(nproc)
make SHARED_PDKS_PATH=$pdk_path install
make clean

cd $pdk_path
#\rm -rf skywater-pdk open_pdks share

