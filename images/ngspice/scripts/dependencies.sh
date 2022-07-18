#!/bin/bash

apt -y install bison flex gawk zlib* libtool wget git curl zip unzip autoconf automake make 
apt -y install curl libffi-dev libreadline6* tcl tcl-dev libxaw* graphviz xdot tk tk-dev bzip2* xz*  gtk2* libwxgtk* libwxgtk3

cmakeVersionBig=3.14
cmakeVersionSmall=${cmakeVersionBig}.0

install_cmake() {
	wget https://cmake.org/files/v${cmakeVersionBig}/cmake-${cmakeVersionSmall}-Linux-x86_64.sh
	md5sum -c <(echo "73041a43d27a30cdcbfdfdb61310d081  cmake-${cmakeVersionSmall}-Linux-x86_64.sh") || exit 1
	chmod +x cmake-${cmakeVersionSmall}-Linux-x86_64.sh
	./cmake-${cmakeVersionSmall}-Linux-x86_64.sh --skip-license --prefix=/usr/local
}


install_cmake
