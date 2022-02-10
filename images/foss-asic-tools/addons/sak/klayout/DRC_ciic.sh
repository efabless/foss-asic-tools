#!/bin/sh

: ${1?"Usage: $0 gds input file"}
: ${2?"Usage: $0 report name"}
: ${3?"Usage: $0 number of threads"}
: ${4?"Usage: $0 size of tiles"}

start=$(date +"%r")
/ciic/tools/bin/klayout -rd input=$1 -rd report=$2 -rd thr=$3 -rd tiles=$4 -rd beol=1 -rd feol=1 -zz -r sky130A_mr_opt.drc
end=$(date +"%r")
echo "start: $start \nend: $end"
