v {xschem version=2.9.8 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 310 -210 310 -190 { lab=GND}
N 170 -190 310 -190 { lab=GND}
N 170 -210 170 -190 { lab=GND}
N 170 -310 170 -270 { lab=V_GATE}
N 310 -220 310 -210 { lab=GND}
N 310 -310 310 -290 { lab=V_DRAIN}
N 310 -260 330 -260 { lab=GND}
N 330 -260 330 -210 { lab=GND}
N 310 -210 330 -210 { lab=GND}
N 310 -230 310 -220 { lab=GND}
N 420 -200 420 -190 { lab=GND}
N 420 -280 420 -260 { lab=V_DRAIN}
N 170 -310 230 -310 { lab=V_GATE}
N 230 -310 230 -260 { lab=V_GATE}
N 230 -260 270 -260 { lab=V_GATE}
N 420 -310 420 -280 { lab=V_DRAIN}
N 310 -310 420 -310 { lab=V_DRAIN}
N 310 -330 310 -310 { lab=V_DRAIN}
C {vsource.sym} 170 -240 0 1 {name=VGS_TEST value="1"}
C {code_shown.sym} 530 -530 0 0 {name=SPICE only_toplevel=false value=".lib /usr/local/share/sky130_fd_pr/models/sky130.lib.spice tt
.dc VGS_TEST -2 2 0.05
.Options savecurrents
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[gm]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[gds]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cgg]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cgs]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cgd]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cbg]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cdb]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cbs]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cdg]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cdd]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cds]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[csg]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[csd]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[css]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cgb]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cdb]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[csb]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[cbb]
.save @m.xm1.msky130_fd_pr__nfet_g5v0d10v5[qg]

.save all"
}
C {title.sym} 170 -50 0 0 {name=l5 author="Weston Braun"}
C {nmos4.sym} 290 -260 0 0 {name=M1 model=sky130_fd_pr__nfet_g5v0d10v5 w=10 l=0.5 spiceprefix=X m=1}
C {gnd.sym} 170 -190 0 0 {name=l1 lab=GND}
C {lab_pin.sym} 170 -300 0 0 {name=l3 sig_type=std_logic lab=V_GATE}
C {lab_pin.sym} 310 -330 2 0 {name=l4 sig_type=std_logic lab=V_DRAIN}
C {gnd.sym} 420 -190 0 0 {name=l2 lab=GND}
C {vsource.sym} 420 -230 0 1 {name=VDS_TEST value="0"}
