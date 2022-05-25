#!/bin/sh
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

export MAGTYPE=mag ; 
export PDKPATH=$PDK_ROOT/sky130A ;
export MAGIC=magic


$MAGIC -rcfile $PDKPATH/libs.tech/magic/current/sky130A.magicrc -dnull -noconsole << EOF
drc off
box 0 0 0 0
load vtop.mag -force
drc off
gds readonly true
gds rescale false
gds read ${cellname}.gds
cellname rename ${cellname} vtmp
load vtmp
select top cell
set pname [lindex [cellname list children] 0]
cellname rename \\\$pname ${cellname}
select cell \\\${pname}_0
identify ${cellname}_0
writeall force ${cellname}
quit -noprompt
EOF
