v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {This circuit uses the HVL logic library. Make sure to set the xschemrc SKYWATER_STDCELLS variable for sky130_fd_sc_hvl} 0 -30 0 0 0.4 0.4 {}
N 550 -510 550 -490 { lab=V3V3}
N 550 -430 550 -410 { lab=GND}
N 300 -200 300 -180 { lab=GND}
N 300 -280 300 -260 { lab=TIMEOUT}
N 300 -300 320 -300 { lab=TIMEOUT}
N 300 -300 300 -280 { lab=TIMEOUT}
N 1000 -680 1000 -660 { lab=V3V3}
N 1000 -680 1080 -680 { lab=V3V3}
N 1080 -680 1080 -660 { lab=V3V3}
N 1160 -680 1160 -660 { lab=GND}
N 1160 -680 1240 -680 { lab=GND}
N 1240 -680 1240 -660 { lab=GND}
N 1000 -700 1000 -680 { lab=V3V3}
N 1160 -700 1160 -680 { lab=GND}
N 1340 -500 1380 -500 { lab=PMOS_CTRL}
N 1340 -400 1380 -400 { lab=NMOS_CTRL}
N 840 -300 890 -300 { lab=GND}
N 840 -300 840 -280 { lab=GND}
N 840 -340 900 -340 { lab=GND}
N 840 -340 840 -300 { lab=GND}
N 840 -380 900 -380 { lab=GND}
N 840 -380 840 -340 { lab=GND}
N 880 -440 900 -440 { lab=V3V3}
N 530 -200 530 -180 { lab=GND}
N 530 -280 530 -260 { lab=OC_CMP}
N 530 -300 550 -300 { lab=OC_CMP}
N 530 -300 530 -280 { lab=OC_CMP}
N 880 -500 900 -500 { lab=OC_CMP}
N 880 -540 900 -540 { lab=TIMEOUT}
N 890 -300 900 -300 { lab=GND}
N 840 -240 900 -240 { lab=GND}
N 840 -240 840 -160 { lab=GND}
N 840 -200 900 -200 { lab=GND}
N 1340 -460 1380 -460 { lab=PMOS_CTRL_N}
N 1340 -360 1380 -360 { lab=NMOS_CTRL_N}
C {devices/code_shown.sym} 198.75 -701.875 0 0 {name=NGSPICE
only_toplevel=true
value="
.control
.save all
tran 0.1n 2u
write switch_control_tb.raw
.endc
"}
C {devices/code.sym} 60 -420 0 0 {name=STDCELL_MODELS 
only_toplevel=true
place=end
format="tcleval(@value )"
value="[sky130_models]"
}
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
C {devices/vsource.sym} 550 -460 0 0 {name=V1 value=3.3}
C {devices/gnd.sym} 550 -410 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 550 -510 0 0 {name=l3 sig_type=std_logic lab=V3V3
}
C {devices/lab_pin.sym} 880 -440 0 0 {name=l1 sig_type=std_logic lab=V3V3
}
C {devices/gnd.sym} 840 -280 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 300 -230 0 0 {name=V2 value="PULSE(0 3.3 0 3n 3n 50n 1u)"}
C {devices/gnd.sym} 300 -180 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 320 -300 2 0 {name=l8 sig_type=std_logic lab=TIMEOUT
}
C {design/switch-control/switch_control.sym} 1120 -440 0 0 {name=x2}
C {devices/gnd.sym} 1160 -700 2 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 1000 -700 0 0 {name=l12 sig_type=std_logic lab=V3V3
}
C {devices/lab_pin.sym} 1380 -500 2 0 {name=l13 sig_type=std_logic lab=PMOS_CTRL
}
C {devices/lab_pin.sym} 1380 -400 2 0 {name=l14 sig_type=std_logic lab=NMOS_CTRL
}
C {devices/vsource.sym} 530 -230 0 0 {name=V3 value="PULSE(0 3.3 500n 10n 10n 300n 1u)"}
C {devices/gnd.sym} 530 -180 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 550 -300 2 0 {name=l15 sig_type=std_logic lab=OC_CMP
}
C {devices/lab_pin.sym} 880 -500 2 1 {name=l16 sig_type=std_logic lab=OC_CMP
}
C {devices/lab_pin.sym} 880 -540 2 1 {name=l17 sig_type=std_logic lab=TIMEOUT
}
C {devices/gnd.sym} 840 -160 0 0 {name=l18 lab=GND}
C {devices/lab_pin.sym} 1380 -460 2 0 {name=l6 sig_type=std_logic lab=PMOS_CTRL_N
}
C {devices/lab_pin.sym} 1380 -360 2 0 {name=l9 sig_type=std_logic lab=NMOS_CTRL_N
}
