v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 910 -350 910 -330 { lab=V1V8}
N 910 -270 910 -250 { lab=GND}
N 440 -340 440 -320 { lab=GND}
N 520 -400 600 -400 { lab=#net1}
N 440 -480 440 -460 { lab=VCTRL}
N 680 -400 720 -400 { lab=OUT1}
N 440 -120 440 -100 { lab=GND}
N 520 -180 600 -180 { lab=#net2}
N 680 -180 720 -180 { lab=OUT2}
N 440 -260 440 -240 { lab=VCTRL}
C {devices/code_shown.sym} 198.75 -701.875 0 0 {name=NGSPICE
only_toplevel=true
value="
VRING VCTRL 0 DC 1.8
.include /home/wbraun/projects/sky130-analog/designs/ringosc/pex.spice
.control
.save all
.ic V(OUT1)=0
.ic V(OUT2)=0
tran 0.01n 30n uic
write ringosc_tb.raw
.endc
"}
C {devices/code.sym} 130 -420 0 0 {name=STDCELL_MODELS 
only_toplevel=true
place=end
format="tcleval(@value )"
value="[sky130_models]"
name=s1 only_toplevel=false value=blabla}
C {devices/code.sym} 130 -250 0 0 {name=TT_MODELS
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
C {sky130_stdcells/inv_1.sym} 640 -400 0 0 {name=x1 VGND=GND VNB=GND VPB=V1V8 VPWR=V1V8 prefix=sky130_fd_sc_hd__ }
C {devices/gnd.sym} 440 -320 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 910 -300 0 0 {name=V1 value=1.8}
C {devices/gnd.sym} 910 -250 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 910 -350 0 0 {name=l3 sig_type=std_logic lab=V1V8
}
C {/home/wbraun/projects/sky130-analog/designs/ringosc/ringosc_subcircuit.sym} 480 -400 0 0 {}
C {devices/lab_pin.sym} 440 -480 0 0 {name=l4 sig_type=std_logic lab=VCTRL
}
C {devices/lab_pin.sym} 720 -400 2 0 {name=l5 sig_type=std_logic lab=OUT1
}
C {/home/wbraun/projects/sky130-analog/designs/ringosc/pex.sym} 480 -180 0 0 {name=x2}
C {devices/gnd.sym} 440 -100 0 0 {name=l6 lab=GND}
C {sky130_stdcells/inv_1.sym} 640 -180 0 0 {name=x3 VGND=GND VNB=GND VPB=V1V8 VPWR=V1V8 prefix=sky130_fd_sc_hd__ }
C {devices/lab_pin.sym} 720 -180 2 0 {name=l7 sig_type=std_logic lab=OUT2
}
C {devices/lab_pin.sym} 440 -260 0 0 {name=l8 sig_type=std_logic lab=VCTRL
}
