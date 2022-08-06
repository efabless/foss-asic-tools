#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"

yum -y install epel-release 

yum -y update

yum install -y \
	git \
	qt-devel \
	octave \
	openmpi-devel \
	ruby-devel \
	tcl \
	tk \
	tcllib \
	wxGTK-devel \
	xorg-x11-server-Xvfb \
	sudo  

yum install -y \
	wget \
	net-tools \
	nmap \
	bzip2 \
	mailcap \
	numpy \
	gedit \
	xterm \
	meld 
	
mkdir -p /foss/tools


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


