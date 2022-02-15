#!/bin/bash

#yum install -y centos-release-scl git devtoolset-8-gcc devtoolset-8-gcc-c++
#source scl_source enable devtoolset-8
#scl enable devtoolset-8 bash
   

git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git
cd OpenROAD/
git submodule update --init --recursive
./etc/DependencyInstaller.sh -dev
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX="/foss/tools/openroad"
make
make install


 
