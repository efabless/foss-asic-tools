v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 540 -350 560 -350 { lab=VSS}
N 560 -350 560 -300 { lab=VSS}
N 540 -300 560 -300 { lab=VSS}
N 540 -320 540 -300 { lab=VSS}
N 480 -350 500 -350 { lab=IOSC}
N 480 -400 480 -350 { lab=IOSC}
N 480 -400 540 -400 { lab=IOSC}
N 540 -400 540 -380 { lab=IOSC}
N 540 -440 540 -400 { lab=IOSC}
N 780 -470 800 -470 { lab=VDD}
N 800 -520 800 -470 { lab=VDD}
N 780 -520 800 -520 { lab=VDD}
N 780 -520 780 -500 { lab=VDD}
N 780 -540 780 -520 { lab=VDD}
N 720 -470 740 -470 { lab=VDD}
N 720 -520 720 -470 { lab=VDD}
N 720 -520 780 -520 { lab=VDD}
N 560 -300 780 -300 { lab=VSS}
N 780 -320 780 -300 { lab=VSS}
N 780 -350 800 -350 { lab=VSS}
N 800 -350 800 -300 { lab=VSS}
N 780 -300 800 -300 { lab=VSS}
N 720 -350 740 -350 { lab=VDD}
N 720 -400 720 -350 { lab=VDD}
N 720 -470 720 -400 { lab=VDD}
N 780 -440 780 -380 { lab=TIMEOUT}
N 500 -300 540 -300 { lab=VSS}
N 780 -410 820 -410 { lab=TIMEOUT}
C {devices/iopin.sym} 150 -670 0 0 {name=p1 lab=VDD
}
C {devices/iopin.sym} 150 -640 0 0 {name=p2 lab=VSS
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 760 -470 0 0 {name=M5
L=1
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 520 -350 0 0 {name=M4
L=1
W=5
nf=1
mult=8
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 760 -350 0 0 {name=M1
L=1
W=5
nf=1
mult=8
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} 540 -440 0 0 {name=l1 sig_type=std_logic lab=IOSC}
C {devices/lab_wire.sym} 500 -300 0 0 {name=l2 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 780 -540 0 0 {name=l3 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 820 -410 0 1 {name=l4 sig_type=std_logic lab=TIMEOUT}
C {devices/iopin.sym} 150 -600 0 0 {name=p3 lab=IOSC
}
C {devices/iopin.sym} 150 -560 0 0 {name=p4 lab=TIMEOUT
}
