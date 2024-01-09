#!/bin/bash

set -e

# Bootstrap APT
apt-get -y update && apt-get -y upgrade
apt-get -y install tzdata software-properties-common wget gpg lsb-release

# Preparations for adding Firefox later
echo "[INFO] Adding Mozilla PPA"
add-apt-repository -y ppa:mozillateam/ppa
# Add PPA to apt preferences list, so PPA > snap
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | tee /etc/apt/preferences.d/mozilla-firefox

# Preparations for adding VS Code later
echo "[INFO] Adding APT package for VS Code"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt-get -y update && apt-get -y upgrade

# See which Ubuntu version we are building in
UBUNTU_VERSION=$(lsb_release -r -s)

if [[ $UBUNTU_VERSION == 22.04 ]]; then
echo "[INFO] Install APT packages for Ubuntu 22.04"
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
	python3-dev \
	python3-pip \
	python3-tk \
	python3-venv \
	python3-cvxopt \
	python3-pyqt5 \
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
	unzip \
	uuid-dev \
	xdot \
	xvfb \
	zip \
	zlib1g-dev

	update-alternatives --install /usr/bin/python python /usr/bin/python3 0	

	cd /usr/lib/llvm-15/bin
	for f in *; do rm -f /usr/bin/"$f"; \
		ln -s ../lib/llvm-15/bin/"$f" /usr/bin/"$f"
	done
else
	echo "[ERROR] Ubuntu version is not supported!"
	exit 1
fi


# Need libboost >= 1.78 for OpenROAD
apt-get -y remove libboost-all-dev
BOOST_VER_MAJ=1
BOOST_VER_MIN=82	
BOOST_BUILD=0
BOOST_VERSION="$BOOST_VER_MAJ.$BOOST_VER_MIN.$BOOST_BUILD"
echo "[INFO] Installing BOOST version $BOOST_VERSION"
_install_boost () {
	cd /tmp
	# wget --no-verbose -O boost_${BOOST_VER_MAJ}_${BOOST_VER_MIN}_${BOOST_BUILD}.tar.gz https://sourceforge.net/projects/boost/files/boost/$BOOST_VER_MAJ.$BOOST_VER_MIN.$BOOST_BUILD/boost_${BOOST_VER_MAJ}_${BOOST_VER_MIN}_${BOOST_BUILD}.tar.gz/download

	# as of 2024-01-08, this redirects us to a web page
	# wget --no-verbose https://boostorg.jfrog.io/artifactory/main/release/$BOOST_VER_MAJ.$BOOST_VER_MIN.$BOOST_BUILD/source/boost_${BOOST_VER_MAJ}_${BOOST_VER_MIN}_${BOOST_BUILD}.tar.gz

	wget --no-verbose https://github.com/boostorg/boost/releases/download/boost-${BOOST_VERSION}/boost-${BOOST_VERSION}.tar.gz
	tar -xf boost-${BOOST_VERSION}.tar.gz
	cd boost-${BOOST_VERSION}
	./bootstrap.sh
	./b2 install
}
_install_boost


# Install or-tools (dependency of OpenROAD)
ORTOOLS_VERSION=9.6
echo "[INFO] Installing ORTOOLS version $ORTOOLS_VERSION"
_install_ortools () {
	cd /tmp || exit 1
	wget --no-verbose "https://github.com/google/or-tools/archive/refs/tags/v$ORTOOLS_VERSION.tar.gz"
	tar -xf "v$ORTOOLS_VERSION.tar.gz"
	cd "or-tools-$ORTOOLS_VERSION" || exit 1
    cmake -B build . -DBUILD_DEPS:BOOL=ON
    cmake --build build -j "$(nproc)" --target install
}
_install_ortools


# Upgrade pip and install important packages
# FIXME: PIP upgrade fails on x86, so remove it
#python3 -m pip install --upgrade pip

echo "[INFO] Install support packages via PIP"
pip3 install --upgrade --no-cache-dir \
	click \
	flask \
	gobject \
	graphviz \
	libparse \
	matplotlib \
	maturin \
	meson \
	ninja \
	numpy \
	panda \
	plotly \
	psutil \
	pybind11 \
	pytest \
	pyyaml \
	scikit-build \
	scipy \
	setuptools \
	setuptools-rust \
	shapely \
	tk \
	virtualenv \
	wheel \
	xdot \
	xlsxwriter \
	xmltodict \
	yarl


# Cleanup to minimize image size
rm -rf /tmp/*
apt-get -y autoremove --purge
apt-get -y clean
