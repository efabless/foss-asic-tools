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
cd /foss/tools
wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
tar xvf Python-3.10.0.tgz
cd Python-3.10.0
./configure --enable-optimizations
make altinstall
	
