#!/bin/bash

set -e

echo "converting all gds files to oasis files"

for filename in *.gds; do
    out="${filename%%.*}"
    out=$out".oas"
    xvfb-run -a klayout -z \
        -rd input_layout=$filename \
        -rd output=$out \
        -rm $SAK/klayout/gds2oas.py; done

echo 'Done converting all gds files to oasis files'
exit 0
