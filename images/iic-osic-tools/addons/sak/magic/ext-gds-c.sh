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
flatten $1_flat
load    $1_flat
select top cell
extract do local
extract all
ext2sim labels on
ext2sim
ext2spice lvs
ext2spice cthresh 0
ext2spice		    
ext2spice -o gds-extracted-${1%.gds}.spice

#########
EOF

\rm *.ext
