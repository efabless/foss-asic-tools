v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 410 -500 410 -320 { lab=#net1}
N 410 -260 410 -140 { lab=vss}
N 410 -140 580 -140 { lab=vss}
N 580 -180 580 -140 { lab=vss}
N 580 -360 580 -240 { lab=#net2}
N 750 -180 750 -140 { lab=vss}
N 580 -140 750 -140 { lab=vss}
N 750 -140 950 -140 { lab=vss}
N 950 -180 950 -140 { lab=vss}
N 950 -140 1120 -140 { lab=vss}
N 1120 -180 1120 -140 { lab=vss}
N 1120 -360 1120 -240 { lab=#net3}
N 1120 -140 1320 -140 { lab=vss}
N 450 -530 1280 -530 { lab=#net1}
N 410 -740 410 -560 { lab=vdd}
N 1320 -740 1320 -560 { lab=vdd}
N 410 -740 1320 -740 { lab=vdd}
N 870 -740 870 -710 { lab=vdd}
N 580 -470 580 -420 { lab=#net4}
N 580 -470 1120 -470 { lab=#net4}
N 1120 -470 1120 -420 { lab=#net4}
N 870 -650 870 -470 { lab=#net4}
N 410 -460 520 -460 { lab=#net1}
N 520 -530 520 -460 { lab=#net1}
N 450 -290 750 -290 { lab=#net2}
N 750 -290 950 -240 { lab=#net2}
N 1320 -260 1320 -140 { lab=vss}
N 1320 -500 1320 -320 { lab=vmid}
N 950 -290 1280 -290 { lab=#net3}
N 750 -240 950 -290 { lab=#net3}
N 620 -210 710 -210 { lab=#net2}
N 990 -210 1080 -210 { lab=#net3}
N 660 -290 660 -210 { lab=#net2}
N 1040 -290 1040 -210 { lab=#net3}
N 500 -390 540 -390 { lab=vinp}
N 1160 -390 1220 -390 { lab=vinm}
N 580 -290 660 -290 { lab=#net2}
N 1040 -290 1120 -290 { lab=#net3}
N 1320 -740 1520 -740 { lab=vdd}
N 1520 -740 1520 -710 { lab=vdd}
N 1520 -650 1520 -560 { lab=ibias}
N 910 -680 1480 -680 { lab=ibias}
N 1430 -620 1520 -620 { lab=ibias}
N 1430 -680 1430 -620 { lab=ibias}
N 1520 -740 1740 -740 { lab=vdd}
N 1740 -740 1740 -710 { lab=vdd}
N 1740 -650 1740 -320 { lab=vout}
N 1680 -680 1700 -680 { lab=vmid}
N 1680 -680 1680 -290 { lab=vmid}
N 1680 -290 1700 -290 { lab=vmid}
N 1740 -440 1780 -440 { lab=vout}
N 1740 -260 1740 -140 { lab=vss}
N 1320 -140 1740 -140 { lab=vss}
N 1740 -290 1760 -290 { lab=vss}
N 1760 -290 1760 -240 { lab=vss}
N 1740 -240 1760 -240 { lab=vss}
N 1740 -680 1760 -680 { lab=vdd}
N 1760 -740 1760 -680 { lab=vdd}
N 1740 -740 1760 -740 { lab=vdd}
N 1320 -440 1680 -440 { lab=vmid}
C {devices/lab_pin.sym} 1220 -390 2 0 {name=l1 sig_type=std_logic lab=vinm

}
C {devices/iopin.sym} -90 -750 0 0 {name=p6 lab=IB
}
C {devices/iopin.sym} -90 -720 0 0 {name=p1 lab=VDD
}
C {devices/iopin.sym} -90 -690 0 0 {name=p5 lab=Vinm
}
C {devices/iopin.sym} -90 -670 0 0 {name=p4 lab=Vinp
}
C {devices/iopin.sym} -90 -640 0 0 {name=p3 lab=Vout
}
C {devices/iopin.sym} -90 -610 0 0 {name=p2 lab=VSS
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 560 -390 0 0 {name=M1
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
C {devices/lab_pin.sym} 1320 -740 3 1 {name=l4 sig_type=std_logic lab=vdd




}
C {devices/lab_pin.sym} 1320 -140 0 1 {name=l5 sig_type=std_logic lab=vss





}
C {devices/lab_pin.sym} 1320 -530 0 1 {name=l6 sig_type=std_logic lab=vdd




}
C {devices/lab_pin.sym} 870 -680 0 0 {name=l7 sig_type=std_logic lab=vdd




}
C {devices/lab_pin.sym} 410 -530 0 0 {name=l8 sig_type=std_logic lab=vdd




}
C {devices/lab_pin.sym} 1120 -390 0 0 {name=l9 sig_type=std_logic lab=vdd




}
C {devices/lab_pin.sym} 580 -390 0 1 {name=l10 sig_type=std_logic lab=vdd




}
C {devices/lab_pin.sym} 1320 -290 0 1 {name=l11 sig_type=std_logic lab=vss





}
C {devices/lab_pin.sym} 1120 -210 0 1 {name=l12 sig_type=std_logic lab=vss





}
C {devices/lab_pin.sym} 950 -210 0 0 {name=l13 sig_type=std_logic lab=vss





}
C {devices/lab_pin.sym} 750 -210 0 1 {name=l14 sig_type=std_logic lab=vss





}
C {devices/lab_pin.sym} 580 -210 0 0 {name=l15 sig_type=std_logic lab=vss





}
C {devices/lab_pin.sym} 410 -290 0 0 {name=l16 sig_type=std_logic lab=vss





}
C {devices/lab_pin.sym} 1780 -440 0 1 {name=l3 sig_type=std_logic lab=vout



}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1140 -390 0 1 {name=M2
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 430 -530 0 1 {name=M7
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1300 -530 0 0 {name=M8
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 890 -680 0 1 {name=M11
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
C {devices/lab_pin.sym} 500 -390 2 1 {name=l2 sig_type=std_logic lab=vinp


}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1500 -680 0 0 {name=Mmir
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
C {devices/lab_pin.sym} 1520 -570 0 1 {name=l17 sig_type=std_logic lab=ibias





}
C {devices/lab_pin.sym} 1520 -680 0 1 {name=l18 sig_type=std_logic lab=vdd




}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1300 -290 0 0 {name=M12
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1100 -210 0 0 {name=M4
L=1
W=5
nf=1
mult=3
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 970 -210 0 1 {name=M6
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 730 -210 0 0 {name=M5
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 600 -210 0 1 {name=M3
L=1
W=5
nf=1
mult=3
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 430 -290 0 1 {name=M9
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 1720 -680 0 0 {name=M10
L=0.5
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1720 -290 0 0 {name=M13
L=0.5
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
C {devices/lab_wire.sym} 1420 -440 0 1 {name=l19 sig_type=std_logic lab=vmid}
