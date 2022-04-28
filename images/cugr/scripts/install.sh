#!/bin/bash

source scl_source enable gcc-toolset-9

set -e
set -u

REPO_COMMIT_SHORT=$(echo $CUGR_REPO_COMMIT | cut -c 1-7)

git clone ${CUGR_REPO_URL} ${CUGR_NAME}
cd ${CUGR_NAME}
git checkout ${CUGR_REPO_COMMIT}

echo "Copying newly built liblef and libdef into place"
cp ../OpenROAD/src/odb/src/lef/build/liblef.a rsyn/lib/linux/
cp ../OpenROAD/src/odb/src/def/build/libdef.a rsyn/lib/linux/

python3 scripts/build.py -o release -m"-j$(($(nproc) / 2))"

mkdir -p /foss/tools/${CUGR_NAME}/${REPO_COMMIT_SHORT}/bin/
cp run/iccad19gr /foss/tools/${CUGR_NAME}/${REPO_COMMIT_SHORT}/bin/cugr
