#!/bin/bash

set -e

UBUNTU_VERSION=$(awk -F= '/^VERSION_ID/{print $2}' /etc/os-release | sed 's/"//g')

apt-get -y update && apt-get -y upgrade
apt-get -y install tzdata software-properties-common

echo "[INFO] Adding Mozilla PPA"
add-apt-repository -y ppa:mozillateam/ppa
# Add PPA to apt preferences list, so PPA > snap
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | tee /etc/apt/preferences.d/mozilla-firefox

if [[ $UBUNTU_VERSION == 20.04 ]]; then
echo "[INFO] Install APT packages for Ubuntu 20.04"
apt-get -y install \
	autoconf \
	automake \
	autotools-dev \
	bc \
	binutils \
	bison \
	build-essential \
	bzip2 \
	ca-certificates \
	cargo \
	clang \
	cmake \
	csh \
	curl \
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
	git-svn \
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
	libgmp-dev \
	libgomp1 \
	libgtk-3-dev \
	libgtk2.0-dev \
	libjpeg-dev \
	libjudy-dev \
	liblapack-dev \
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
	libpython3.8 \
	libqt5multimediawidgets5 \
	libqt5svg5-dev \
	libqt5widgets5 \
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
	patchutils \
	pciutils \
	pkg-config \
	python3 \
	python3-dev \
	python3-pip \
	python3-tk \
	python3-venv \
	qt5-default \
	qt5-image-formats-plugins \
	qtbase5-dev \
	qtmultimedia5-dev \
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
elif [[ $UBUNTU_VERSION == 22.04 ]]; then
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
	clang \
	cmake \
	csh \
	curl \
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
	libxaw7-dev \
	libxcb1-dev \
	libxext-dev \
	libxft-dev \
	libxml2-dev \
	libxpm-dev \
	libxrender-dev \
	libxslt-dev \
	libyaml-dev \
	libz3-dev \
	libzip-dev \
	llvm-13-dev \
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

	update-alternatives --install /usr/bin/python python /usr/bin/python3 0	
	update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-13 0
else
	echo "Ubuntu version not supported!"
	exit 1
fi


# Need libboost >= 1.78 for OpenROAD
apt-get -y remove libboost-all-dev
BOOST_VER_MAJ=1
BOOST_VER_MIN=81	
BOOST_BUILD=0
echo "[INFO] Installing BOOST version $BOOST_VER_MAJ.$BOOST_VER_MIN.$BOOST_BUILD.$BOOST_BUILD"
_install_boost () {
	cd /tmp
	wget https://boostorg.jfrog.io/artifactory/main/release/$BOOST_VER_MAJ.$BOOST_VER_MIN.$BOOST_BUILD/source/boost_${BOOST_VER_MAJ}_${BOOST_VER_MIN}_${BOOST_BUILD}.tar.gz
	tar -xf boost_${BOOST_VER_MAJ}_${BOOST_VER_MIN}_${BOOST_BUILD}.tar.gz
	cd boost_${BOOST_VER_MAJ}_${BOOST_VER_MIN}_${BOOST_BUILD}
	./bootstrap.sh
	./b2 install
}
_install_boost

if [[ $UBUNTU_VERSION == 20.04 ]]; then
	apt-get -y remove cmake
	CMAKE_VERSION=3.25
	CMAKE_BUILD=2
	echo "[INFO] Installing CMAKE version $CMAKE_VERSION.$CMAKE_BUILD for Ubuntu 20.04"
	_install_cmake () {
		cd /tmp || exit 1
		wget --no-verbose "https://cmake.org/files/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.$CMAKE_BUILD.tar.gz"
		tar -xzvf "cmake-$CMAKE_VERSION.$CMAKE_BUILD.tar.gz"
		cd "cmake-$CMAKE_VERSION.$CMAKE_BUILD"
		./bootstrap
		make -j"$(nproc)"
		make install
	}
	_install_cmake
fi

# Install lemon-1.3.1 (will become available via apt in 22.04LTS)
if [[ $UBUNTU_VERSION == 20.04 ]]; then
	LEMON_VERSION=1.3.1
	echo "[INFO] Installing LEMON version $LEMON_VERSION for Ubuntu 20.04"
	_install_lemon () {
		cd /tmp || exit 1
		wget --no-verbose "http://lemon.cs.elte.hu/pub/sources/lemon-$LEMON_VERSION.tar.gz"
		md5sum -c <(echo "e89f887559113b68657eca67cf3329b5  lemon-$LEMON_VERSION.tar.gz") || exit 1
		tar -xf "lemon-$LEMON_VERSION.tar.gz"
		cd "lemon-$LEMON_VERSION" || exit 1
		cmake -B build .
		cmake --build build -j "$(nproc)" --target install
	}
	_install_lemon
fi

# Install or-tools (dependency of OpenROAD)
ORTOOLS_VERSION=9.5
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
	gobject \
	graphviz \
	matplotlib \
	maturin \
	ninja \
	numpy \
	panda \
	plotly \
	psutil \
	pybind11 \
	pyyaml \
	scikit-build \
	scipy \
	setuptools \
	setuptools-rust \
	shapely \
	tk \
	wheel \
	xdot \
	xlsxwriter \
	xmltodict \
	yarl

echo "[INFO] Install EDA packages via PIP"
pip3 install --upgrade --no-cache-dir \
	amaranth \
	cocotb \
	edalize \
	fusesoc \
	gdsfactory \
	gdspy \
	openlane \
	openram \
	pyrtl \
	pyspice \
	pyverilog \
	siliconcompiler \
	spyci \
	volare

pip3 install --upgrade --no-cache-dir \
	jupyterlab \


# Install Ruby packages via gem:
gem install \
	rggen \
	rggen-verilog \
	rggen-vhdl

# Install node.js packages via npm:
npm install -g \
	netlistsvg

# Cleanup to minimize image size
rm -rf /tmp/*
apt-get -y autoremove --purge
apt-get -y clean
