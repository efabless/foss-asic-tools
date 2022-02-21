#!/bin/bash


############### 
pip install click pyyaml panda

###############
yum install -y libQt5Widgets.so*  
yum install -y libtclreadline-2.1.0.*
yum install -y hub


###############
mkdir -p /foss/designs
mkdir -p /foss/pdk

cp -a $TOOLS/sak/openlane/spef_extractor $TOOLS/

###############
mkdir -p /foss/tools/bin
cd    /foss/tools/bin
ln -s ../*/*/bin/* .

###############
groupmod -n designers games    
chown -R default:designers /headless
chown -R default:designers /foss/designs

###############
ln -s $TOOLS/xschem/*/* $TOOLS/xschem/

###############
mkdir $STARTUPDIR/logs


