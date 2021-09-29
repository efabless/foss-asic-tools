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
	gedit
	
