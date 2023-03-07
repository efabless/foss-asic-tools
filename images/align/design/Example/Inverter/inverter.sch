v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 180 -300 180 -260 {
lab=VDD}
N 180 -200 180 -170 {
lab=Y}
N 180 -110 180 -70 {
lab=VSS}
N 110 -230 140 -230 {
lab=A}
N 110 -230 110 -140 {
lab=A}
N 110 -140 140 -140 {
lab=A}
N 180 -180 270 -180 {
lab=Y}
N 90 -180 110 -180 {
lab=A}
N 60 -180 90 -180 {
lab=A}
N 180 -230 250 -230 {
lab=VDD}
N 250 -290 250 -230 {
lab=VDD}
N 180 -290 250 -290 {
lab=VDD}
N 180 -140 270 -140 {
lab=VSS}
N 270 -140 270 -90 {
lab=VSS}
N 180 -90 270 -90 {
lab=VSS}
C {devices/ipin.sym} 60 -180 0 0 {name=p1 lab=A}
C {devices/opin.sym} 270 -180 0 0 {name=p1 lab=Y}
C {devices/iopin.sym} 180 -300 3 0 {name=p1 lab=VDD}
C {devices/iopin.sym} 180 -70 1 0 {name=p1 lab=VSS}
C {devices/param.sym} 170 -450 0 0 {name=s1 value="Wn=1.05"}
C {devices/param.sym} 170 -420 0 0 {name=s2 value="L=0.15"}
C {devices/param.sym} 370 -450 0 0 {name=s3 value="Wp=0.84"}
C {sky130_fd_pr/pfet_01v8.sym} 160 -230 0 0 {name=M2
L=L
W="'Wp * 2'"
nf=2
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
C {sky130_fd_pr/nfet_01v8.sym} 160 -140 0 0 {name=M1
L=L
W="'Wn * 2'"
nf=2 
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
C {devices/code.sym} 0 -530 0 0 {name=Constrain
spice_ignore=true 
value=
" 
.constrain
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
    \{"constraint": "GroundPorts", "ports": ["VSS"]\}
.endconstrain
"
}
