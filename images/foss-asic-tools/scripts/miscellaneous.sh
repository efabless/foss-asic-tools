#!/bin/bash


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
mkdir $STARTUPDIR/logs

###############
cd /tmp
wget --no-verbose https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
tar xvf Python-3.10.0.tgz
cd Python-3.10.0
./configure --with-system-ffi --with-computed-gotos --enable-loadable-sqlite-extensions 
make -j$(nproc)
make altinstall
cd /tmp
rm -rf Python-3.10.0*


###############
groupmod -n designers games    
chown -R 1000:designers /headless
chown -R 1000:designers /foss/designs


