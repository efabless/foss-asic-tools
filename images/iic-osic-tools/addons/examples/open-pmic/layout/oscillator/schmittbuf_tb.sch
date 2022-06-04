v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 190 50 230 50 { lab=VOUT}
N -120 50 -120 90 { lab=VIN}
N -120 90 -120 190 { lab=VIN}
N 0 130 0 160 { lab=GND}
N 0 160 100 160 { lab=GND}
N 100 130 100 160 { lab=GND}
N 0 -70 0 -40 { lab=VDD}
N 0 -70 100 -70 { lab=VDD}
N 100 -70 100 -40 { lab=VDD}
N -280 10 -280 50 { lab=VDD}
N -120 50 -80 50 { lab=VIN}
C {devices/gnd.sym} -120 240 0 0 {name=l1 lab=GND}
C {devices/lab_wire.sym} -120 50 0 0 {name=l2 sig_type=std_logic lab=VIN}
C {devices/lab_wire.sym} 230 50 0 0 {name=l3 sig_type=std_logic lab=VOUT}
C {devices/code.sym} -530 -60 0 0 {name=STDCELL_MODELS 
only_toplevel=true
place=end
format="tcleval(@value )"
value="[sky130_models]"
name=s1 only_toplevel=false value=blabla}
C {devices/code.sym} -530 110 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_01v8_lvt/sky130_fd_pr__nfet_01v8_lvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8/sky130_fd_pr__pfet_01v8__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_03v3_nvt/sky130_fd_pr__nfet_03v3_nvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_05v0_nvt/sky130_fd_pr__nfet_05v0_nvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/esd_nfet_01v8/sky130_fd_pr__esd_nfet_01v8__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8_lvt/sky130_fd_pr__pfet_01v8_lvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/esd_pfet_g5v0d10v5/sky130_fd_pr__esd_pfet_g5v0d10v5__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_g5v0d10v5/sky130_fd_pr__pfet_g5v0d10v5__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_g5v0d16v0/sky130_fd_pr__pfet_g5v0d16v0__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_g5v0d10v5/sky130_fd_pr__nfet_g5v0d10v5__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_g5v0d16v0/sky130_fd_pr__nfet_g5v0d16v0__tt_discrete.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/esd_nfet_g5v0d10v5/sky130_fd_pr__esd_nfet_g5v0d10v5__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/models/corners/tt/nonfet.spice
* Mismatch parameters
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8/sky130_fd_pr__pfet_01v8__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_01v8_lvt/sky130_fd_pr__nfet_01v8_lvt__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8_lvt/sky130_fd_pr__pfet_01v8_lvt__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_g5v0d10v5/sky130_fd_pr__nfet_g5v0d10v5__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_g5v0d10v5/sky130_fd_pr__pfet_g5v0d10v5__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_05v0_nvt/sky130_fd_pr__nfet_05v0_nvt__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_03v3_nvt/sky130_fd_pr__nfet_03v3_nvt__mismatch.corner.spice
* Resistor\\\\$::SKYWATER_MODELS\\\\/Capacitor
.include \\\\$::SKYWATER_MODELS\\\\/models/r+c/res_typical__cap_typical.spice
.include \\\\$::SKYWATER_MODELS\\\\/models/r+c/res_typical__cap_typical__lin.spice
* Special cells
.include \\\\$::SKYWATER_MODELS\\\\/models/corners/tt/specialized_cells.spice
* All models
.include \\\\$::SKYWATER_MODELS\\\\/models/all.spice
* Corner
.include \\\\$::SKYWATER_MODELS\\\\/models/corners/tt/rf.spice
"
}
C {devices/lab_wire.sym} 80 -70 0 0 {name=l4 sig_type=std_logic lab=VDD}
C {devices/gnd.sym} 50 160 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} -280 80 0 0 {name=V1 value=3.3}
C {devices/gnd.sym} -280 110 0 0 {name=l6 lab=GND}
C {devices/lab_wire.sym} -280 20 0 0 {name=l7 sig_type=std_logic lab=VDD}
C {devices/code_shown.sym} -531.25 278.125 0 0 {name=NGSPICE
only_toplevel=true
value="
.option RSHUNT = 1e20
.include /home/atumkur/EE272B/open-pmic/layout/oscillator/schmittbuf_pex.spice
.control
save all
tran 1n 0.5u
write schmittbuf_tb.raw
.endc
"}
C {devices/vsource.sym} -120 210 0 0 {name=V2 value="pwl 0 0 0.2u 3 0.3u 3 0.5u 0"}
C {layout/oscillator/sky130_fd_sc_hvl__schmittbuf_1.sym} -390 310 0 0 {name=x1}
