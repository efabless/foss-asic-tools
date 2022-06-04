v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 820 -120 820 -100 { lab=GND}
N 820 -200 820 -180 { lab=vclamp}
N 820 -200 940 -200 { lab=vclamp}
N 1120 -220 1120 -180 { lab=vclamp}
N 1080 -200 1120 -200 { lab=vclamp}
N 940 -200 1080 -200 { lab=vclamp}
N 1260 -160 1260 -100 { lab=GND}
N 1140 -100 1260 -100 { lab=GND}
N 1260 -320 1260 -220 { lab=#net1}
N 1120 -320 1260 -320 { lab=#net1}
N 1120 -100 1140 -100 { lab=GND}
N 1120 -120 1120 -100 { lab=GND}
N 1120 -320 1120 -280 { lab=#net1}
C {devices/code_shown.sym} 198.75 -701.875 0 0 {name=NGSPICE
only_toplevel=true
value="
.option temp=25
.control
.save all
.options savecurrents
DC I0 -70m 70m 0.001
plot vclamp vs @I0[current]
.endc
"}
C {devices/code.sym} 60 -250 0 0 {name=TT_MODELS
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
.include \\\\$::SKYWATER_MODELS\\\\/models/sky130_fd_pr__model__diode_pd2nw_11v0.model.spice
.include \\\\$::SKYWATER_MODELS\\\\/models/sky130_fd_pr__model__diode_pw2nd_11v0.model.spice

"
}
C {devices/isource.sym} 820 -150 2 0 {name=I0 value=1m}
C {devices/gnd.sym} 820 -100 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} 1260 -190 0 0 {name=V1 value=3.3}
C {devices/lab_wire.sym} 880 -200 0 1 {name=l2 sig_type=std_logic lab=vclamp}
C {sky130_fd_pr/diode.sym} 1120 -250 0 0 {name=D2
model=diode_pw2nd_11v0
area=16
}
C {devices/gnd.sym} 1120 -100 0 0 {name=l1 lab=GND}
C {sky130_fd_pr/diode.sym} 1120 -150 0 0 {name=D1
model=diode_pw2nd_11v0
area=16
}
