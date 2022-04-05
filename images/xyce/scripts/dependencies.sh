#!/bin/bash

yum -y install gcc-toolset-9-gcc-gfortran
yum -y install make bison libtool cmake
yum -y install suitesparse-devel flex-devel fftw-devel blas-devel lapack-devel openmpi-devel

#cmakeVersionBig=3.17
#cmakeVersionSmall=${cmakeVersionBig}.0

#install_cmake() {
#	wget https://cmake.org/files/v${cmakeVersionBig}/cmake-${cmakeVersionSmall}-Linux-x86_64.sh
#	chmod +x cmake-${cmakeVersionSmall}-Linux-x86_64.sh
#	./cmake-${cmakeVersionSmall}-Linux-x86_64.sh --skip-license --prefix=/usr/local
#}

#install_cmake
