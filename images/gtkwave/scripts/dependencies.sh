#!/bin/bash
install_gpref() {
	wget http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
	tar -xvzf gperf-3.1.tar.gz &&  \
		cd gperf-3.1 &&  \
		autoconf &&   \
		./configure && \
		make -j$(nproc) &&  \
		make install
}

yum install -y \
	gtk3-devel \
	bzip2-devel

source scl_source enable devtoolset-8
install_gpref
