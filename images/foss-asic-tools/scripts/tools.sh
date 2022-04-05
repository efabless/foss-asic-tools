#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"

yum -y install epel-release 

yum -y update

yum install -y \
	git \
	octave \
	openmpi-devel \
	ruby-devel \
	tcl \
	tk \
	tcllib \
	xorg-x11-server-Xvfb \
	sudo \  
	htop \
	wget \
	net-tools \
	nmap \
	bzip2 \
	mailcap \
	python3-numpy \
	gedit \
	xterm \
	meld
#	qt-devel
#	wxGTK-devel

