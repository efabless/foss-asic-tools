v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 190 -510 190 -480 { lab=V3V3}
N 190 -420 190 -390 { lab=GND}
N 800 -520 800 -480 { lab=V3V3}
N 1000 -540 1000 -510 { lab=GND}
N 120 -420 120 -390 { lab=GND}
N 120 -510 120 -480 { lab=IBIAS}
N 960 -120 960 -80 { lab=IBIAS}
N 1010 -300 1080 -300 { lab=VOUT}
N 300 -540 300 -510 { lab=VINP}
N 300 -450 300 -420 { lab=VINM}
N 300 -430 320 -430 { lab=VINM}
N 300 -360 300 -300 { lab=GND}
N 1150 -300 1180 -300 { lab=INVOUT}
N 650 -340 700 -340 { lab=VINP}
N 650 -260 700 -260 { lab=VINM}
N 320 -240 320 -220 { lab=VTEST}
N 320 -160 320 -140 { lab=GND}
N 940 -540 940 -480 { lab=GND}
N 940 -540 1000 -540 { lab=GND}
C {devices/vsource.sym} 190 -450 0 0 {name=V1 value=3.3
}
C {devices/lab_pin.sym} 190 -510 0 0 {name=l1 sig_type=std_logic lab=V3V3
}
C {devices/gnd.sym} 190 -390 0 1 {name=l2 lab=GND}
C {devices/lab_pin.sym} 800 -520 0 0 {name=l3 sig_type=std_logic lab=V3V3
}
C {devices/gnd.sym} 1000 -510 0 0 {name=l4 lab=GND}
C {devices/isource.sym} 120 -450 0 0 {name=I0 value=20u}
C {devices/gnd.sym} 120 -390 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 120 -510 0 0 {name=l6 sig_type=std_logic lab=IBIAS

}
C {devices/lab_pin.sym} 960 -80 0 1 {name=l7 sig_type=std_logic lab=IBIAS}
C {devices/lab_pin.sym} 1040 -300 1 1 {name=l8 sig_type=std_logic lab=VOUT

}
C {devices/lab_pin.sym} 300 -540 0 0 {name=l9 sig_type=std_logic lab=VINP

}
C {devices/lab_pin.sym} 320 -430 2 0 {name=l10 sig_type=std_logic lab=VINM


}
C {devices/lab_pin.sym} 650 -340 0 0 {name=l11 sig_type=std_logic lab=VINP

}
C {devices/lab_pin.sym} 650 -260 0 0 {name=l12 sig_type=std_logic lab=VINM


}
C {devices/code.sym} 1260 -400 0 0 {name=STDCELL_MODELS 
only_toplevel=true
place=end
format="tcleval(@value )"
value="[sky130_models]"
name=s1 only_toplevel=false value=blabla}
C {devices/code.sym} 1260 -230 0 0 {name=TT_MODELS
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
C {devices/code_shown.sym} 738.75 -41.875 0 0 {name=NGSPICE
only_toplevel=true
value="
.option RSHUNT = 1e20
.include /home/atumkur/EE272B/open-pmic/layout/comparator/comparator_pex.spice
.control
.save all
tran 1n 3u
write comparator_w_obuff_tb.raw
.endc
"}
C {devices/gnd.sym} 300 -300 0 1 {name=l13 lab=GND}
C {devices/vsource.sym} 300 -390 0 0 {name=V3 value=0.1
}
C {sky130_stdcells/inv_4.sym} 1110 -300 0 0 {name=x2 VGND=GND VNB=GND VPB=V3V3 VPWR=V3V3 prefix=sky130_fd_sc_hvl__ }
C {devices/lab_pin.sym} 1180 -300 1 1 {name=l14 sig_type=std_logic lab=INVOUT

}
C {devices/vsource.sym} 320 -190 0 0 {name=B1 value="V = V(VINP,VINM)" 
}
C {devices/gnd.sym} 320 -140 0 1 {name=l15 lab=GND}
C {devices/lab_pin.sym} 320 -240 2 0 {name=l16 sig_type=std_logic lab=VTEST


}
C {layout/comparator/comparator_extracted.sym} 860 -300 0 0 {name=x1}
C {devices/vsource.sym} 300 -480 0 0 {name=V2 value="pulse -0.5 0.5 0 1u 1u 0.5u 3u" }
