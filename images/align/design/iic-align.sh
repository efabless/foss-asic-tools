#!/bin/bash
# ========================================================================
# SKY130 automatic layout generation.
#
# SPDX-FileCopyrightText: 2023 Jakob Ratschenberger
# Johannes Kepler University, Institute for Integrated Circuits
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
#
#
# Usage: design [-d|-n|-a|-g|-i|-l] <cellname>
#
# The script expects the topcell <cellname> from the XSCHEM schematic 
# <cellname>.sch in the current folder.
# There must also be a .magicrc file in the current folder.
# Optionally: 
#   - <cellname>.const.json in the current folder, to set constraints.
#
# ************************************************************************
#
# Currently only schematics with the following devices are supported:
#   -sky130_fd_pr__nfet_01v8
#   -sky130_fd_pr__pfet_01v8
#
# ========================================================================

ERR_FILE_NOT_FOUND=2
ERR_NO_PARAM=3
ERR_NO_VAR=4
ERR_NO_RESULT=5
ERR_NO_DIR=6

usage(){
    echo
	echo "Layout design script for XSCHEM and ALIGN-analoglayout (IIC@JKU)"
	echo
	echo "Usage: $0 [-d|-n|-a|-g|-i|-l|-c|-e] <cellname>"
	echo "       -d Run complete flow (default)"
    echo "       -n Run netlist generation"
    echo "       -a Run ALIGN-analoglayout"
    echo "       -g Run GDS to mag"
    echo "       -i Run IIC-DRC"
	echo "       -l Run netgen LVS"
    echo "       -c Generate constrain files"
    echo "       -e Set the effort of ALIGN-analoglayout"
	echo
}

activate(){
    source general/bin/activate 
}

if [ $# = 0 ]; then
	usage
	exit $ERR_NO_PARAM
fi

if [ -z ${PDK_ROOT+x} ]
then
	echo 'Variable PDK_ROOT not set!'
	exit $ERR_NO_VAR
fi

if [ -z ${PDK+x} ]
then
	echo 'Variable PDK not set!'
	exit $ERR_NO_VAR
fi

if [ -z ${STD_CELL_LIBRARY+x} ]
then
	echo 'Variable STD_CELL_LIBRARY not set!'
	exit $ERR_NO_VAR
fi


RUN_GEN_NET=0
RUN_ALIGN=0
RUN_GDS_TO_MAG=0
RUN_LVS=0
RUN_DRC=0
RUN_GEN_CONSTRAINT=0
EFFORT=1

# check flags
# -----------

while getopts "dnagilce:" flag; do
	case "$flag" in
		d)
			echo "[INFO] flag -d is set"
			RUN_GEN_NET=1
            RUN_ALIGN=1
            RUN_GDS_TO_MAG=1
            RUN_LVS=1
            RUN_DRC=1
            RUN_GEN_CONSTRAINT=1
            EFFORT=1
			;;
		n)
			echo "[INFO] flag -n is set"
			RUN_GEN_NET=1
			;;
		a)	
			echo "[INFO] flag -a is set"
            RUN_ALIGN=1
			;;
        g)
			echo "[INFO] flag -g is set"
            RUN_GDS_TO_MAG=1
			;;
		i)
			echo "[INFO] flag -i is set"
            RUN_DRC=1
			;;
        l)
			echo "[INFO] flag -l is set"
            RUN_LVS=1
			;;
        c) 
			echo "[INFO] flag -c is set"
            RUN_GEN_CONSTRAINT=1
			;;
        e) 
			echo "[INFO] flag -e is set"
            EFFORT="$OPTARG"
			;;
		*)  
            usage
			exit;;
    esac
done
# set the default behavior if no flag set
# ------------------------

if [ $OPTIND -eq 1 ]
then
    echo "[INFO] No flags set. Using default settings!"
    RUN_GEN_NET=1
    RUN_ALIGN=1
    RUN_GDS_TO_MAG=1
    RUN_LVS=1
    RUN_DRC=1
    RUN_GEN_CONSTRAINT=1
    EFFORT=1
fi 

