#!/bin/bash


yum update -y
#yum upgrade -y

#yum install -y https://repo.ius.io/ius-release-el7.rpm 
yum install yum-utils -y
dnf config-manager --set-enabled powertools
yum install epel-release -y

#yum install centos-release-scl -y
yum install -y \
	autoconf \
	automake \
	bison \
	boost-devel \
	boost-static \
	bzip2 \
	cairo \
	cairo-devel \
	clang \
	csh \
	curl \
	gcc-toolset-9 \
	gcc-toolset-9-libatomic-devel \
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
	python3 \
	python3-devel \
	python3-pip \
	python3-tkinter \
	python3-numpy \
	python3-Cython \
	python3-jinja2 \
	python3-matplotlib \
	python3-pandas \
	python3-xlsxwriter \
	readline-devel \
	strace \
	swig \
	tcl \
	tcl-devel \
	texinfo \
	tk \
	tk-devel \
	vim-common \
	wget \
	which \
	Xvfb \
	zlib-devel \
	zlib-static
# 	xdot

#alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 60

#pip3.6 install --no-cache-dir --upgrade pip
#pip install --no-cache-dir \
#	matplotlib \
#	"jinja2<3.0.0" \
#	pandas \
#	install \
#	XlsxWriter

pip3 install --no-cache-dir install
