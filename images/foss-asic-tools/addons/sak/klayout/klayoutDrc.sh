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

usage() { echo "Usage: $0 [ -f ] [ -m ] [ -d ] [ -t <threads> ] <target_path> <input.gds> " 1>&2; exit 2; }

drc_full=false
drc_mr=false
drc_fom=false
thr=16

while getopts "fmdt:" o; do
    case "${o}" in
        f)
            drc_full=true
            ;;
        m)
            drc_mr=true
            ;;
        d)
            drc_fom=true
            ;;
        t)
            thr=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

set -e

target_path=${1}
input_gds=${2}

tech_mr=${SAK}/../klayout/tech/sky130A/sky130A-mr.lydrc
tech_full=${SAK}/../klayout/tech/sky130A/sky130A-full.lydrc
tech_fom=${SAK}/../klayout/tech/sky130A/sky130A-fom.lydrc


if [ $drc_full = true ]; then
  klayout -b \
      -rd input=${input_gds} \
      -rd report=${target_path}/${2%.gds}-full.lyrdb \
      -rd thr=${thr} \
      -r ${tech_full} |& tee ${target_path}/${2%.gds}-full.log
      
  klayout $2 -m ${2%.gds}-full.lyrdb
  
fi

if [ $drc_mr = true ]; then
  klayout -b \
      -rd input=${input_gds} \
      -rd report=${target_path}/${2%.gds}-mr.lyrdb \
      -rd thr=${thr} \
      -r ${tech_mr} |& tee ${target_path}/${2%.gds}-mr.log 
      
  klayout $2 -m ${2%.gds}-mr.lyrdb

fi


if [ $drc_fom = true ]; then
  klayout -b \
      -rd input=${input_gds} \
      -rd report=${target_path}/${2%.gds}-fom.lyrdb \
      -rd thr=${thr} \
      -r ${tech_fom} |& tee ${target_path}/${2%.gds}-fom.log 
      
  klayout $2 -m ${2%.gds}-fom.lyrdb

fi





exit 0