shift "$(($OPTIND-1))"

# Define useful variables
# -----------------------
CELL_SCH="$1.sch"
EXT_GDS_MAG_SCRIPT="ext_gds_mag_$1.tcl"
NETLIST_SCH="$1.sch.spc"
ALIGN_SCH="$1.sp"
TOPCELL="$1"
CELL_LAY="$1.mag"
CELL_LOG="$1.mag.log"
LVS_TOPCELL="$1_lvs"
LVS_CELL_LAY="$1_lvs.mag"
EXT_NET_SCRIPT="ext_net_mag_$1.tcl"
NETLIST_LAY="$1.ext.spc"
BASE_DIR=$(pwd) #save current path 
LVS_REPORT="$1.lvs.out"
LVS_LOG="$1.lvs.log"

FULL_FILE=$(realpath "$NETLIST_SCH") #get the file name with full path
TOP_PATH=$(dirname "$FULL_FILE") #get the directory of the spice file

# Check if files exist
# --------------------
if [ -f "$CELL_SCH" ]
then
    export CELL_SCH="$CELL_SCH"
elif [ -f "sch/$CELL_SCH" ]
then
    export CELL_SCH="sch/$CELL_SCH"
elif [ -f "xschem/$CELL_SCH" ]
then
    export CELL_SCH="xschem/$CELL_SCH"
else
    echo "Schematic $CELL_SCH not found!"
    exit $ERR_FILE_NOT_FOUND
fi

set -e # exit if a command fails
# Initial checks passed, start working
# ------------------------------------

# Extract spice netlist from schematic and
# generate the align format
# ------------------------------------
if [ $RUN_GEN_NET = 1 ]; then

    # Remove old netlists
    # -------------------

    if [ -f "$NETLIST_SCH" ]
    then
        rm -f "$NETLIST_SCH"
    fi

    echo "[INFO] Running Netlist generation of cell <$TOPCELL>."

    # Extract SPICE netlist from schematic
    # ------------------------------------
    echo "... extracting netlist from schematic <$CELL_SCH>"
    XSCHEMTCL='set lvs_netlist 1; set top_subckt 1; set flat_netlist 0; set netlist_dir .'
    xschem --rcfile "$PDK_ROOT/$PDK/libs.tech/xschem/xschemrc" -n -s -q --no_x --tcl "$XSCHEMTCL" "$CELL_SCH" -N "$NETLIST_SCH" > /dev/null

    if [ ! -f "$NETLIST_SCH" ]
    then
        echo "[Error] No schematic netlist produced!"
        exit $ERR_NO_RESULT
    fi	

    # Check if schematic netlist contains standard cells: if yes, include library with
    # SPICE netlists for the standard cells
    if grep -q "$STD_CELL_LIBRARY" "$NETLIST_SCH"
    then
            # Remove the .end
            sed -i '/\.end\b/d' "$NETLIST_SCH"
            # Append sky130 lib
            cat "$PDK_ROOT/$PDK/libs.ref/$STD_CELL_LIBRARY/spice/$STD_CELL_LIBRARY.spice" >> "$NETLIST_SCH"
            # Add .end
            echo ".end" >> "$NETLIST_SCH"
    fi

    SPICE_TO_ALIGN=/foss/tools/align/design/cir2align.py

    echo "[INFO] Generating ALIGN-netlist format from <${NETLIST_SCH}>."
    python3 "$SPICE_TO_ALIGN" "$FULL_FILE" #convert sch.spc to sp

    if [ ! -f "$ALIGN_SCH" ]
    then
        echo "[Error] No align netlist produced!"
        exit $ERR_NO_RESULT
    fi	

fi

#go into the top dir.
cd "$TOP_PATH" || exit $ERR_NO_DIR

