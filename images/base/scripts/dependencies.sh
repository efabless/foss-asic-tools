#!/bin/bash

yum update -y

#yum upgrade -y
#yum install -y https://repo.ius.io/ius-release-el7.rpm 

yum install yum-utils -y
dnf config-manager --set-enabled powertools
yum install epel-release -y

yum group install "Development Tools" -y

#yum install centos-release-scl -y
yum install -y \
	alsa-lib \
	alsa-lib-devel \
	autoconf \
	automake \
	bison \
	blas \
	blas-devel \
	bzip2 \
	bzip2-devel \
	ca-certificates \
	cairo \
	cairo-devel \
	clang \
	cmake \
	csh \
	curl \
	fftw \
	fftw-devel \
	flex \
	flex-devel \
	gawk \
	gcc \
	gcc-c++ \
	gcc-gnat \
	gcc-toolset-9 \
	gcc-toolset-9-gcc-gfortran \
	gcc-toolset-9-libatomic-devel \
	gdb \
	gettext \
	gettext-devel \
	git \
	glibc-static \
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
	openmpi \
	openmpi-devel \
	patch \
	pciutils \
	pciutils-libs \
	pcre-devel \
	python3 \
	python3-Cython \
	python3-devel \
	python3-jinja2 \
	python3-matplotlib \
	python3-numpy \
	python3-pandas \
	python3-pip \
	python3-tkinter \
	python3-xlsxwriter \
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
	zlib-static

#	boost-devel \
#	boost-static \
#	xdot \

#alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 60

#pip3.6 install --no-cache-dir --upgrade pip
#pip install --no-cache-dir \
#	matplotlib \
#	"jinja2<3.0.0" \
#	pandas \
#	install \
#	XlsxWriter

pip3 install --no-cache-dir install
pip3 install --no-cache-dir wheel
pip3 install --no-cache-dir \
	pyinstaller \
	pyverilog \
	pyyaml \
	click \
	volare>=0.1.3 \
	spyci

# eigen-3.3, lemon-1.3.1, boost-1.76.0 are required for OpenROAD (which is used in OpenLane)
# shellcheck disable=SC1091
source scl_source enable gcc-toolset-9
#
# Install boost-1.76.0
#
install_boost () {
	cd /tmp || exit
	wget --no-verbose https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.gz
	md5sum -c <(echo "e425bf1f1d8c36a3cd464884e74f007a  boost_1_76_0.tar.gz") || exit 1
	tar -xf boost_1_76_0.tar.gz
	cd boost_1_76_0 || exit
	#FIXME somehow Python is not found by build script, thus need this WA
	./bootstrap.sh --with-python=python3 --with-python-version=3.6 --with-python-root=/usr/bin/python3
	sed -i 's+"/usr/bin/python3"+/usr/bin/python3 : /usr/include/python3.6m : /usr/lib+g' project-config.jam
	./b2 install
}
install_boost
#
# Install eigen-3.3
#
install_eigen () {
	cd /tmp || exit
	git clone -b 3.3 https://gitlab.com/libeigen/eigen.git
	cd eigen || exit
	cmake -B build .
	cmake --build build -j "$(nproc)" --target install
}
install_eigen
#
# Install lemon-1.3.1
#
install_lemon () {
	cd /tmp || exit
	wget --no-verbose http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz
	md5sum -c <(echo "e89f887559113b68657eca67cf3329b5  lemon-1.3.1.tar.gz") || exit 1
	tar -xf lemon-1.3.1.tar.gz
	cd lemon-1.3.1 || exit
	cmake -B build .
	cmake --build build -j "$(nproc)" --target install
}
install_lemon

rm -rf /tmp/*
