#!/bin/bash

set -e

echo "[INFO] Install EDA packages via PIP"
pip3 install --upgrade --no-cache-dir \
	amaranth \
	cocotb \
	edalize \
	fusesoc \
	hdl21 \
	gdsfactory \
	gdspy \
	openlane \
	openram \
	pyrtl \
	pyspice \
	pyverilog \
	schemdraw \
	scikit-rf \
	siliconcompiler \
	spyci \
	volare \
	vlsirtools

pip3 install --upgrade --no-cache-dir \
	jupyter \
	jupyterlab \
	jupyter-collaboration \
	jupyterlab-night


echo "[INFO] Install EDA packages via GEM"
gem install \
	rggen \
	rggen-verilog \
	rggen-vhdl

echo "[INFO] Install EDA packages via NPM"
npm install -g \
	netlistsvg
