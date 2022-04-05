#!/bin/bash

yum -y install bison flex gawk zlib-devel libtool wget git curl zip unzip
yum -y install autoconf automake make cmake gcc-c++ libstdc++-static
yum -y install curl libffi-devel readline-devel tcl tcl-devel graphviz tk tk-devel bzip2-devel xz-devel 
yum install -y ca-certificates
yum install -y wxGTK3-devel

#cmakeVersionBig=3.14
#cmakeVersionSmall=${cmakeVersionBig}.0

#install_cmake() {
#	wget https://cmake.org/files/v${cmakeVersionBig}/cmake-${cmakeVersionSmall}-Linux-x86_64.sh
#	md5sum -c <(echo "73041a43d27a30cdcbfdfdb61310d081  cmake-${cmakeVersionSmall}-Linux-x86_64.sh") || exit 1
#	chmod +x cmake-${cmakeVersionSmall}-Linux-x86_64.sh
#	./cmake-${cmakeVersionSmall}-Linux-x86_64.sh --skip-license --prefix=/usr/local
#}

#install_cmake
