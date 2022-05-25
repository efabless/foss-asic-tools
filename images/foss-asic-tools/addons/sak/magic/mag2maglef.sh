#!/bin/sh
export MAGIC=/ef/apps/ocd/magic/8.3.179-202106141345/bin/magic
export MAGTYPE=maglef; 
export PDKPATH=$PDK_ROOT/sky130A ; 
export PROJECT_ROOT=~/foss/designs/caravel.mpw-one-final-metal-fix


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

#extract style ngspice()
extract do local
extract all			    
feedback save ${1%.mag}.ext.tcl
ext2spice lvs			    
ext2spice -o ${1%.mag}.maglef.lay.spice

#########

quit -noprompt
EOF

\rm ../maglef/*.ext

#\cp ${1%.mag}.maglef.lay.spice ../spi/lvs/${1%.mag}.spice
#\mv ${1%.mag}.maglef.lay.spice ../lvs/${1%.mag}/${1%.mag}.spice

# feedback save ${1%.mag}.ext.tcl
# snap int
# source 	${1%.mag}.ext.tcl

## extract style ngspice()	;# styles/extract: ngspice() --> with subckts, ngspice(orig) --> explicit M for transistors, ngspice(si) <<- DO NOT USE si 

## ext2spice lvs			    ;# = all the steps commented below
#########ext2spice blackbox on	    ;# detects MAGTYPE=maglef files and netlists them as blackbox
#########ext2spice global off
# ext2spice -o ${1%.mag}.maglef.lay.spice
