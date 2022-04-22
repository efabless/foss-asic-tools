#!/bin/sh
export MAGIC=/ef/apps/ocd/magic/8.3.179-202106141345/bin/magic
export MAGTYPE=maglef; 
export PDKPATH=$PDK_ROOT/sky130A ; 

$MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/sky130A.magicrc  <<EOF

gds read $1
load ${1%.gds} -dereference
select top cell
extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust
extract unique
# extract warn all
extract
feedback save ./tmp/${1%.gds}_ext2spice.antenna.feedback.txt
antennacheck debug
antennacheck
quit -noprompt
EOF
\rm *.ext

# feedback save ${1%.mag}.ext.tcl
# snap int
# source 	${1%.mag}.ext.tcl


