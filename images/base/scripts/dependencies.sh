#!/bin/bash

set -e

yum update -y
yum install yum-utils -y
# powertools are crb from Rocky 9 and (hopefully) up.
dnf config-manager --set-enabled crb
yum install epel-release -y
yum group install "Development Tools" -y

# Notes: Only install curl-devel and openssl-devel because of version mismatches in Rocky 9!
yum install -y \
	alsa-lib \
	alsa-lib-devel \
	autoconf \
	automake \
	binutils-gold \
	bison \
	blas \
	blas-devel \
	boost \
	boost-devel \
	bzip2 \
	bzip2-devel \
	ca-certificates \
	cairo \
	cairo-devel \
	cargo \
	clang \
	cmake \
	csh \
	curl-devel \
	eigen3-devel \
	expat \
	expat-devel \
	fftw \
	fftw-devel \
	flex \
	flex-devel \
	gawk \
	gcc \
	gcc-c++ \
	gcc-gfortran \
	gcc-gnat \
	gdb \
	gettext \
	gettext-devel \
	ghostscript \
	git \
	glibc-langpack-en \
	glibc-static \
	gobject-introspection-devel \
	gperf \
	graphviz \
	gtk3 \
	gtk3-devel \
	help2man \
	langpacks-en \
	lapack \
	lapack-devel \
	libffi \
	libffi-devel \
	libgomp \
	libjpeg \
	libmng \
	libSM \
	libstdc++ \
	libstdc++-static \
	libtool \
	libX11 \
	libX11-devel \
	libXaw \
	libXaw-devel \
	libxcb \
	libxcb-devel \
	libXext \
	libXft \
	libxml2-devel \
	libXpm \
	libXpm-devel \
	libXrender \
	libXrender-devel \
	libxslt-devel \
	libyaml \
	llvm \
	llvm-devel \
	make \
	mesa-libGLU-devel \
	ncurses-devel \
	ninja-build \
	nodejs \
	openmpi \
	openmpi-devel \
	openssl-devel \
	patch \
	pciutils \
	pciutils-libs \
	pcre-devel \
	perl-FindBin \
	python3 \
	python3-Cython \
	python3-pip \
	python3-pyyaml \
	python3-scipy \
	qt5-devel \
	qt5-qtbase \
	qt5-qtmultimedia \
	qt5-qtsvg \
	qt5-qttools \
	qt5-qtxmlpatterns \
	readline-devel \
	ruby \
	ruby-devel \
	ruby-irb \
	ruby-libs \
	rubygem-bigdecimal \
	rubygem-io-console \
	rubygem-json \
	rubygem-psych \
	rubygem-rdoc \
	rubygems \
	rust \
	spdlog \
	spdlog-devel \
	strace \
	suitesparse \
	suitesparse-devel \
	swig \
	tcl \
	tcl-devel \
	texinfo \
	time \
	tk \
	tk-devel \
	unzip \
	vim-common \
	wget \
	which \
	wxGTK3 \
	wxGTK3-devel \
	Xvfb \
	xz-devel \
	zip \
	zlib-devel \
	zlib-static \
    python3-devel \
    python3-gobject \
    python3-jinja2 \
    python3-numpy \
    python3-tkinter

pip3 install --no-cache-dir \
	install wheel setuptools scikit-build setuptools-rust

# Install Python packages via pip:
pip3 install --no-cache-dir \
	amaranth \
	click \
	cocotb \
	gdsfactory \
	gdspy \
	matplotlib \
	pandas \
	plotly \
	pyinstaller \
	pyrtl \
	pyspice \
	pyverilog \
	siliconcompiler \
	spyci \
	tk \
	volare>=0.1.3 \
	xdot \
	XlsxWriter

# Install Ruby packages via gem:
gem install \
	rggen

# Install node.js packages via npm:
npm install -g \
	netlistsvg

# lemon-1.3.1 are required for OpenROAD (which is used in OpenLane)
# shellcheck disable=SC1091
#
# Install lemon-1.3.1
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


install_tcllib () {
	cd /tmp || exit 1
	wget --no-verbose https://core.tcl-lang.org/tcllib/uv/tcllib-1.21.tar.xz
	sha256sum -c <(echo "10c7749e30fdd6092251930e8a1aa289b193a3b7f1abf17fee1d4fa89814762f  tcllib-1.21.tar.xz") || exit 1
	tar -xf tcllib-1.21.tar.xz
	cd tcllib-1.21
	tclsh installer.tcl -no-gui -no-html -no-nroff -no-examples -pkg-path /usr/share/tk8.6/tcllib1.21 -app-path /usr/share/bin -no-wait
}
install_tcllib

rm -rf /tmp/*
