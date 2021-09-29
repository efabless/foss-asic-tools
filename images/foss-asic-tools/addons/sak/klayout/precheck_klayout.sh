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

: ${1?"Usage: $0 golden user_project_wrapper.gds/user_analog_project_wrapper.gds"}
: ${2?"Usage: $0 modified user_project_wrapper.gds/user_analog_project_wrapper.gds"}
: ${3?"Usage: $0 cell name"}
: ${4?"Usage: $0 output file for xoring <output>.gds"}


echo "First Layout: $1"
echo "Second Layout: $2"
echo "cell: $3"
echo "output from xor Layout: $4"

klayout -rd file1=$1 -rd file2=$2 -rd cell_name=$3 -z -r $(dirname $0)/precheck_klayout.rb

klayout -rd file1=$1 -rd output=golden_erased.gds -rd cell_name=$3 -z -r $(dirname $0)/erase.rb

klayout -rd file1=$2 -rd output=modified_erased.gds -rd cell_name=$3 -z -r $(dirname $0)/erase.rb

$SAK/klayout/run_xor.sh modified_erased.gds golden_erased.gds $3 $4

rm golden_erase.gds
rm modified_erased.gds

