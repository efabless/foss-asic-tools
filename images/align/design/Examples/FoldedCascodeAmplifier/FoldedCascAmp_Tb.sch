v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 340 -210 410 -210 {
lab=#net1}
N 340 -170 340 -140 {
lab=GND}
N 300 -260 300 -220 {
lab=vp}
N 540 -260 540 -220 {
lab=vn}
N 300 -160 300 -80 {
lab=#net2}
N 300 -80 450 -80 {
lab=#net2}
N 540 -160 540 -80 {
lab=#net2}
N 660 -160 720 -160 {
lab=vp}
N 660 -80 720 -80 {
lab=vn}
N 910 -120 990 -120 {
lab=vout}
N 990 -120 1030 -120 {
lab=vout}
N 1030 -120 1030 -100 {
lab=vout}
N 1030 -40 1030 -0 {
lab=GND}
N 810 -50 810 0 {
lab=GND}
N 140 -140 140 -110 {
lab=VDD}
N 140 -50 140 -20 {
lab=GND}
N 450 -80 540 -80 {
lab=#net2}
N 410 -210 500 -210 {
lab=#net1}
N 500 -170 500 -140 {
lab=GND}
N 370 -140 370 -130 {
lab=GND}
N 370 -210 370 -200 {
lab=#net1}
N 420 -80 420 -70 {
lab=#net2}
N 420 -10 420 0 {
lab=GND}
N 810 -210 810 -190 {
lab=VDD}
N 340 -140 370 -140 {
lab=GND}
N 370 -140 500 -140 {
lab=GND}
C {devices/gnd.sym} 140 -20 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 140 -140 0 0 {name=l2 lab=VDD}
C {devices/code_shown.sym} -10 -540 0 0 {name=ngspice 
only_toplevel=false 
format="tcleval( @value )"
value=
".lib $::SKYWATER_MODELS/sky130.lib.spice tt
*.option SCALE=1
.control
save all
dc vdiff -0.2 0.2 0.1m
plot deriv(vout) xlimit -0.2 0.2 ylabel 'small signal gain'
*op
*ac dec 1001 1 100G
*plot vdb(vout) xlimit 1 100G ylabel 'small signal gain'
*plot cph(vout) xlimit 1 100G ylabel 'phase (in rad)'
*let outd = 180/PI*cph(vout)
*plot outd xlimit 1 100G ylabel 'phase'
.endc"}
C {devices/vcvs.sym} 540 -190 0 0 {name=E1 value=-0.5}
C {devices/vcvs.sym} 300 -190 0 1 {name=E2 value=0.5}
C {devices/vsource.sym} 370 -170 0 0 {name=Vdiff value="ac 1"}
C {devices/vsource.sym} 140 -80 0 0 {name=V1 value=1.8}
C {devices/gnd.sym} 370 -130 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 420 -40 0 0 {name=Vcmm value=0.9}
C {devices/gnd.sym} 420 0 0 0 {name=l4 lab=GND}
C {devices/lab_wire.sym} 300 -260 0 0 {name=l5 sig_type=std_logic lab=vp}
C {devices/lab_wire.sym} 540 -260 0 0 {name=l6 sig_type=std_logic lab=vn}
C {devices/vdd.sym} 810 -210 0 0 {name=l7 lab=VDD}
C {devices/gnd.sym} 810 0 0 0 {name=l8 lab=GND}
C {devices/lab_wire.sym} 660 -160 0 0 {name=l9 sig_type=std_logic lab=vp}
C {devices/lab_wire.sym} 660 -80 0 0 {name=l10 sig_type=std_logic lab=vn}
C {devices/lab_wire.sym} 990 -120 0 1 {name=l11 sig_type=std_logic lab=vout}
C {devices/capa.sym} 1030 -70 0 0 {name=C1
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1030 0 0 0 {name=l8 lab=GND}
C {FoldedCascAmp.sym} 740 -120 0 0 {name=x1}
