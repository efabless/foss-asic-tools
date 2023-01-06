#!/bin/bash

set -e

apt-get update -y && apt-get upgrade -y
apt-get install -y tzdata
apt-get install -y \
	autoconf \
	automake \
	autotools-dev \
	binutils \
	bison \
	build-essential \
	bzip2 \
	ca-certificates \
	cargo \
	clang \
	cmake \
	csh \
	cython3 \
	doxygen \
	expat \
	flex \
	g++ \
	gawk \
	gcc \
	gdb \
	gettext \
	gfortran \
	ghostscript \
	git \
	gnat \
	gnupg2 \
	gperf \
	graphviz \
	gtk2-engines-pixbuf \
	help2man \
	language-pack-en-base \
	lcov \
	libasound2-dev \
	libblas-dev \
	libboost-all-dev \
	libbz2-dev \
	libc6-dev \
	libcairo2-dev \
	libcurl4-openssl-dev \
	libdw-dev \
	libedit-dev \
	libeigen3-dev \
	libexpat1-dev \
	libffi-dev \
	libfftw3-dev \
	libfindbin-libs-perl \
	libfl-dev \
	libgcc-9-dev \
	libgconf2-dev \
	libgettextpo-dev \
	libglu1-mesa-dev \
	libgomp1 \
	libgtk-3-dev \
	libgtk2.0-dev \
	libjpeg-dev \
	libjudy-dev \
	liblapack-dev \
	liblzma-dev \
	libmng-dev \
	libncurses-dev \
	libnss-wrapper \
	libomp-dev \
	libopenmpi-dev \
	libpcre++-dev \
	libpcre2-dev \
	libpcre3-dev \
	libpython3.8 \
	libqt5multimediawidgets5 \
	libqt5svg5-dev \
	libqt5xmlpatterns5-dev \
	libreadline-dev \
	libsm-dev \
	libspdlog-dev \
	libsqlite3-dev \
	libssl-dev \
	libstdc++-10-dev \
	libstdc++-9-dev \
	libsuitesparse-dev \
	libtcl \
	libtool \
	libwxgtk3.0-gtk3-dev \
	libx11-dev \
	libxaw7-dev \
	libxcb1-dev \
	libxext-dev \
	libxft-dev \
	libxml2-dev \
	libxpm-dev \
	libxrender-dev \
	libxslt1-dev \
	libyaml-dev \
	libz3-dev \
	libzip-dev \
	llvm-dev \
	make \
	ninja-build \
	nodejs \
	npm \
	openmpi-bin \
	openssl \
	patch \
	pciutils \
	pkg-config \
	python3 \
	python3-dev \
	python3-pip \
	qt5-default \
	qt5-image-formats-plugins \
	qtbase5-dev \
	qtmultimedia5-dev \
	qttools5-dev \
	ruby \
	ruby-dev \
	libruby2.7 \
	rustc \
	strace \
	swig \
	tcl-dev \
	tcllib \
	tcl-tclreadline \
	texinfo \
	time \
	tk-dev \
	unzip \
	uuid-dev \
	wget \
	xdot \
	xvfb \
	zip \
	zlib1g-dev 

# These packages will become available in 2204 LTS:
# binutils-gold \
# ruby-irb \
# liblemon-dev \
# ruby-rubygems \

# Upgrade pip and install important packages

# FIXME: PIP upgrade fails on x86, so remove it
# python3 -m pip install --upgrade pip

pip3 install --upgrade --no-cache-dir \
	amaranth \
	click \
	cocotb \
	gdsfactory \
	gdspy \
	gobject \
	graphviz \
	matplotlib \
	ninja \
	numpy \
	panda \
	plotly \
	psutil \
	pybind11 \
	pyrtl \
	pyspice \
	pyverilog \
	scikit-build \
	scipy \
	setuptools \
	setuptools-rust \
	shapely \
	siliconcompiler \
	spyci \
	tk \
	volare \
	wheel \
	xdot \
	xlsxwriter \
	xmltodict \
	yarl

# Install Ruby packages via gem:
gem install \
	rggen \
	rggen-verilog \
	rggen-vhdl

# Install node.js packages via npm:
npm install -g \
	netlistsvg

# FIXME Install cmake (need version >= 3.18 for ortools)
# FIXME Can be removed in 22.04LTS
apt-get remove -y cmake
CMAKE_VERSION=3.24
CMAKE_BUILD=1
install_cmake () {
	cd /tmp || exit 1
	wget --no-verbose "https://cmake.org/files/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.$CMAKE_BUILD.tar.gz"
	tar -xzvf "cmake-$CMAKE_VERSION.$CMAKE_BUILD.tar.gz"
	cd "cmake-$CMAKE_VERSION.$CMAKE_BUILD"
	./bootstrap
	make -j"$(nproc)"
	make install
}
install_cmake

# Install lemon-1.3.1 (will become available via apt in 2204)
#
LEMON_VERSION=1.3.1
install_lemon () {
	cd /tmp || exit 1
	wget --no-verbose "http://lemon.cs.elte.hu/pub/sources/lemon-$LEMON_VERSION.tar.gz"
	md5sum -c <(echo "e89f887559113b68657eca67cf3329b5  lemon-$LEMON_VERSION.tar.gz") || exit 1
	tar -xf "lemon-$LEMON_VERSION.tar.gz"
	cd "lemon-$LEMON_VERSION" || exit 1
	cmake -B build .
	cmake --build build -j "$(nproc)" --target install
}
install_lemon

# Install or-tools (dependcy of OpenROAD)
#
ORTOOLS_VERSION=9.4
install_ortools () {
	cd /tmp || exit 1
	wget --no-verbose "https://github.com/google/or-tools/archive/refs/tags/v$ORTOOLS_VERSION.tar.gz"
	tar -xf "v$ORTOOLS_VERSION.tar.gz"
	cd "or-tools-$ORTOOLS_VERSION" || exit 1
    cmake -B build . -DBUILD_DEPS:BOOL=ON
    cmake --build build -j "$(nproc)" --target install
}
install_ortools

# Cleanup to minimize image size
rm -rf /tmp/*
apt -y autoremove
apt -y autoclean
