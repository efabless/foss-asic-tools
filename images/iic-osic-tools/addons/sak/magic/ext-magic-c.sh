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
drc off
load $1  
select top cell
extract do local
extract all
ext2sim labels on
ext2sim
#extresist tolerance 10
#extresist
ext2spice lvs
ext2spice cthresh 0
#ext2spice extresist on
ext2spice		    
ext2spice -o ${1%.mag}-extracted-${MAGTYPE}-c.spice

#########
EOF

\rm *.ext *.nodes *.sim ${1%.gds}.spice
