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

usage() { echo "Usage: $0 [ -f ] [ -m ] <shuttle> <target_path> <input.gds> [ <tapeout_root> ]" 1>&2; exit 2; }

drc_full=false
drc_mr=false
while getopts "fm" o; do
    case "${o}" in
        f)
            drc_full=true
            ;;
        m)
            drc_mr=true
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

set -e

[[ $# -gt 3 ]] && export TAPEOUT_ROOT=$4 || export TAPEOUT_ROOT=/mnt/shuttles

export SAK=$TAPEOUT_ROOT/sak
export PATH=$PATH:/ef/apps/bin:$SAK/tapeout:$SAK
export CARAVEL_ROOT=${TAPEOUT_ROOT}/${1}/caravel
export PDK_ROOT=${TAPEOUT_ROOT}/${1}/pdk

target_path=${2}
input_gds=${3}
report=${target_path}/signoff/kdrc_results.txt

tech_mr=${SAK}/klayout/tech/sky130A/sky130A_mr.lydrc
tech_full=${SAK}/klayout/tech/sky130A/sky130A.lydrc

if [ $drc_full = true ]; then
  klayout -b \
      -rd input=${input_gds} \
      -rd report=${report} \
      -r ${tech_full} |& tee ${target_path}/signoff/klayout_drc.log
fi

if [ $drc_mr = true ]; then
  klayout -b \
      -rd input=${input_gds} \
      -rd report=${report} \
      -r ${tech_mr} |& tee "${target_path}/signoff/klayout_drc.log"
fi

exit 0
