#!/bin/bash

# shellcheck disable=SC1091

# Cleanup of installation leftovers
[ -f /dependencies.sh ] && rm -f /dependencies.sh 
[ -f /install.sh ] && rm -f /install.sh

# Move env.sh into place as .bashrc
mv "$STARTUPDIR/scripts/env.sh" "$HOME/.bashrc"

# Create dirs if not yet existing
[ ! -d "$DESIGNS" ] && mkdir -p "$DESIGNS"
[ ! -d "$PDK_ROOT" ] && mkdir -p "$PDK_ROOT"
[ ! -d "$EXAMPLES" ] && mkdir -p "$EXAMPLES"

cp -a "$TOOLS/sak/openlane/spef_extractor" "$TOOLS/"

# Link all tool binaries into one bin folder
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
chown -R 1000:1000 "$HOME"
chmod -R +rw "$HOME"
chown -R 1000:1000 "$DESIGNS"

## Set correct user permissions
"$STARTUPDIR/scripts/set_user_permission.sh" "$STARTUPDIR" "$HOME"
