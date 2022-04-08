# Harald Pretl, IIC, JKU
#
# Build script for IIC docker images
#
# Order for building: base first, then magic; skywater-pdk before open_pdks; last is foss-asic-tools

source venv/bin/activate
python3 run.py build \
	base magic \
	xschem gaw3-xschem \
	gtkwave \
	netgen \
	iic-osic \
	irsim \
	iverilog \
	ngscope \
	ngspice \
	skywater-pdk open_pdks \
	opensta \
	xyce \
	klayout \
	openroad yosys padring cvc-check \
	openlane \
	qflow \
	verilator \
	cugr \
	dr-cu \
	foss-asic-tools
