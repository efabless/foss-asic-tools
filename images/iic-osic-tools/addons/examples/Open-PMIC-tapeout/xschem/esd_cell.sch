v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -40 -140 -40 -80 { lab=clamp}
N -40 -50 -20 -50 { lab=vss}
N -20 -50 -20 0 { lab=vss}
N -40 0 -20 0 { lab=vss}
N -40 -20 -40 0 { lab=vss}
N -40 -170 -20 -170 { lab=vdd}
N -20 -220 -20 -170 { lab=vdd}
N -40 -220 -20 -220 { lab=vdd}
N -40 -220 -40 -200 { lab=vdd}
N -100 -170 -80 -170 { lab=vdd}
N -100 -220 -100 -180 { lab=vdd}
N -100 -220 -40 -220 { lab=vdd}
N -100 -180 -100 -170 { lab=vdd}
N -100 -50 -80 -50 { lab=vss}
N -100 -50 -100 0 { lab=vss}
N -100 0 -40 0 { lab=vss}
C {devices/iopin.sym} -270 -280 0 0 {name=p1 lab=clamp}
C {devices/iopin.sym} -270 -240 0 0 {name=p2 lab=vdd}
C {devices/iopin.sym} -270 -200 0 0 {name=p3 lab=vss}
C {devices/lab_wire.sym} -40 -110 0 0 {name=l2 sig_type=std_logic lab=clamp}
C {devices/lab_wire.sym} -100 0 0 0 {name=l3 sig_type=std_logic lab=vss}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} -60 -50 0 0 {name=M1
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} -60 -170 0 0 {name=M2
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} -100 -220 0 0 {name=l1 sig_type=std_logic lab=vdd}
