v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -60 -80 -60 0 {
lab=vdd}
N -60 -80 130 -80 {
lab=vdd}
N 130 -80 130 -50 {
lab=vdd}
N 130 50 130 90 {
lab=GND}
N -60 90 130 90 {
lab=GND}
N -60 60 -60 90 {
lab=GND}
N 10 0 80 0 {
lab=in}
N 10 60 10 90 {
lab=GND}
N 10 90 10 110 {
lab=GND}
N 200 0 230 0 {
lab=out}
C {devices/vsource.sym} -60 30 0 0 {name=V1 value=1.8}
C {devices/vsource.sym} 10 30 0 0 {name=V2 value="pulse(0 1.8 0 0.1n 0.1n 50n 100n)"}
C {devices/gnd.sym} 10 110 0 0 {name=l1 lab=GND}
C {inverter.sym} 80 0 0 0 {name=x1}
C {devices/code_shown.sym} 290 -110 0 0 {name=ngspice 
only_toplevel=false 
format="tcleval( @value )"
value=
".lib $::SKYWATER_MODELS/sky130.lib.spice tt
.control
save all
tran 0.1n 0.15u
plot v(vin) v(out)
*dc v2 0 1.8 1m
*plot v(out)
.endc"}
C {devices/lab_pin.sym} 40 0 1 0 {name=l2 sig_type=std_logic lab=in}
C {devices/lab_pin.sym} 40 -80 1 0 {name=l1 sig_type=std_logic lab=vdd}
C {devices/lab_wire.sym} 230 0 0 1 {name=p1 sig_type=std_logic lab=out}
