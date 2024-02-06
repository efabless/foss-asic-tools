#!/bin/bash

set -e

UBUNTU_VERSION=$(lsb_release -r -s)

# Build Atalanta
_install_atalanta () {
	echo "[INFO] Installing atalanta."
	cd /tmp
	git clone --filter=blob:none https://github.com/hsluoyz/Atalanta.git atalanta
	cd atalanta
	git checkout 12d405311c3dc9f371a9009bb5cdc8844fe34f90
	make -j"$(nproc)"
	make clear
	cd ..
	mv atalanta /opt/atalanta
}
_install_atalanta

# Install Swift
_install_swift () {
	echo "[INFO] Installing Swift."
	cd /tmp
	SWIFT_VERSION=5.8
	if [[ $UBUNTU_VERSION == 22.04 ]]; then
		if [ "$(arch)" == "x86_64" ]; then
			echo "[INFO] Platform is x86_64, 22.04"
			wget --no-verbose https://download.swift.org/swift-${SWIFT_VERSION}-release/ubuntu2204/swift-${SWIFT_VERSION}-RELEASE/swift-${SWIFT_VERSION}-RELEASE-ubuntu22.04.tar.gz
			tar xzf swift-${SWIFT_VERSION}-RELEASE-ubuntu22.04.tar.gz
			mv swift-${SWIFT_VERSION}-RELEASE-ubuntu22.04 /opt/swift
		elif [ "$(arch)" == "aarch64" ]; then
			echo "[INFO] Platform is aarch64, 22.04"
			wget --no-verbose https://download.swift.org/swift-${SWIFT_VERSION}-release/ubuntu2204-aarch64/swift-${SWIFT_VERSION}-RELEASE/swift-${SWIFT_VERSION}-RELEASE-ubuntu22.04-aarch64.tar.gz
			tar xzf swift-${SWIFT_VERSION}-RELEASE-ubuntu22.04-aarch64.tar.gz
			mv swift-${SWIFT_VERSION}-RELEASE-ubuntu22.04-aarch64 /opt/swift
		else
			echo "[ERROR] Unknown platform"
			exit 1
		fi
	else
		echo "[ERROR] Unknown Ubuntu version"
		exit 1
	fi
}
_install_swift
