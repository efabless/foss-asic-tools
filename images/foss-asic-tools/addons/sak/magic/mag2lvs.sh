#!/bin/sh

: ${PDK_ROOT?"You need to set PDK_ROOT valiable to run this script"}

export MAGIC=/ef/apps/ocd/magic/8.3.182-202106232141/bin/magic

export MAGTYPE=mag; 
export PDKPATH=$PDK_ROOT/sky130A ; 

$MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/sky130A.magicrc  <<EOF

#########

addpath ${PDKPATH}/libs.ref/sky130_ml_xx_hd/mag
addpath ./hexdigits
path

#########

drc off
load $1 -dereference
select top cell
expand

#########

extract do local
extract all
feedback save ${1%.mag}.ext.tcl
ext2spice lvs
ext2spice -o ${1%.mag}.spice

#########

quit -noprompt
EOF

\rm ../mag*/*.ext*
##\mv ${1%.mag}.spice ../lvs/${1%.mag}/
##\cp ../lvs/${1%.mag}/${1%.mag}.spice ../spi/lvs/${1%.mag}.spice


