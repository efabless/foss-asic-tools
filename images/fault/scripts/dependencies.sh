#!/bin/bash

set -e

# Build atalanta
install_atalanta () {
	cd /tmp
	git clone https://github.com/hsluoyz/Atalanta.git atalanta
	cd atalanta
	git checkout 12d405311c3dc9f371a9009bb5cdc8844fe34f90
	make -j$(nproc)
	cp atalanta /usr/local/bin
	cd ..
	cp -R atalanta /usr/local/share
}
install_atalanta

# Install Swift
install_swift () {
	cd /tmp

	if [ "$(arch)" == "x86_64" ]; then
        	echo "Platform is x86_64"
		wget --no-verbose https://download.swift.org/swift-5.6-release/centos8/swift-5.6-RELEASE/swift-5.6-RELEASE-centos8.tar.gz       
        	tar xf swift-5.6-RELEASE-centos8.tar.gz
        	cp -rn swift-5.6-RELEASE-centos8/* /
	elif [ "$(arch)" == "aarch64" ]; then
        	echo "Platform is aarch64"
		wget --no-verbose https://download.swift.org/swift-5.6-release/centos8-aarch64/swift-5.6-RELEASE/swift-5.6-RELEASE-centos8-aarch64.tar.gz       
        	tar xf swift-5.6-RELEASE-centos8-aarch64.tar.gz
        	cp -rn swift-5.6-RELEASE-centos8-aarch64/* /
	else
        	echo "Unknown platform"
		exit 1
	fi
}
install_swift
