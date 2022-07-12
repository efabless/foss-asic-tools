#!/bin/bash

source scl_source enable gcc-toolset-11

set -e
set -u

echo "Getting OpenROAD source for liblef and libdef"
git clone https://github.com/The-OpenROAD-Project/OpenROAD.git
cd OpenROAD/src/odb/src
echo "Building liblef"
cd lef
mkdir build
cd build
cmake ..
make -j$(nproc)

echo "Building libdef"
cd ../../def
mkdir build
cd build
cmake ..
make -j$(nproc)
