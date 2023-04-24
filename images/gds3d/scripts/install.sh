#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$GDS3D_REPO_COMMIT" | cut -c 1-7)

git clone "${GDS3D_REPO_URL}" "${GDS3D_NAME}"
cd "${GDS3D_NAME}"
git checkout "${GDS3D_REPO_COMMIT}"
#fix for GCC-11, see https://github.com/trilomix/GDS3D/pull/9
sed -i -e '/CFLAGS=/ s/$/ -std=c++11/' linux/Makefile

make -C linux -j"$(nproc)"

mkdir -p "${TOOLS}/${GDS3D_NAME}/${REPO_COMMIT_SHORT}/bin"
cp linux/GDS3D "${TOOLS}/${GDS3D_NAME}/${REPO_COMMIT_SHORT}/bin"

if [ -d "$PDK_ROOT/sky130A" ]; then
    mkdir -p "$PDK_ROOT/sky130A/libs.tech/gds3d"
    cp techfiles/sky130.txt "$PDK_ROOT/sky130A/libs.tech/gds3d/gds3d_tech.txt"
fi

if [ -d "$PDK_ROOT/sky130B" ]; then
    mkdir -p "$PDK_ROOT/sky130B/libs.tech/gds3d"
    cp techfiles/sky130.txt "$PDK_ROOT/sky130B/libs.tech/gds3d/gds3d_tech.txt"
fi
