#!/bin/bash

set -e

apt-get update -y && apt-get upgrade -y

apt-get install -y \
	autoconf \
	automake \
	binutils-gold \
	bison \
	build-essential \
	bzip2 \
	ca-certificates \
	cargo \
	clang \
	cmake \
	csh \
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
	gperf \
	graphviz \
	gtk2-engines-pixbuf \
	help2man \
	libasound2-dev \
	libblas-dev \
	libboost-all-dev \
	libbz2-dev \
	libcairo2-dev \
	libcurl4-openssl-dev \
	libdw-dev \
	libedit-dev \
	libeigen3-dev \
	libffi-dev \
	libfftw3-dev \
	libfl-dev \
	libgconf2-dev \
	libglu1-mesa-dev \
	libgomp1 \
	libgtk-3-dev \
	libgtk2.0-dev \
	libjpeg-dev \
	libjudy-dev \
	liblapack-dev \
	liblemon-dev \
	liblzma-dev \
	libmng-dev \
	libncurses-dev \
	libopenmpi-dev \
	libpcre++-dev \
	libqt5multimediawidgets5 \
	libqt5svg5-dev \
	libqt5xmlpatterns5-dev \
	libreadline-dev \
	libsm-dev \
	libspdlog-dev \
	libstdc++-11-dev \
	libsuitesparse-dev \
	libtool \
	libwxgtk3.0-gtk3-dev \
	libx11-dev \
	libxaw7-dev \
	libxcb1-dev \
	libxft-dev \
	libxml2-dev \
	libxpm-dev \
	libxrender-dev \
	libxslt-dev \
	libyaml-dev \
	libzip-dev \
	llvm-13-dev \
	make \
	ninja-build \
	nodejs \
	npm \
	openmpi-bin \
	patch \
	pciutils \
	pkg-config \
	python3 \
	python3-dev \
	python3-pip \
	qtbase5-dev \
	qtmultimedia5-dev \
	qttools5-dev \
	ruby \
	ruby-dev \
	ruby-irb \
	ruby-rubygems \
	rustc \
	strace \
	swig \
	tcl-dev \
	tcllib \
	texinfo \
	time \
	tk-dev \
	unzip \
	vim-common \
	wget \
	xdot \
	xvfb \
	zip \
	zlib1g-dev 
  
# Upgrade pip and install important packages

# FIXME: PIP upgrade fails on x86, so remove it
# python3 -m pip install --upgrade pip

pip3 install --no-cache-dir \
	amaranth \
	click \
	cmake \
	cocotb \
	gdsfactory \
	gdspy \
	matplotlib \
	ninja \
	notebook \
	panda \
	pandas \
	plotly \
	pyinstaller \
	pyrtl \
	pyspice \
	pyverilog \
	pyyaml \
	scikit-build \
	setuptools-rust \
	siliconcompiler \
	spyci \
	tk \
	volare \
	xdot \
	XlsxWriter

# Install Ruby packages via gem:
gem install \
	rggen \
	rggen-markdown \
	rggen-verilog \
	rggen-vhdl

# Install node.js packages via npm:
npm install -g \
	netlistsvg

rm -rf /tmp/*
