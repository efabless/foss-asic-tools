#!/bin/bash

yum install -y \
	alsa-lib-devel \
	gtk3-devel \
	libXpm-devel

yum install -y libX11 libX11-devel libXrender libXrender-devel \
		libxcb  libxcb-devel cairo \
		cairo-devel tcl tcl-devel tk tk-devel \
		flex bison libXpm libXpm-devel gawk 

