#!/bin/bash
# SPDX-FileCopyrightText: 2020 Efabless Corporation
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
# SPDX-License-Identifier: Apache-2.0

# To call: ./run_instance_listing.sh <target_path> <design_name> <output_path>

: ${1?"Usage: $0 <target_path>"}

export TARGET_DIR=$1
if ![[-z "$PDK_ROOT"]]
then
    echo "PDK_ROOT is not defined. Please define it before running"
    exit 1
fi
export DESIGN_NAME=${2:-"user_project_wrapper"}
export OUT_DIR=${3:-$TARGET_DIR/signoff/macro_listing_check}
export SCRIPTS_ROOT=${4:-$(dirname $0)}

if ! [[ -d "$OUT_DIR" ]]
then
    mkdir $OUT_DIR
fi
echo "Running Magic..."
export MAGIC_MAGICRC=$PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc

ulimit -c unlimited
magic \
    -noconsole \
    -dnull \
    -rcfile $MAGIC_MAGICRC \
    $SCRIPTS_ROOT/magic_list_instances.tcl \
    </dev/null \
    |& tee $OUT_DIR/magic_extract.log

exit 0