if [ $RUN_GEN_CONSTRAINT = 1 ]; then
    echo "[INFO] Generating constrains from schematic"
    for file in *.sch; do #generate a constrain file for each schematic 
        if grep -Fxq ".constraint" "$file" #check if constrain is specified in schematic
        then
            #copy the lines between .constraint and .endconstraint into <file>.const.json
            sed -n -e '/^.constraint$/,/^.endconstraint$/{/^.constraint$/d; /^.endconstraint$/d; p;}' "$file" > "${file%.sch}.const.json"
            sed -i 's/\\}/}/g' "${file%.sch}.const.json" #replace \} with }
            sed -i 's/\\{/{/g' "${file%.sch}.const.json" #replace \{ with }
            sed -i -e '$a]' "${file%.sch}.const.json" #append ] at the end
            sed -i '1i [' "${file%.sch}.const.json" #append [ at the beginning
        fi
    done  
fi


# Generate the layout
# ------------------------------------
if [ $RUN_ALIGN = 1 ]; then

    if [ ! -f "$ALIGN_SCH" ]
    then
        echo "[Error] No align netlist found!"
        exit $ERR_FILE_NOT_FOUND
    fi	

    echo "[INFO] Starting the ALIGN tool..."
    #start the ALIGN tool
    LD_LIBRARY_PATH=/foss/tools/align/d3954af/general/lib
    ALIGN_ROOT=/foss/tools/align/d3954af
    ALIGN_PDK_ROOT=/foss/tools/align-pdk-sky130/SKY130_PDK

    if [ ! -d $ALIGN_ROOT ]
    then
        echo "[Error] Align directory not found!"
        exit $ERR_NO_DIR
    fi	

    if [ ! -d $ALIGN_PDK_ROOT ]
    then
        echo "[Error] Align-sky130 directory not found!"
        exit $ERR_NO_DIR
    fi	

    #cd $ALIGN_ROOT #go into the align dir
    #start the virtual env.
    #source general/bin/activate
    #activate

    #go to the directory of the spice file
    cd "$TOP_PATH" || exit $ERR_NO_DIR

    #make a work directory if none exists
    mkdir -p work_align
    cd work_align || exit $ERR_NO_DIR

    echo "... and designing topcell ${TOPCELL}"
    #make a design
    schematic2layout.py ../ -p "$ALIGN_PDK_ROOT" -f "../$ALIGN_SCH" -s "$TOPCELL" -e "$EFFORT" #-l "DEBUG" -v "DEBUG"
    #schematic2layout.py ../ -p $ALIGN_PDK_ROOT -f ../$ALIGN_SCH -s $TOPCELL 

    #deactivate the virtual enviroment
    #deactivate

    if [ ! -f "${TOPCELL^^}_0.gds" ]
    then
        echo "[Error] No layout produced!"
        exit $ERR_NO_RESULT
    fi
fi

#go into the top dir.
cd "$TOP_PATH" || exit $ERR_NO_DIR

if [ $RUN_GDS_TO_MAG = 1 ]; then
    #check if magicrc file is specified
    if [ ! -f ".magicrc" ]
    then
        echo "[ERROR] No magicrc file in top path!"
        exit $ERR_FILE_NOT_FOUND
    fi

    if [ ! -d work_align ]
    then
        echo "[ERROR] Run align before generating the .mag!"
        exit $ERR_FILE_NOT_FOUND
    fi

    if [ ! -f "work_align/${TOPCELL^^}_0.gds" ]
    then
        echo "[ERROR] File work_align/${TOPCELL^^}_0.gds not found!"
        exit $ERR_FILE_NOT_FOUND
    fi		

    #Convert gds to magic
    echo "[INFO] Converting <work_align/${TOPCELL^^}_0.gds> into <work_magic/${TOPCELL}.mag>!"
    if [ -d work_magic ]
    then
        rm -r work_magic
    fi

    mkdir work_magic && cd work_magic
    cp ../.magicrc .    #copy rc file into the magic directory

    {
        echo "drc off"
        echo "box 0 0 0 0"
        echo "cellname rename vtop"
        echo "gds readonly false"
        echo "gds warning redirect $CELL_LOG"
        echo "gds read ../work_align/${TOPCELL^^}_0"
        echo "cellname rename ${TOPCELL^^}_0 ${TOPCELL}"
        echo "load ${TOPCELL}"
        echo "select top cell"
        echo "writeall force"
        echo "select top cell"
        echo "flatten $LVS_TOPCELL"
        echo "writeall force"
        echo "quit -noprompt"
    } > "$EXT_GDS_MAG_SCRIPT"

    #magic -dnull -noconsole -rcfile /foss/pdk/sky130A/libs.tech/magic/sky130A.magicrc "$EXT_GDS_MAG_SCRIPT" > /dev/null 
    magic -dnull -noconsole "$EXT_GDS_MAG_SCRIPT" > /dev/null 
    rm -f vtop.mag
