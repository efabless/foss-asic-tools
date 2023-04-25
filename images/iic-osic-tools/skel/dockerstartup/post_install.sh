#!/bin/bash

# shellcheck disable=SC1091

## mv env.sh into place as .bashrc
mv "$STARTUPDIR/scripts/env.sh" "$HOME/.bashrc"

###############
mkdir -p "$DESIGNS"
mkdir -p "$PDK_ROOT"
mkdir -p "$EXAMPLES"

cp -a "$TOOLS"/sak/openlane/spef_extractor "$TOOLS/"

###############
mkdir -p "$TOOLS/bin"
cd    "$TOOLS/bin" || exit
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
chown -R 1000:1000 "$DESIGNS"

## Set correct user permissions
"$STARTUPDIR/scripts/set_user_permission.sh" "$STARTUPDIR" "$HOME"
