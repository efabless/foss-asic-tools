#!/bin/bash


pip install click pyyaml

yum install -y libQt5Widgets.so*  libtclreadline-2.1.0.*

export LC_ALL=en_US.utf-8 && export LANG=en_US.utf-8

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


