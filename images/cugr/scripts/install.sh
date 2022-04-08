#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

echo "Copying newly built liblef and libdef into place"
cp ../OpenROAD/src/odb/src/lef/build/liblef.a rsyn/lib/linux/
cp ../OpenROAD/src/odb/src/def/build/libdef.a rsyn/lib/linux/

#mkdir -p build
#cd build
#cmake ../src
#make -j$(nproc)

python3 scripts/build.py -o release -m"-j$(nproc)"

mkdir -p /foss/tools/${NAME}/${REPO_COMMIT}/bin/
cp run/iccad19gr /foss/tools/${NAME}/${REPO_COMMIT}/bin/cugr
