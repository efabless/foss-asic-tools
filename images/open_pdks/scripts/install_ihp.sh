#!/bin/bash

set -e

if [ ! -d "$PDK_ROOT" ]; then
    mkdir -p "$PDK_ROOT"
fi

####################
# INSTALL IHP-SG13G2
####################

PDK_VERSION="ihp-sg13g2"

cd /tmp || exit
git clone --depth=1 https://github.com/IHP-GmbH/IHP-Open-PDK.git ihp
cd ihp || exit

if [ -d $PDK_VERSION ]; then
	mv $PDK_VERSION "$PDK_ROOT"
fi
