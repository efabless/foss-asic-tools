v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 580 -290 580 -250 {
lab=VDD}
N 580 -190 580 -160 {
lab=Y}
N 580 -100 580 -60 {
lab=VSS}
N 510 -220 540 -220 {
lab=A}
N 510 -220 510 -130 {
lab=A}
N 510 -130 540 -130 {
lab=A}
N 580 -170 670 -170 {
lab=Y}
N 490 -170 510 -170 {
lab=A}
N 460 -170 490 -170 {
lab=A}
N 580 -220 650 -220 {
lab=VDD}
N 650 -280 650 -220 {
lab=VDD}
N 580 -280 650 -280 {
lab=VDD}
N 580 -130 670 -130 {
lab=VSS}
N 670 -130 670 -80 {
lab=VSS}
N 580 -80 670 -80 {
lab=VSS}
C {devices/ipin.sym} 460 -170 0 0 {name=p1 lab=A}
C {devices/opin.sym} 670 -170 0 0 {name=p1 lab=Y}
C {devices/iopin.sym} 580 -290 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 580 -60 1 0 {name=p1 lab=VSS}
C {devices/param.sym} 570 -440 0 0 {name=s1 value="Wn=1.05"}
C {devices/param.sym} 570 -410 0 0 {name=s2 value="L=0.15"}
C {devices/param.sym} 770 -440 0 0 {name=s3 value="Wp=0.84"}
C {sky130_fd_pr/pfet_01v8.sym} 560 -220 0 0 {name=M2
L=L
W="'Wp * 20'"
nf=20
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 560 -130 0 0 {name=M1
L=L
W="'Wn * 20'"
nf=20
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/code.sym} 400 -520 0 0 {name=Constraint
spice_ignore=true 
value=
" 
.constraint
   \{
        "constraint": "ConfigureCompiler",
        "is_digital": false,
        "remove_dummy_hierarchies": true,
        "propagate": true,
        "merge_parallel_devices": false,
        "merge_series_devices": false,
	"fix_source_drain": false
    \},
    \{"constraint": "PowerPorts", "ports": ["VDD"]\},
    \{"constraint": "GroundPorts", "ports": ["VSS"]\},
    \{"constraint": "Align", "instances": ["xm1", "xm2"], "line": "h_center"\}  
.endconstraint
"
}
C {devices/title.sym} 160 -610 0 0 {name=l1 author="Jakob Ratschenberger"}
