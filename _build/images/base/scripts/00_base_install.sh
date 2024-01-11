#!/bin/bash

set -e

# Setup Sources and Bootstrap APT

echo "[INFO] Updating, upgrading and installing packages with APT"
apt-get -y update
apt-get -y upgrade
apt-get -y install \
	autoconf \
	automake \
	autotools-dev \
	bc \
	binutils-gold \
	bison \
	build-essential \
	bzip2 \
	ca-certificates \
	cargo \
	clang-15 \
	clang-tools-15 \
	cmake \
	csh \
	curl \
	cython3 \
	debhelper \
	desktop-file-utils \
	devscripts \
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
	gnat-11 \
	gnupg2 \
	gperf \
	gpg \
	graphviz \
	gtk2-engines-pixbuf \
	help2man \
	language-pack-en-base \
	lcov \
	libasound2-dev \
	libblas-dev \
	libbz2-dev \
	libc6-dev \
	libcairo2-dev \
	libclang-common-15-dev \
	libcurl4-openssl-dev \
	libdw-dev \
	libedit-dev \
	libeigen3-dev \
	libexpat1-dev \
	libffi-dev \
	libfftw3-dev \
	libfindbin-libs-perl \
	libfl-dev \
	libgcc-11-dev \
	libgconf2-dev \
	libgettextpo-dev \
	libgirepository1.0-dev \
	libglu1-mesa-dev \
	libgit2-dev \
	libgmp-dev \
	libgomp1 \
	libgtk-3-dev \
	libgtk2.0-dev \
	libjpeg-dev \
	libjudy-dev \
	liblapack-dev \
	liblemon-dev \
	liblzma-dev \
	libmng-dev \
	libmpc-dev \
	libmpfr-dev \
	libncurses-dev \
	libnss-wrapper \
	libomp-dev \
	libopenmpi-dev \
	libpcre++-dev \
	libpcre2-dev \
	libpcre3-dev \
	libpython3.10 \
	libqt5multimediawidgets5 \
	libqt5svg5-dev \
	libqt5xmlpatterns5-dev \
	libreadline-dev \
	libre2-dev \
	libsm-dev \
	libspdlog-dev \
	libsqlite3-dev \
	libssl-dev \
	libstdc++-11-dev \
	libsuitesparse-dev \
	libtcl \
	libtool \
	libwxgtk3.0-gtk3-dev \
	libx11-dev \
	libx11-xcb-dev \
	libxaw7-dev \
	libxcb1-dev \
	libxext-dev \
	libxft-dev \
	libxml2-dev \
	libxpm-dev \
	libxrender-dev \
	libxslt-dev \
	libyaml-dev \
	libz-dev \
	libz3-dev \
	libzip-dev \
	libzstd-dev \
	lld-15 \
	llvm-15 \
	llvm-15-dev \
	make \
	ninja-build \
	nodejs \
	npm \
	openmpi-bin \
	openssl \
	patch \
	patchutils \
	pciutils \
	pkg-config \
	python3 \
	python3-click \
	python3-cvxopt \
	python3-dev \
	python3-flask \
	python3-graphviz \
	python3-matplotlib \
	python3-numpy \
	python3-pip \
	python3-plotly \
	python3-psutil \
	python3-pybind11 \
	python3-pyqt5 \
	python3-pytest \
	python3-scipy \
	python3-setuptools \
	python3-setuptools-rust \
	python3-shapely \
	python3-tk \
	python3-venv \
	python3-virtualenv \
	python3-wheel \
	python3-xlsxwriter \
	python3-xmltodict \
	python3-yarl \
	qt5-image-formats-plugins \
	qt5-qmake \
	qtbase5-dev \
	qtbase5-dev-tools \
	qtchooser \
	qtmultimedia5-dev \
	qttools5-dev \
	ruby \
	ruby-dev \
	ruby-irb \
	ruby-rubygems \
	rustc \
	strace \
	swig \
	tcl \
	tcl-dev \
	tcllib \
	tcl-tclreadline \
	texinfo \
	time \
	tk-dev \
	tzdata \
	unzip \
	uuid-dev \
	wget \
	xdot \
	xvfb \
	zip \
	zlib1g-dev

update-alternatives --install /usr/bin/python python /usr/bin/python3 0	

cd /usr/lib/llvm-15/bin
for f in *; do rm -f /usr/bin/"$f"; \
    ln -s ../lib/llvm-15/bin/"$f" /usr/bin/"$f"
done

echo "[INFO] Cleaning up caches"
rm -rf /tmp/*
apt-get -y autoremove --purge
apt-get -y clean