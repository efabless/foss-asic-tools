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

: ${1?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml x1 y1 x2 y2"}
: ${2?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml x1 y1 x2 y2"}
: ${3?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml x1 y1 x2 y2"}
: ${4?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml x1 y1 x2 y2"}
: ${5?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml x1 y1 x2 y2"}
: ${6?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml x1 y1 x2 y2"}
: ${7?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml x1 y1 x2 y2"}
: ${8?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml x1 y1 x2 y2"}


echo "First Layout: $1"
echo "Second Layout: $2"
echo "Design Name: $3"
echo "Output GDS will be: $4"
echo "Exclude box: $5, $6, $7, $8"

klayout -b -r $(dirname $0)/xor_xbox.drc \
    -rd top_cell=$3 \
    -rd a=$1 \
    -rd b=$2 \
    -rd thr=$(nproc) \
    -rd ol=$4 \
    -rd o=$4 \
    -rd ext=${4##*.} \
    -rd x1=$5 \
    -rd y1=$6 \
    -rd x2=$7 \
    -rd y2=$8 \
    -zz
