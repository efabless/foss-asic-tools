#!/bin/bash

yum install -y centos-release-scl git devtoolset-8-gcc devtoolset-8-gcc-c++
source scl_source enable devtoolset-8
scl enable devtoolset-8 bash


git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git
cd OpenROAD/
git submodule update --init --recursive
./etc/DependencyInstaller.sh -dev
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX="/foss/tools/openroad"
make
make install


 
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev

curl -O https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz
tar -xf Python-3.8.2.tar.xz
