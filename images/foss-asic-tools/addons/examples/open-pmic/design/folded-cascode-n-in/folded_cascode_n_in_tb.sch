v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {IREF is 4x bias current} 240 -100 0 0 0.4 0.4 {}
N 760 -490 760 -470 { lab=V3V3}
N 760 -410 760 -390 { lab=GND}
N 1280 -40 1280 -20 { lab=GND}
N 1280 -120 1280 -100 { lab=#net1}
N 750 -160 750 -140 { lab=GND}
N 750 -240 750 -220 { lab=#net2}
N 750 -320 750 -300 { lab=INP}
N 750 -320 770 -320 { lab=INP}
N 1260 -520 1260 -500 { lab=GND}
N 1120 -520 1120 -500 { lab=V3V3}
N 1000 -360 1020 -360 { lab=INP}
N 1000 -280 1020 -280 { lab=INM}
N 1710 -230 1710 -210 { lab=GND}
N 1710 -320 1710 -290 { lab=OUT}
N 1280 -140 1280 -120 { lab=#net1}
N 1440 -320 1440 -280 { lab=OUT}
N 1440 -140 1440 -100 { lab=INM}
N 1440 -40 1440 -20 { lab=GND}
N 1440 -120 1460 -120 { lab=INM}
N 1440 -220 1440 -200 { lab=#net3}
N 1360 -320 1440 -320 { lab=OUT}
N 1440 -320 1710 -320 { lab=OUT}
C {devices/code_shown.sym} 68.75 -841.875 0 0 {name=NGSPICE
only_toplevel=true
value="
.param CM_VOLTAGE = 3.3
.param OUTPUT_VOLTAGE = 2.5
.control
save all
ac dec 200 10 1000Meg
settype decibel out
plot vdb(out)
let phase_val = 180/PI*cph(out)
let phase_margin_val = 180 + 180/PI*cph(out)
settype phase phase_val
plot phase_val
meas ac phase_margin find phase_margin_val when vdb(out)=0
meas ac crossover_freq WHEN vdb(out)=0
op
print v(inp)
print v(inm)
print v(out)
let v_offset = v(inp)-v(inm)
print v_offset
.endc
"}
C {devices/code.sym} 60 -420 0 0 {name=STDCELL_MODELS 
only_toplevel=true
place=end
format="tcleval(@value )"
value="[sky130_models]"
name=s1 only_toplevel=false value=blabla}
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
"
}
C {devices/vsource.sym} 760 -440 0 0 {name=V1 value=3.3}
C {devices/gnd.sym} 760 -390 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 760 -490 0 0 {name=l3 sig_type=std_logic lab=V3V3
}
C {devices/isource.sym} 1280 -70 2 0 {name=I0 value=40u
}
C {devices/gnd.sym} 1280 -20 0 0 {name=l1 lab=GND}
C {design/folded-cascode-n-in/folded_cascode_n_in.sym} 1180 -320 0 0 {}
C {devices/vsource.sym} 750 -190 0 0 {name=V2 value=\{CM_VOLTAGE\}}
C {devices/gnd.sym} 750 -140 0 0 {name=l16 lab=GND}
C {devices/vsource.sym} 750 -270 0 0 {name=V3 value="AC 1"}
C {devices/lab_pin.sym} 770 -320 2 0 {name=l18 sig_type=std_logic lab=INP
}
C {devices/lab_pin.sym} 1000 -360 0 0 {name=l19 sig_type=std_logic lab=INP
}
C {devices/lab_pin.sym} 1000 -280 0 0 {name=l20 sig_type=std_logic lab=INM
}
C {devices/lab_pin.sym} 1120 -520 0 0 {name=l21 sig_type=std_logic lab=V3V3
}
C {devices/gnd.sym} 1260 -520 2 0 {name=l22 lab=GND}
C {devices/lab_pin.sym} 1710 -320 2 0 {name=l23 sig_type=std_logic lab=OUT
}
C {devices/capa.sym} 1710 -260 0 0 {name=C1
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1710 -210 0 0 {name=l24 lab=GND}
C {devices/res.sym} 1440 -170 0 0 {name=R1
value=10E6
footprint=1206
device=resistor
m=1}
C {devices/vsource.sym} 1440 -250 0 0 {name=V4 value=\{OUTPUT_VOLTAGE-CM_VOLTAGE\}}
C {devices/capa.sym} 1440 -70 0 0 {name=C2
m=1
value=1
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1440 -20 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} 1460 -120 0 1 {name=l6 sig_type=std_logic lab=INM
}
