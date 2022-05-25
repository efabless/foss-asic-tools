#!/bin/bash
#

########################################################
###### Magic netlist extraction
########################################################

export MAGIC=magic
export PDKPATH=$PDK_ROOT/sky130A ; 
export MAGTYPE=$2

$MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/sky130A.magicrc  << EOF

path
##########
drc off
load $1 -dereference
select top cell
expand
port makeall
##########
select top cell
extract do local
extract all
ext2spice lvs
	    
ext2spice -o ${1%.mag}-extracted-${MAGTYPE}-no-rc.spice

EOF

#########

\rm *.ext


#ext2spice renumber off          ;# renumbers the subcircuit instances
#ext2spice subcircuit top auto
#ext2spice cthresh infinite
#ext2spice rthresh infinite
#ext2spice blackbox on   
