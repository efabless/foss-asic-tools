#!/bin/bash

source scl_source enable gcc-toolset-9

set -e
set -u

REPO_COMMIT_SHORT=$(echo $DRCU_REPO_COMMIT | cut -c 1-7)


git clone ${DRCU_REPO_URL} ${DRCU_NAME}
cd ${DRCU_NAME}
git checkout ${DRCU_REPO_COMMIT}

echo "Copying liblef and libdef into place"
cp ../OpenROAD/src/odb/src/lef/build/liblef.a rsyn/lib/linux/
cp ../OpenROAD/src/odb/src/def/build/libdef.a rsyn/lib/linux/

python3 scripts/build.py -o release -m"-j$(($(nproc) / 2))"

mkdir -p /foss/tools/${DRCU_NAME}/${REPO_COMMIT_SHORT}/bin/
cp run/ispd19dr /foss/tools/${DRCU_NAME}/${REPO_COMMIT_SHORT}/bin/drcu
