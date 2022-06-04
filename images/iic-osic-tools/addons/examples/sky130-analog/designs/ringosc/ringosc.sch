v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 300 -500 340 -500 { lab=#net1}
N 420 -500 460 -500 { lab=#net2}
N 540 -500 580 -500 { lab=#net3}
N 660 -500 700 -500 { lab=#net4}
N 580 -712.5 580 -700 { lab=VDD2}
N 580 -640 580 -633.125 { lab=GND}
N 200 -500 220 -500 { lab=#net5}
N 200 -500 200 -460 { lab=#net5}
N 200 -460 800 -460 { lab=#net5}
N 780 -500 780 -460 { lab=#net5}
N 820 -500 820 -460 { lab=#net5}
N 800 -460 820 -460 { lab=#net5}
N 900 -500 920 -500 { lab=OUT}
C {sky130_stdcells/inv_8.sym} 260 -500 0 0 {name=x1 VGND=VSS VNB=VNB VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_8.sym} 380 -500 0 0 {name=x2 VGND=VSS VNB=VNB VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_8.sym} 500 -500 0 0 {name=x3 VGND=VSS VNB=VNB VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_8.sym} 620 -500 0 0 {name=x4 VGND=VSS VNB=VNB VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_8.sym} 740 -500 0 0 {name=x5 VGND=VSS VNB=VNB VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/inv_8.sym} 860 -500 0 0 {name=x6 VGND=VSS VNB=VNB VPB=VDD2 VPWR=VDD2 prefix=sky130_fd_sc_hd__ }
C {devices/vsource.sym} 580 -670 0 0 {name=V1 value=1.8
}
C {devices/gnd.sym} 580 -633.125 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 580 -712.5 0 0 {name=l2 sig_type=std_logic lab=VDD2}
C {devices/lab_pin.sym} 920 -500 2 0 {name=l4 sig_type=std_logic lab=OUT
}
C {devices/code_shown.sym} 58.75 -851.875 0 0 {name=NGSPICE
only_toplevel=true
value="
vvss VNB 0 dc 0
vvsss VSS 0 dc 0
vvcc VPWR 0 pwl 0 0 10n 0 10.1n 1.8 20n 1.8 20.1n 0

.control
.save all
tran 0.01n 30n
write ringosc.raw
.endc
"
name=s1 only_toplevel=false value=blabla}
C {devices/code.sym} 650 -960 0 0 {name=STDCELL_MODELS 
only_toplevel=true
place=end
format="tcleval(@value )"
value="[sky130_models]"
name=s1 only_toplevel=false value=blabla}
C {devices/code.sym} 840 -930 0 0 {name=TT_MODELS
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
