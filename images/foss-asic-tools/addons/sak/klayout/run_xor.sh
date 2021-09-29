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

# script for running the xor script and then running the parsing script

: ${1?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml"}
: ${2?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml"}
: ${3?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml"}
: ${4?"Usage: $0 file1.gds file2.gds <top_level_module_name> output.gds|markers.xml"}

./xor.sh $1 $2 $3 $4 | tee xor.log

rm xor_total.txt

python3 parse_xor_log.py \
    -l "xor.log" \
    -o "xor_total.txt" \
    -c $3

cat xor_total.txt
