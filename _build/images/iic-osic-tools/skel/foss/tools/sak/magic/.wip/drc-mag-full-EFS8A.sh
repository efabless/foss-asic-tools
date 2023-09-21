#!/bin/bash
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

export MAG_FILE_PATH=$1
export PDK_ROOT=/ef/tech/SW/
export PDKPATH=/ef/tech/SW/EFS8A/
export VERSION="current"
export OUT_DIR=./results.drc.$2

#if ! [[ -d "$OUT_DIR" ]]
#then
#    mkdir $OUT_DIR
#fi

#cd $OUT_DIR

# magicDrc -T $PDKPATH/libs.tech/magic/$VERSION/EFS8A.tech -I vendorimport -S 'drc(full)' -l $OUT_DIR/$2.drc.out -km $OUT_DIR/$2.drc.km ../$MAG_FILE_PATH $CELL_NAME

# magicDrc -T $PDKPATH/libs.tech/magic/$VERSION/EFS8A.tech -I vendorimport -S 'drc(fast)' -l $2.drc.out -km $2.drc.km ../$MAG_FILE_PATH $CELL_NAME

magicDrc -T $PDKPATH/libs.tech/magic/$VERSION/EFS8A.tech -S 'drc(fast)' -l $2.drc.out $MAG_FILE_PATH

#cd ..

#echo "#############################################" 
#echo "Check the results in" "$OUT_DIR"
#echo "#############################################" 

<< COMMENT

usage: [ -T techfilePath ] [-S <drcStyleName>]  [-I <cifIStyleName>] [-km FILE_NAME] [-l FILE_NAME] [-L FILE_NAME] gdsFileName [topCellName]
  -T if given, must be very first
  -S if given, changes from techfile's default/1st drc style (perhaps "drc(fast)") to named style, for example: -S "drc(full)"
  -I if given, changes from techfile's default/1st cifinput style (perhaps "vendorimport" or "import(exact)") to named style, for example: -I "import(magic)"
  -path-sub do 'gds path    subcell yes' (default:no). Make unique subcell for each path: cut #tiles cost of angles.
  -poly-sub do 'gds polygon subcell yes' (default:no). Make unique subcell for each polygon: cut #tiles cost of angles.
  -pps  Short hand, equivalent to giving both: -path-sub -poly-sub

  Error tabulation: By default (slowest, most detail): Report table of counts-by-errorString for all cells.
  Stdout logs a pareto of error-type by count unless disabled for some/all cells by below; topcell last.
  -tt Table of counts-by-errorString for ONLY topcell; and just lumped total error count per subcell.
  -tc Just lumped error counts per cell including topcell (fastest, least detail).
  Cells NOT tabulating count-by-errorString can't appear in other output error files: feedback(*.drtcl), -l, -km.
  For lumped error counts, overlapped error shapes from unique error-types are merged further reducing count.

  cell-type +--    (default)     --+--  option -tt      --+--   option -tc
    subcell | count-by-errorString |   lumped-error-count | lumped-error-count
    topcell | count-by-errorString | count-by-errorString | lumped-error-count

  -km if given, write to FILE_NAME EVERY individual error bbox (MICRONS) in klayout Marker database(XML) format (suggest *.lyrdb)
  -l if given, enumerates EVERY individual error bbox (MICRONS) to FILE_NAME, emulates /ef/efabless/lib/magic/tcl/drc.tcl
  -L same as -l above, but outputs bbox-es in LAMBDA coordinates, not microns
  -nf  Do NOT write *.drtcl per-cell feedback files. Can be source-ed in magic and step thru: feedback find.

  NOTES: Without explicit tech-file option: the ./.magicrc or ./magic_setup and ~/.magicrc may load a default tech-file.
  Therefore the tech-file used CAN depend on whether your CWD is ~/design/<CURRENT_DESIGN>/mag when running this script.
  Since no *.mag are loaded by this script: the cell search path defined by any init files has no impact.
  Since about 8.3.68, magic may generate error-type "See error definition in the subcell". There typically are
  redundancies of errors across the hierarchy anyway (but with tech-file err-strings), this seems another form.

example, just list all styles: by causing an error which provokes usage report:
    magicGdrc -T /ef/tech/XFAB/EFXH035B/libs.tech/magic/current/EFXH035B.tech
example, same but run in a ~/design/*/mag/ dir, so techfile set by ./.magicrc (else magic's builtin minimum.tech):
    magicGdrc
example, run GDS drc, explicit: tech, cif-istyle, drc-style:
    magicGdrc -T /ef/tech/SW/EFS8A/libs.tech/magic/current/EFS8A.tech -I vendorimport -S 'drc(full)' /tmp/mytop.gds mytopcell
example, run GDS drc, default tech & styles, write klayout marker database, no per-cell *.drtcl feedback files:
    magicGdrc -km /tmp/mytop.lyrdb -nf /tmp/mytop.gds mytopcell
example, same but make subcells for paths & polygons
    magicGdrc -km /tmp/mytop.lyrdb -nf -pps /tmp/mytop.gds mytopcell
example, run GDS drc, no feedback (*.drtcl), only lumped/merged err-count for all cells
    magicGdrc -tc /tmp/mytop.gds mytopcell
example, run GDS drc, no feedback (*.drtcl), lumped/merged err-count for subcells, detail errors for topcell
    magicGdrc -nf -tt /tmp/mytop.gds mytopcell

magicGdrc: tech-name: minimum -version: 0.0 {Minimum technology file structure} -filename: /ef/efabless/lib/magic/sys/minimum.tech -lambda 1 1
info: magicGdrc: drc styles available: default

ERROR: magicGdrc: Insufficient number of arguments, need gdsFileName [topCellName]

COMMENT


