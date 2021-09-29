#!/bin/sh

#---------------- Setting up the PDK: skywater-pdk

export PDK_ROOT=~/foss/pdks
cd $PDK_ROOT
git clone https://github.com/google/skywater-pdk.git
cd skywater-pdk

git checkout master

git submodule update --init libraries/sky130_fd_sc_hd/latest
git submodule update --init libraries/sky130_fd_sc_hvl/latest
git submodule update --init libraries/sky130_fd_sc_hs/latest
git submodule update --init libraries/sky130_fd_sc_ms/latest
git submodule update --init libraries/sky130_fd_sc_ls/latest
git submodule update --init libraries/sky130_fd_sc_hdll/latest
git submodule update --init libraries/sky130_fd_io/latest
git submodule update --init libraries/sky130_fd_pr/latest
git submodule update
make -j 8 timing

#---------------- OpenPDKs

cd $PDK_ROOT
git clone https://github.com/RTimothyEdwards/open_pdks.git
## git clone git://opencircuitdesign.com/open_pdks 
cd open_pdks
./configure --enable-sky130-pdk=$PDK_ROOT/skywater-pdk --with-sky130-local-path=$PDK_ROOT --enable-alpha-sky130 --enable-xschem-sky130
make
make install

#----------------
