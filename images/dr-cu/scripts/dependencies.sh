#!/bin/bash


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

