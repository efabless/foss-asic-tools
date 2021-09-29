#!/bin/sh
# Copyright 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

: ${1?"Usage: $0 gds input file"}
: ${2?"Usage: $0 report name"}

threads=(200 150 100 50 25 20 15 10 8 4 2 1)
tiles=(1000 800 600 400 200 100 50 10)

echo "design, report, start_date, end_date, threads, tiles" >> test_suite.csv

for thr in ${threads[@]}; do
    for tile in ${tiles[@]}; do
        start=$(date +"%r")
        /ciic/tools/bin/klayout -rd input=$1 -rd report=$2.$thr.$tile -rd thr=$thr -rd tiles=$tile -rd beol=1 -rd feol=1 -zz -r sky130A_mr_opt.drc
        end=$(date +"%r")
        echo "start: $start \nend: $end"

        echo "$1, $2.$thr.$tile, $start, $end, $thr, $tile" >> test_suite.csv
    done
done
