#!/bin/sh
export MAGIC=/ef/apps/ocd/magic/8.3.179-202106141345/bin/magic
export MAGTYPE=maglef; 
export PDKPATH=$PDK_ROOT/sky130A ; 


MAGTYPE=maglef $MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/sky130A.magicrc  <<EOF


#########

path search [concat "../$MAGTYPE" [path search]]
addpath ${PDKPATH}/libs.ref/sky130_ml_xx_hd/mag
addpath ../mag/hexdigits
###addpath ../mag/

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
ext2spice -o ${1%.mag}.maglef.spice

#########

quit -noprompt
EOF

\rm ../mag*/*.ext*
\mv ${1%.mag}.maglef.spice ../lvs/${1%.mag}/${1%.mag}.spice
##\cp ../lvs/${1%.mag}/${1%.mag}.spice ../spi/lvs/${1%.mag}.spice

