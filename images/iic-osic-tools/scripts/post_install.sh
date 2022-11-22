#!/bin/bash

# shellcheck disable=SC1091

###############
mkdir -p /foss/designs
mkdir -p /foss/pdks

cp -a "$TOOLS"/sak/openlane/spef_extractor "$TOOLS/"

###############
mkdir -p /foss/tools/bin
cd    /foss/tools/bin || exit
ln -s ../*/*/bin/* .

###############
ln -s "$TOOLS"/xschem/*/* "$TOOLS"/xschem/

###############
mkdir "$STARTUPDIR"/logs

###############
# Set /usr/bin/python3 to provide "/usr/bin/python"
update-alternatives --set python /usr/bin/python3

###############
chown -R nobody:nogroup /headless && chmod -R +rw /headless
chown -R nobody:nogroup /foss/designs && chmod -R +rw /foss/designs
