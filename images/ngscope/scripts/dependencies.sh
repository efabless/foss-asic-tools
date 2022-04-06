#!/bin/bash

#yum -y install \
#    autoconf \
#    automake \
#    bison \
#    bzip2-devel \
#    ca-certificates \
#    cmake \
#    curl \
#    flex \
#    gawk \
#    gcc-c++ \
#    git \
#    graphviz \
#    libffi-devel \
#    libstdc++-static \
#    libtool \
#    make \
#    readline-devel \
#    tcl \
#    tcl-devel \
#    tk \
#    tk-devel \
#    unzip \
#    wget \
#    wxGTK3-devel \
#    xz-devel \
#    zip \
#    zlib-devel

#cmakeVersionBig=3.14
#cmakeVersionSmall=${cmakeVersionBig}.0
#install_cmake() {
#	wget https://cmake.org/files/v${cmakeVersionBig}/cmake-${cmakeVersionSmall}-Linux-x86_64.sh
#	md5sum -c <(echo "73041a43d27a30cdcbfdfdb61310d081  cmake-${cmakeVersionSmall}-Linux-x86_64.sh") || exit 1
#	chmod +x cmake-${cmakeVersionSmall}-Linux-x86_64.sh
#	./cmake-${cmakeVersionSmall}-Linux-x86_64.sh --skip-license --prefix=/usr/local
#}
#install_cmake