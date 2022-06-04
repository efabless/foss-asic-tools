#!/bin/bash
#

########################################################
###### Magic netlist extraction
########################################################

export MAGIC=magic
export PDKPATH=$PDK_ROOT/sky130A ; 

$MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/sky130A.magicrc  << EOF

crashbackups stop
drc off
gds readonly true
gds flatten true
gds rescale false
tech unlock *
cif istyle sky130(vendor)
gds read $1
load ${1%.gds} -dereference
select top cell
extract do local
extract all
ext2sim labels on
ext2sim
ext2spice lvs
ext2spice cthresh 0
ext2spice		    
ext2spice -o ${1%.gds}-extracted-gds-c.spice

#########
EOF

\rm *.ext *.nodes *.sim ${1%.gds}.spice
