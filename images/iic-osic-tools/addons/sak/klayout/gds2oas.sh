#!/bin/bash

set -e

echo "converting all gds files to oasis files"

    out="${filename%%.*}.oas"
    klayout -z \
        -rd input_layout=$1 \
        -rd output=${1%.gds}.oas \
        -rm $SAK/klayout/gds2oas.py; 

echo 'Done converting all gds files to oasis files'

echo 'Running XOR between gds and oasis files'

   $SAK/bin/xor.sh $1 ${1%.gds}.oas ${1%.gds} ${1%.gds}-gds2oas-xor.gds

exit 0
