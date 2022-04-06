#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"

yum -y install epel-release 

yum -y update

yum install -y \
	bzip2 \
	gedit \
	git \
	htop \
	mailcap \
	meld \
	net-tools \
	nmap \
	octave \
	sudo \
	tcl \
	tcllib \
	tk \
	vim \
	wget \
	xorg-x11-server-Xvfb \
	xterm

#	ruby-devel
#	python3-numpy
#	openmpi-devel
#	qt-devel
#	wxGTK-devel