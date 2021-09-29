export KLAYOUT_SKY130_TECH=/home/xrex/.klayout/tech/SKY130/SKY130.lyt

: ${1?"Usage: $0 input.def design_name prereq1.gds prereq2.gds ...."}
: ${2?"Usage: $0 input.def design_name prereq1.gds prereq2.gds ...."}
: ${3?"Usage: $0 input.def design_name prereq1.gds prereq2.gds ...."}

xvfb-run klayout -z -rd design_name=$2 \
        -rd in_def=$1 \
        -rd in_gds="${@:3}" \
        -rd config_file="" \
        -rd seal_gds="" \
        -rd out_gds=$(dirname $1)/$2.gds \
        -rd tech_file=$KLAYOUT_SKY130_TECH \
        -rm $(dirname $0)/def2gds.py
