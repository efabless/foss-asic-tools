#!/bin/bash


############### Openlane / openroad

pip install click pyyaml panda

yum install -y libQt5Widgets.so*  
yum install -y libtclreadline-2.1.0.*


###############

mkdir -p $DESIGNS
chmod -R 777 $DESIGNS
mkdir -p /foss/pdks
mkdir -p /foss/tools/bin
cd    /foss/tools/bin
ln -s ../*/*/bin/* .


ln -s $TOOLS/xschem/*/* $TOOLS/xschem/

groupmod -n designers games    

chown -R default:designers /headless


mkdir $STARTUPDIR/logs


