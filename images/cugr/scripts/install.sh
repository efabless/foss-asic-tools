#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

xxd -i src/flute/POST9.dat > src/flute/POST9.c
xxd -i src/flute/POWV9.dat > src/flute/POWV9.c

mkdir -p build
cd build
cmake ../src
make -j$(nproc)
mkdir -p /foss/tools/${NAME}/${REPO_COMMIT}/bin/
cp iccad19gr /foss/tools/${NAME}/${REPO_COMMIT}/bin/cugr
