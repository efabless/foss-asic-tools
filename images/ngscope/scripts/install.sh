#!/bin/bash


wget https://sourceforge.net/projects/ngscope/files/rel_0_9/ngscope_0_9_5.tar.bz2

tar -xvf ngscope_0_9_5.tar.bz2
cd ngscope
mkdir build
cd build

prefix=/foss/tools/${NAME}/${REPO_COMMIT}
cmake -DCMAKE_INSTALL_PREFIX=$prefix ..
make -j$(nproc)
make DESTDIR=$prefix install
