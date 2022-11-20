#!/bin/bash

set -e

apt-get update -y && apt-get upgrade -y

apt-get install -y \
	autoconf \
	automake \
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
	libopenmpi-dev \
	libpcre++-dev \
	libpython2.7 \
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
	python3-aiohttp \
	python3-async-timeout \
	python3-cffi \
	python3-click \
	python3-cryptography \
	python3-gdspy \
	python3-graphviz \
	python3-jinja2 \
	python3-matplotlib \
	python3-multidict \
	python3-netifaces \
	python3-notebook \
	python3-numpy \
	python3-pandas \
	python3-plotly \
	python3-psutil \
	python3-pybind11 \
	python3-pycparser \
	python3-pydantic \
	python3-qrcode \
	python3-requests \
	python3-scipy \
	python3-shapely \
	python3-setuptools \
	python3-tabulate \
	python3-tk \
	python3-toolz \
	python3-tqdm \
	python3-typing-extensions \
	python3-watchdog \
	python3-wheel \
	python3-xlsxwriter \
	python3-xmltodict \
	python3-yarl \
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
	texinfo \
	time \
	tk-dev \
	tzdata \
	unzip \
	uuid-dev \
	vim-common \
	wget \
	xdot \
	xvfb \
	zip \
	zlib1g-dev 

# These packages will become available in 2204:
# binutils-gold \
# ruby-irb \
# liblemon-dev \
# python3-aiosignal \
# python3-antlr4 \
# python3-charset-normalizer \
# python3-click-default-group \
# python3-commonmark \
# python3-frozenlist \
# python3-installer \
# python3-loguru \
# python3-rich \
# python3-setuptools-rust \
# python3-skbuild \
# ruby-rubygems \

# Upgrade pip and install important packages

# FIXME: PIP upgrade fails on x86, so remove it
# python3 -m pip install --upgrade pip

pip3 install --no-cache-dir \
	amaranth \
	cocotb \
	gdsfactory \
	gobject \
	ninja \
	panda \
	pyrtl \
	pyspice \
	pyverilog \
	scikit-build \
	setuptools-rust \
	siliconcompiler \
	spyci \
	volare \
	xdot

# Install Ruby packages via gem:
gem install \
	rggen \
	rggen-markdown \
	rggen-verilog \
	rggen-vhdl

# Install node.js packages via npm:
npm install -g \
	netlistsvg

# Install lemon-1.3.1 (will become available via apt in 2204)
#
install_lemon () {
	cd /tmp || exit 1
	wget --no-verbose http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz
	md5sum -c <(echo "e89f887559113b68657eca67cf3329b5  lemon-1.3.1.tar.gz") || exit 1
	tar -xf lemon-1.3.1.tar.gz
	cd lemon-1.3.1 || exit 1
	cmake -B build .
	cmake --build build -j "$(nproc)" --target install
}
install_lemon

rm -rf /tmp/*
