#!/bin/bash

# shellcheck disable=SC1091

###############
mkdir -p /foss/designs
mkdir -p /foss/pdk

cp -a "$TOOLS"/sak/openlane/spef_extractor "$TOOLS/"

###############
mkdir -p /foss/tools/bin
cd    /foss/tools/bin || exit
ln -s ../*/*/bin/* .

###############
ln -s "$TOOLS"/xschem/*/* "$TOOLS"/xschem/

###############
# This is now done in the Dockerfile using the tool_metadata.yml from
# the build process.
# cp /foss/tools/openlane/*/dependencies/tool_metadata.yml /

###############
mkdir "$STARTUPDIR"/logs

###############
# Set /usr/bin/python3 to provide "/usr/bin/python"
update-alternatives --set python /usr/bin/python3

###############
groupmod -n designers games
chown -R 1000:designers /headless
chown -R 1000:designers /foss/designs

# FIXME
#/bin/bash $STARTUPDIR/scripts/add_openlane_to_sources.sh
/bin/bash "$STARTUPDIR"/scripts/apply_spice_modellib_reducer.sh
/bin/bash "$STARTUPDIR"/scripts/add_custom_magic_bindkeys.sh
