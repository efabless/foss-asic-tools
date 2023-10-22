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
#git clone --depth=1 https://github.com/IHP-GmbH/IHP-Open-PDK.git ihp
git clone https://github.com/iic-jku/IHP-Open-PDK.git ihp
cd ihp || exit
#FIXME for now uses branch "dev" to get the latest releases
git checkout dev

if [ -d $PDK_VERSION ]; then
	mv $PDK_VERSION "$PDK_ROOT"
fi

#FIXME For the time being, we only have OpenVAF for amd64
#FIXME Get OpenVAF from osic-multitool (in the future)
if [ "$(arch)" == "x86_64" ]; then
    cd "$PDK_ROOT"/"$PDK_VERSION"/libs.tech/ngspice/openvaf

    # Get OpenVAF
    wget https://openva.fra1.cdn.digitaloceanspaces.com/openvaf_23_5_0_linux_amd64.tar.gz
    tar xfz openvaf_23_5_0_linux_amd64.tar.gz
    rm -rf openvaf_23_5_0_linux_amd64.tar.gz

    # Compile the PSP model
    ./openvaf psp103_nqs.va
fi
