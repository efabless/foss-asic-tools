#!/bin/bash
#
# make_spef_file.sh ---
#
#	Script to generate a .spef file from a pattern layout (in DEF format)
#	for openRCX using magic
#
# Usage:
#
#	make_spef_file.sh <DEF_file> [<corner>]

if test "$#" -eq 0 ; then
    echo "Usage: make_spef_file.sh <def_file_name> [<corner>]"
    echo "    where <corner> is 'nom' (default), 'min', or 'max'".
    exit 0
fi

# Default extraction style is nominal
extstyle = 'ngspice()'
corner = "nominal"

if test "$#" -eq 2 ; then
    corner = $2
    if test "$2" -eq "min" ; then
	extstyle = "ngspice\(lrlc\)"
        corner = "minimum"
    elif test "$2" -eq "max" ; then
	extstyle = "ngspice\(hrhc\)"
        corner = "maximum"
    fi
fi

#
# These values can be overridden from the environment
#
export PDK_ROOT=${PDK_ROOT:=/foss/pdk}
export PDK=${PDK:=sky130A}
export PDK_PATH=${PDK_ROOT}/${PDK}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

designname=`cat $1 | grep ^DESIGN | cut -d' ' -f 2`

echo "Extracting design $designname from $1 using magic, $corner corner"
magic -dnull -noconsole -rcfile ${PDK_PATH}/libs.tech/magic/${PDK}.magicrc << EOF
drc off
crashbackups stop
lef read ${PDK_PATH}/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef
def read $1
extract style $extstyle
extract do aliases
extract do local
extract all
quit -noprompt
EOF

echo "Converting design $designname to SPEF"
${SCRIPT_DIR}/ext2spef.py ${designname}.ext ${designname}.spef
rm -f ${designname}.ext

echo "Done!"
exit 0
