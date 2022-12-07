#!/bin/bash

# shellcheck disable=SC1091

## mv env.sh into place as .bashrc
mv "$STARTUPDIR/scripts/env.sh" "$HOME/.bashrc"

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
chown -R 1000:1000 /headless
chmod -R +rw /headless
chown -R 1000:1000 /foss/designs

## Set correct user permissions
"$STARTUPDIR/scripts/set_user_permission.sh" "$STARTUPDIR" "$HOME"
