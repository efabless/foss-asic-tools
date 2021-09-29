#!/bin/sh
#export MAGIC=/ef/apps/ocd/magic/8.3.179-202106141345/bin/magic
export MAGIC=/ef/apps/ocd/magic/8.3.165-202105171922/bin/magic

export MAGTYPE=maglef; 

$MAGIC -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc  <<EOF
drc off
gds readonly true
gds rescale false
load $1 -dereference
select top cell
expand
cif *hier write disable
gds write ${1%.mag}.gds
quit -noprompt
EOF

#\mv ${1%.mag}.gds ../gds/

