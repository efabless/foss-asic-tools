v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 820 -120 820 -100 { lab=GND}
N 820 -200 820 -180 { lab=vclamp}
N 820 -200 940 -200 { lab=vclamp}
N 1080 -200 1120 -200 { lab=#net1}
N 1140 -100 1260 -100 { lab=GND}
N 1120 -100 1140 -100 { lab=GND}
N 1120 -120 1120 -100 { lab=GND}
N 1080 -110 1120 -110 { lab=GND}
N 1120 -110 1130 -110 { lab=GND}
N 1130 -150 1130 -110 { lab=GND}
N 1120 -150 1130 -150 { lab=GND}
N 1120 -200 1140 -200 { lab=#net1}
N 1080 -200 1080 -150 { lab=#net1}
N 1120 -200 1120 -180 { lab=#net1}
N 1120 -220 1120 -200 { lab=#net1}
N 940 -260 940 -200 { lab=vclamp}
N 940 -260 1080 -250 { lab=vclamp}
N 1080 -300 1080 -250 { lab=vclamp}
N 1080 -300 1120 -300 { lab=vclamp}
N 1120 -300 1120 -280 { lab=vclamp}
N 1120 -250 1160 -250 { lab=GND}
N 1160 -250 1160 -100 { lab=GND}
C {devices/code_shown.sym} 198.75 -701.875 0 0 {name=NGSPICE
only_toplevel=true
value="
.option temp=80
.param Wwidth = 40
.control
.save all
.options savecurrents
DC I0 0 300u 1u
plot vclamp vs @I0[current]
.endc
"}
C {devices/isource.sym} 820 -150 2 0 {name=I0 value=1m}
C {devices/gnd.sym} 820 -100 0 0 {name=l5 lab=GND}
C {devices/lab_wire.sym} 880 -200 0 1 {name=l2 sig_type=std_logic lab=vclamp}
C {devices/gnd.sym} 1120 -100 0 0 {name=l1 lab=GND}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1100 -150 0 0 {name=M2
L=0.5
W=\{Wwidth\}
nf=1
mult=10
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 1100 -250 0 0 {name=M1
L=0.5
W=5
nf=1
mult=10
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {devices/code.sym} 20 -270 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib \\\\$::SKYWATER_MODELS\\\\/models/sky130.lib.spice ss
.option wnflag=1
"
}
