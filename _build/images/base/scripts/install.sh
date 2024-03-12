#!/bin/bash

set -e

echo "[INFO] Install EDA packages via PIP"
pip3 install --upgrade --no-cache-dir \
	amaranth \
	cace \
	cocotb \
	edalize \
	fusesoc \
	gdsfactory \
	gdspy \
	hdl21 \
	openlane \
	openram \
	pyrtl \
	pyspice \
	pyverilog \
	schemdraw \
	scikit-rf \
	siliconcompiler \
	spyci \
	vlsirtools
	volare \

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
