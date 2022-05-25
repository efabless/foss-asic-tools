v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 1280 -640 1280 -580 { lab=#net1}
N 840 -640 840 -580 { lab=#net1}
N 840 -520 840 -480 { lab=#net2}
N 840 -740 840 -700 { lab=#net3}
N 840 -420 840 -360 { lab=VGND}
N 840 -360 1240 -360 { lab=VGND}
N 1240 -360 1250 -360 { lab=VGND}
N 1250 -540 1250 -360 { lab=VGND}
N 840 -860 840 -800 { lab=VPWR}
N 840 -860 1250 -860 { lab=VPWR}
N 1250 -860 1250 -680 { lab=VPWR}
N 1310 -540 1400 -540 { lab=X}
N 1400 -680 1400 -540 { lab=X}
N 1310 -680 1400 -680 { lab=X}
N 1400 -610 1480 -610 { lab=X}
N 730 -770 800 -770 { lab=A}
N 730 -770 730 -450 { lab=A}
N 730 -450 800 -450 { lab=A}
N 730 -550 800 -550 { lab=A}
N 730 -670 800 -670 { lab=A}
N 650 -610 730 -610 { lab=A}
N 840 -500 1030 -500 { lab=#net2}
N 840 -720 1030 -720 { lab=#net3}
N 1060 -680 1060 -610 { lab=#net1}
N 1060 -610 1060 -540 { lab=#net1}
N 1150 -500 1220 -500 { lab=VPWR}
N 1220 -860 1220 -500 { lab=VPWR}
N 1150 -720 1190 -720 { lab=VGND}
N 1190 -720 1190 -360 { lab=VGND}
N 840 -610 1060 -610 { lab=#net1}
N 1060 -610 1280 -610 { lab=#net1}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 820 -550 0 0 {name=M1
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 820 -450 0 0 {name=M8
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 820 -670 0 0 {name=M0
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
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 820 -770 0 0 {name=M4
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
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1280 -660 1 1 {name=M7
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
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1280 -560 3 1 {name=M6
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
C {devices/lab_pin.sym} 650 -610 0 0 {name=l1 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 1480 -610 0 1 {name=l2 sig_type=std_logic lab=X}
C {devices/lab_pin.sym} 1250 -860 0 1 {name=l3 sig_type=std_logic lab=VPWR}
C {devices/lab_pin.sym} 1250 -360 0 1 {name=l4 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 840 -770 0 1 {name=l5 sig_type=std_logic lab=VPB}
C {devices/lab_pin.sym} 840 -670 0 1 {name=l6 sig_type=std_logic lab=VPB}
C {devices/lab_pin.sym} 1280 -680 3 1 {name=l8 sig_type=std_logic lab=VPB}
C {devices/lab_pin.sym} 1280 -540 1 1 {name=l11 sig_type=std_logic lab=VNB}
C {devices/lab_pin.sym} 840 -450 0 1 {name=l12 sig_type=std_logic lab=VNB}
C {devices/lab_pin.sym} 840 -550 0 1 {name=l13 sig_type=std_logic lab=VNB}
C {devices/iopin.sym} 530 -860 0 0 {name=p1 lab=VPWR}
C {devices/iopin.sym} 530 -830 0 0 {name=p2 lab=VGND}
C {devices/iopin.sym} 530 -800 0 0 {name=p3 lab=VPB}
C {devices/iopin.sym} 530 -770 0 0 {name=p4 lab=VNB}
C {devices/iopin.sym} 530 -740 0 0 {name=p5 lab=A}
C {devices/iopin.sym} 530 -710 0 0 {name=p6 lab=X}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1060 -700 3 0 {name=M9
L=0.5
W=5
nf=1
mult=8
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1060 -520 1 0 {name=M5
L=0.5
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
C {sky130_fd_pr/res_generic_nd.sym} 1120 -720 3 0 {name=R1
rho=120
W=2
L=6
model=res_generic_nd
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_pd.sym} 1120 -500 1 0 {name=R2
W=2
L=12
model=res_generic_pd
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1060 -720 3 1 {name=l7 sig_type=std_logic lab=VPB}
C {devices/lab_pin.sym} 1120 -520 3 1 {name=l9 sig_type=std_logic lab=VPB}
C {devices/lab_pin.sym} 1060 -500 1 1 {name=l10 sig_type=std_logic lab=VNB}
C {devices/lab_pin.sym} 1120 -700 1 1 {name=l14 sig_type=std_logic lab=VNB}
