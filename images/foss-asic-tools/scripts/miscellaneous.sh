#!/bin/bash

source scl_source enable gcc-toolset-9

############### 
yum install -y python3-pyyaml python3-click
pip3 install panda

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
ln -s $TOOLS/xschem/*/* $TOOLS/xschem/

###############
cp /foss/tools/openlane/2022.04.07_02.53.08/dependencies/tool_metadata.yml /

###############
mkdir $STARTUPDIR/logs

###############
# Set /usr/bin/python3 to provide "/usr/bin/python"
update-alternatives --set python /usr/bin/python3

###############
groupmod -n designers games    
chown -R 1000:designers /headless
chown -R 1000:designers /foss/designs


