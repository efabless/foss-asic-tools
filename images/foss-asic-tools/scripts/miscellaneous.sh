#!/bin/bash

###############

mkdir -p $DESIGNS
chmod -R 777 $DESIGNS
mkdir -p /foss/pdks
mkdir -p /foss/tools/bin
cd    /foss/tools/bin
ln -s ../*/*/bin/* .


mkdir $STARTUPDIR/logs


###############

cd /foss/pdks
ln -s ../tools/xschem/*/share xschem-share
ln -s ../tools/xschem/*/share/xschem/xschem_library .

###############