fi

#go into the top dir.
cd "$TOP_PATH" || exit $ERR_NO_DIR

if [ $RUN_DRC = 1 ]; then

    if [ ! -d work_magic ]
    then
        echo "[ERROR] Run gds to magic before DRC!"
        exit $ERR_NO_RESULT
    fi

    cd work_magic

    if [ ! -f "${TOPCELL}.mag" ]
    then
        echo "[ERROR] File work_magic/${TOPCELL}.mag not found!"
        exit $ERR_NO_RESULT
    fi

    echo "[INFO] Running IIC-DRC on <work_magic/${TOPCELL}.mag>!"
    if [ ! -f "/foss/tools/iic-osic/iic-drc.sh" ]
    then
        echo "[ERROR] No IIC_DRC script not found!"
        exit $ERR_FILE_NOT_FOUND
    fi

    /foss/tools/iic-osic/iic-drc.sh "$TOPCELL"
fi

#go into the top dir.
cd "$TOP_PATH" || exit $ERR_NO_DIR

if [ $RUN_LVS = 1 ]; then

    if [ ! -d work_magic ]
    then
        echo "[ERROR] Run gds to magic before LVS!"
        exit $ERR_NO_RESULT
    fi

    if [ ! -f "work_magic/$LVS_CELL_LAY" ]
    then
        echo "[ERROR] File work_magic/$LVS_CELL_LAY not found!"
        exit $ERR_NO_RESULT
    fi

    
    

    echo "[INFO] Placing ports in work_magic/$LVS_CELL_LAY."

    LABELS_TO_PORTS=/foss/tools/align/design/labels_to_ports.py

    cd work_magic
    python3 "$LABELS_TO_PORTS" "$LVS_CELL_LAY" -d "$LVS_CELL_LAY" #convert labels to ports

    #go into the top dir.
    cd "$TOP_PATH" || exit $ERR_NO_DIR

    if [ ! -f "$NETLIST_SCH" ]
    then
        echo "[ERROR] No schematic netlist! Run netlist generation before LVS!"
        exit $ERR_NO_RESULT
    fi	

    echo "[INFO] Running LVS!"

    if [ -d work_lvs ]
    then
        rm -r work_lvs
    fi
    mkdir work_lvs && cd work_lvs

    {
        echo "load ../work_magic/$LVS_CELL_LAY"
        echo "select top cell"
        echo "extract all"
        echo "ext2spice lvs"
        echo "ext2spice merge conservative"
        echo "ext2spice -o $NETLIST_LAY"
        echo "quit"
    } >> "$EXT_NET_SCRIPT"

    # Extract SPICE netlist from layout with magic
    # --------------------------------------------

    echo "[INFO] Extracting netlist from layout <work_magic/$CELL_LAY>"
    magic -dnull -noconsole "$EXT_NET_SCRIPT" > /dev/null 

    if [ ! -f "$NETLIST_LAY" ]
    then
        echo "[ERROR] No layout netlist produced!"
        exit $ERR_NO_RESULT
    fi
    echo "[INFO] Run netgen"

    netgen -batch lvs "$NETLIST_LAY ${LVS_TOPCELL}" "../$NETLIST_SCH $TOPCELL" \
            "$PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl" \
            "$LVS_REPORT" > "$LVS_LOG"

    echo "[INFO] Result of LVS:"
    echo "---------------------"
    tail -3 "$LVS_REPORT"
    echo
    echo "For details please check work_lvs/<$LVS_REPORT>."
    echo
fi

cd "$TOP_PATH" || exit $ERR_NO_DIR