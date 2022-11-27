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
# On Ubunutu GID=20 is dialout, but on MacOS GID=20 is staff and the
# default for users. This leads to access issues as dialout seems to
# restricted in Ubuntu. Hence this WA.
groupmod -g 18 dialout
groupadd -g 20 designers
chown -R 1000:designers /headless
chown -R 1000:designers /foss/designs

## Set correct user permissions
"$STARTUPDIR/scripts/set_user_permission.sh" "$STARTUPDIR" "$HOME"