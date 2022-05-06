v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 1310 -1240 1310 -1180 { lab=vpwr}
N 1310 -1240 1580 -1240 { lab=vpwr}
N 1580 -1240 1580 -1180 { lab=vpwr}
N 1580 -1120 1580 -1080 { lab=#net1}
N 1580 -1020 1580 -960 { lab=vramp}
N 1580 -900 1580 -840 { lab=#net2}
N 1580 -990 1830 -990 { lab=vramp}
N 1830 -990 1830 -930 { lab=vramp}
N 1830 -870 1830 -740 { lab=vgnd}
N 1090 -740 1830 -740 { lab=vgnd}
N 1090 -780 1090 -740 { lab=vgnd}
N 1310 -780 1310 -740 { lab=vgnd}
N 1580 -780 1580 -740 { lab=vgnd}
N 1490 -1050 1540 -1050 { lab=rampgen_en}
N 1490 -1050 1490 -930 { lab=rampgen_en}
N 1490 -930 1540 -930 { lab=rampgen_en}
N 1350 -1150 1540 -1150 { lab=#net3}
N 1090 -870 1090 -840 { lab=iramp}
N 1130 -810 1270 -810 { lab=iramp}
N 1090 -890 1090 -870 { lab=iramp}
N 1090 -890 1180 -890 { lab=iramp}
N 1180 -890 1180 -810 { lab=iramp}
N 1090 -950 1090 -890 { lab=iramp}
N 1310 -1120 1310 -840 { lab=#net3}
N 1270 -880 1270 -810 { lab=iramp}
N 1270 -880 1520 -880 { lab=iramp}
N 1520 -880 1520 -810 { lab=iramp}
N 1520 -810 1540 -810 { lab=iramp}
N 1310 -1090 1400 -1090 { lab=#net3}
N 1400 -1150 1400 -1090 { lab=#net3}
N 1430 -990 1490 -990 { lab=rampgen_en}
N 1810 -1240 1810 -1170 { lab=vpwr}
N 1580 -1240 1810 -1240 { lab=vpwr}
N 1810 -1110 1850 -1110 { lab=vpwr}
N 1850 -1140 1850 -1110 { lab=vpwr}
N 1850 -1240 1850 -1140 { lab=vpwr}
N 1810 -1240 1850 -1240 { lab=vpwr}
N 1780 -1020 1820 -1020 { lab=#net1}
N 1820 -1050 1820 -1020 { lab=#net1}
N 1820 -1080 1820 -1050 { lab=#net1}
N 1780 -1080 1820 -1080 { lab=#net1}
N 1580 -1080 1780 -1080 { lab=#net1}
N 1740 -780 1740 -740 { lab=vgnd}
N 1700 -810 1700 -740 { lab=vgnd}
N 1700 -840 1740 -840 { lab=vgnd}
N 1700 -840 1700 -810 { lab=vgnd}
N 910 -920 950 -920 { lab=iramp}
N 950 -920 950 -890 { lab=iramp}
N 950 -890 950 -860 { lab=iramp}
N 910 -860 950 -860 { lab=iramp}
N 950 -890 1090 -890 { lab=iramp}
N 1310 -1280 1430 -1280 { lab=vpwr}
N 1490 -1280 1510 -1280 { lab=#net1}
N 1510 -1280 1510 -1100 { lab=#net1}
N 1510 -1100 1580 -1100 { lab=#net1}
N 1430 -1320 1460 -1320 { lab=vpwr}
N 1430 -1320 1430 -1280 { lab=vpwr}
N 1310 -1280 1310 -1240 { lab=vpwr}
N 1480 -1470 1510 -1470 { lab=#net1}
N 1510 -1470 1510 -1430 { lab=#net1}
N 1510 -1430 1510 -1280 { lab=#net1}
N 1210 -1430 1450 -1430 { lab=#net3}
N 1210 -1430 1210 -1090 { lab=#net3}
N 1210 -1090 1310 -1090 { lab=#net3}
N 1990 -990 1990 -930 { lab=vramp}
N 1830 -990 1990 -990 { lab=vramp}
N 1830 -740 1990 -740 { lab=vgnd}
N 1990 -870 1990 -740 { lab=vgnd}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1110 -810 0 1 {name=M1
L=1
W=5
nf=1
mult=12
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1290 -810 0 0 {name=M2
L=1
W=5
nf=1
mult=4
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1560 -810 0 0 {name=M3
L=1
W=5
nf=1
mult=14
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1560 -930 0 0 {name=M4
L=1
W=5
nf=1
mult=14
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1330 -1150 0 1 {name=M5
L=1
W=5
nf=1
mult=5
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1560 -1050 0 0 {name=M6
L=1
W=5
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1560 -1150 0 0 {name=M7
L=1
W=5
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/cap_mim_m3_1.sym} 1830 -900 0 0 {name=C1 model=cap_mim_m3_1 W=32 L=32 MF=4 spiceprefix=X}
C {devices/lab_pin.sym} 1830 -990 2 0 {name=l1 sig_type=std_logic lab=vramp}
C {devices/lab_pin.sym} 1430 -990 0 0 {name=l2 sig_type=std_logic lab=rampgen_en}
C {devices/lab_pin.sym} 1780 -1240 1 0 {name=l3 sig_type=std_logic lab=vpwr}
C {devices/lab_pin.sym} 1830 -740 2 0 {name=l4 sig_type=std_logic lab=vgnd}
C {devices/lab_pin.sym} 1090 -950 2 0 {name=l5 sig_type=std_logic lab=iramp}
C {devices/iopin.sym} 850 -1310 0 0 {name=p1 lab=vpwr}
C {devices/iopin.sym} 850 -1280 0 0 {name=p2 lab=vgnd}
C {devices/iopin.sym} 850 -1190 0 0 {name=p5 lab=iramp}
C {devices/iopin.sym} 850 -1160 0 0 {name=p6 lab=vramp}
C {devices/iopin.sym} 850 -1130 0 0 {name=p7 lab=rampgen_en}
C {devices/lab_pin.sym} 1580 -1150 2 0 {name=l6 sig_type=std_logic lab=vpwr}
C {devices/lab_pin.sym} 1580 -1050 2 0 {name=l7 sig_type=std_logic lab=vpwr}
C {devices/lab_pin.sym} 1310 -1150 2 1 {name=l9 sig_type=std_logic lab=vpwr}
C {devices/lab_pin.sym} 1580 -930 2 0 {name=l8 sig_type=std_logic lab=vgnd}
C {devices/lab_pin.sym} 1580 -810 2 0 {name=l10 sig_type=std_logic lab=vgnd}
C {devices/lab_pin.sym} 1310 -810 2 0 {name=l11 sig_type=std_logic lab=vgnd}
C {devices/lab_pin.sym} 1090 -810 2 1 {name=l12 sig_type=std_logic lab=vgnd}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1830 -1140 0 1 {name=dummy_top_pmos_out
L=1
W=5
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_pin.sym} 1810 -1140 2 1 {name=l13 sig_type=std_logic lab=vpwr}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1800 -1050 0 1 {name=dummy_mid_pmos
L=1
W=5
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_pin.sym} 1780 -1050 2 1 {name=l14 sig_type=std_logic lab=vpwr}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1720 -810 0 0 {name=dummy_mid_nmos
L=1
W=5
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 930 -890 0 1 {name=dummy_bot_nmos
L=1
W=5
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1460 -1300 3 1 {name=dummy_top_pmos_in_left
L=1
W=5
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1480 -1450 1 0 {name=dummy_top_pmos_in_right
L=1
W=5
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/cap_mim_m3_2.sym} 1990 -900 0 0 {name=C2 model=cap_mim_m3_2 W=32 L=32 MF=4 spiceprefix=X}
C {devices/lab_pin.sym} 1740 -810 2 0 {name=l15 sig_type=std_logic lab=vgnd}
C {devices/lab_pin.sym} 910 -890 2 1 {name=l16 sig_type=std_logic lab=vgnd}
C {devices/lab_pin.sym} 1480 -1430 1 1 {name=l17 sig_type=std_logic lab=vpwr}
C {devices/lab_pin.sym} 1460 -1280 1 1 {name=l18 sig_type=std_logic lab=vpwr}
