#!/bin/bash

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


