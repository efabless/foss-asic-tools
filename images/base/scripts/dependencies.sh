#!/bin/bash


yum update -y
#yum upgrade -y

yum install -y https://repo.ius.io/ius-release-el7.rpm 
yum install centos-release-scl -y
yum install -y \
	autoconf \
	automake \
	bison \
	boost169-devel \
	boost169-static \
	bzip2 \
	cairo \
	cairo-devel \
	clang \
	csh \
	curl \
	devtoolset-8 \
	devtoolset-8-libatomic-devel \
	flex \
	gawk \
	gcc \
	gdb \
	gettext \
	gettext-devel \
	git \
	glibc-static \
	graphviz \
	help2man \
	libSM \
	libX11-devel \
	libXext \
	libXft \
	libffi \
	libffi-devel \
	libgomp \
	libjpeg \
	libstdc++ \
	libxml2-devel \
	libxslt-devel \
	make \
	mesa-libGLU-devel \
	ncurses-devel \
	ninja-build \
	patch \
	pcre-devel \
	python-devel \
	python36u \
	python36u-devel \
	python36u-libs \
	python36u-pip \
	python36u-tkinter \
	readline-devel \
	rh-python35 \
	strace \
	spdlog-devel \
	swig3 \
	tcl \
	tcl-devel \
	tcllib \
	tclx \
	texinfo \
	tk \
	tk-devel \
	vim-common \
	wget \
	which \
	xdot \
	Xvfb \
	zlib-devel \
	zlib-static
	
yum install -y \
  gcc-c++ \
  alsa-lib \
  libmng \
  libyaml \
  pciutils \
  pciutils-libs \
  qt \
  qt-devel \
  qt-settings \
  qt-x11 \
  ruby \
  ruby-devel \
  ruby-irb \
  ruby-libs \
  rubygem-bigdecimal \
  rubygem-io-console \
  rubygem-json \
  rubygem-psych \
  rubygem-rdoc \
  rubygems

yum -y install qt5-qtxmlpatterns-devel qt5-qtxmlpatterns-devel qt5-qtmultimedia-devel qt5-designer qt5-qtsvg-devel  qt5-qttools-devel




alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 60

pip3.6 install --no-cache-dir --upgrade pip
pip install --no-cache-dir \
	matplotlib \
	"jinja2<3.0.0" \
	pandas \
	install \
	XlsxWriter
