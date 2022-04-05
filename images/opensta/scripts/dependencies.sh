#!/bin/bash

set -x
cmakeVersionBig=3.17
cmakeVersionSmall=${cmakeVersionBig}.0

install_cmake() {
	wget https://cmake.org/files/v${cmakeVersionBig}/cmake-${cmakeVersionSmall}-Linux-x86_64.sh -q
	chmod +x cmake-${cmakeVersionSmall}-Linux-x86_64.sh
	./cmake-${cmakeVersionSmall}-Linux-x86_64.sh --skip-license --prefix=/usr/local
}


#install_cmake
yum install -y cmake
