v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {This circuit uses the HVL logic library. Make sure to set the xschemrc SKYWATER_STDCELLS variable for sky130_fd_sc_hvl} 60 -70 0 0 0.4 0.4 {}
N 360 -850 360 -830 { lab=V3V3}
N 360 -770 360 -750 { lab=GND}
N 320 -200 320 -180 { lab=GND}
N 320 -280 320 -260 { lab=PULSEB}
N 320 -300 340 -300 { lab=PULSEB}
N 320 -300 320 -280 { lab=PULSEB}
N 460 -770 460 -750 { lab=GND}
N 540 -770 540 -750 { lab=GND}
N 460 -850 460 -830 { lab=VPB}
N 540 -850 540 -830 { lab=VPWR}
N 500 -200 580 -200 { lab=PULSEB}
N 500 -290 500 -200 { lab=PULSEB}
N 500 -290 530 -290 { lab=PULSEB}
N 610 -290 630 -290 { lab=#net1}
N 660 -200 740 -200 { lab=N_IN_N}
N 710 -290 740 -290 { lab=N_IN}
N 920 -420 950 -420 { lab=GND}
N 920 -420 920 -390 { lab=GND}
N 950 -420 960 -420 { lab=GND}
N 320 -470 320 -450 { lab=GND}
N 320 -550 320 -530 { lab=PULSEA}
N 320 -570 340 -570 { lab=PULSEA}
N 320 -570 320 -550 { lab=PULSEA}
N 520 -460 600 -460 { lab=PULSEA}
N 520 -550 520 -460 { lab=PULSEA}
N 520 -550 550 -550 { lab=PULSEA}
N 630 -550 650 -550 { lab=#net2}
N 680 -460 760 -460 { lab=P_IN}
N 730 -550 760 -550 { lab=P_IN_N}
N 320 -540 520 -540 { lab=PULSEA}
N 320 -280 500 -280 { lab=PULSEB}
N 1380 -340 1500 -340 { lab=SW_NODE}
N 1500 -340 1500 -320 { lab=SW_NODE}
N 1500 -255 1500 -220 { lab=GND}
N 960 -500 980 -500 { lab=V3V3}
N 960 -420 980 -420 { lab=GND}
N 960 -320 980 -320 { lab=P_IN}
N 960 -280 980 -280 { lab=P_IN_N}
N 960 -220 980 -220 { lab=N_IN}
N 960 -180 980 -180 { lab=N_IN_N}
N 1380 -380 1420 -380 { lab=#net3}
N 1480 -380 1560 -380 { lab=GND}
N 620 -760 620 -750 { lab=GND}
N 700 -760 700 -750 { lab=GND}
N 620 -850 620 -820 { lab=VNB}
N 700 -850 700 -820 { lab=VGND}
N 1500 -260 1500 -255 { lab=GND}
N 1440 -340 1440 -320 { lab=SW_NODE}
N 1580 -250 1580 -220 { lab=GND}
N 1500 -340 1580 -340 { lab=SW_NODE}
N 1580 -330 1580 -310 { lab=SW_NODE}
N 1580 -340 1580 -330 { lab=SW_NODE}
N 1380 -280 1380 -240 { lab=SW_ESD}
N 1380 -240 1410 -240 { lab=SW_ESD}
N 1410 -240 1410 -200 { lab=SW_ESD}
C {devices/code_shown.sym} -1.25 -731.875 0 0 {name=NGSPICE
only_toplevel=true
value="
.options savecurrents
.option temp=75
.control
save all
tran 1n 5u
write power_stage_tb.raw
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
.lib \\\\$::SKYWATER_MODELS\\\\/models/sky130.lib.spice ss
.option wnflag=1
"
}
C {devices/vsource.sym} 360 -800 0 0 {name=V1 value=3.3}
C {devices/gnd.sym} 360 -750 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 360 -850 0 0 {name=l3 sig_type=std_logic lab=V3V3
}
C {devices/vsource.sym} 320 -230 0 0 {name=V2 value="PULSE(0 3.3 0 2n 2n 450n 1u)"}
C {devices/gnd.sym} 320 -180 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 340 -300 2 0 {name=l8 sig_type=std_logic lab=PULSEB
}
C {design/power-stage/power_stage.sym} 1180 -360 0 0 {name=x2}
C {devices/vsource.sym} 460 -800 0 0 {name=V3 value=3.3}
C {devices/gnd.sym} 460 -750 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 540 -800 0 0 {name=V4 value=3.3}
C {devices/gnd.sym} 540 -750 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} 460 -850 0 0 {name=l5 sig_type=std_logic lab=VPB
}
C {devices/lab_pin.sym} 540 -850 0 0 {name=l6 sig_type=std_logic lab=VPWR
}
C {devices/gnd.sym} 620 -750 0 0 {name=l9 lab=GND}
C {devices/lab_pin.sym} 620 -850 0 0 {name=l10 sig_type=std_logic lab=VNB
}
C {devices/gnd.sym} 700 -750 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 700 -850 0 0 {name=l12 sig_type=std_logic lab=VGND
}
C {devices/lab_pin.sym} 960 -320 0 0 {name=l13 sig_type=std_logic lab=P_IN
}
C {devices/lab_pin.sym} 960 -280 0 0 {name=l14 sig_type=std_logic lab=P_IN_N
}
C {devices/lab_pin.sym} 960 -220 0 0 {name=l15 sig_type=std_logic lab=N_IN
}
C {devices/lab_pin.sym} 960 -180 0 0 {name=l16 sig_type=std_logic lab=N_IN_N
}
C {devices/lab_pin.sym} 960 -500 0 0 {name=l17 sig_type=std_logic lab=V3V3
}
C {devices/gnd.sym} 920 -390 0 0 {name=l19 lab=GND}
C {devices/gnd.sym} 320 -450 0 0 {name=l20 lab=GND}
C {devices/lab_pin.sym} 340 -570 2 0 {name=l21 sig_type=std_logic lab=PULSEA
}
C {sky130_stdcells/inv_4.sym} 590 -550 0 0 {name=x5 VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hvl__ }
C {devices/vsource.sym} 320 -500 0 0 {name=V5 value="PULSE(0 3.3 500n 2n 2n 450n 1u)"}
C {devices/lab_pin.sym} 760 -460 2 0 {name=l22 sig_type=std_logic lab=P_IN
}
C {devices/lab_pin.sym} 760 -550 2 0 {name=l23 sig_type=std_logic lab=P_IN_N
}
C {devices/lab_pin.sym} 740 -290 2 0 {name=l24 sig_type=std_logic lab=N_IN
}
C {devices/lab_pin.sym} 740 -200 2 0 {name=l25 sig_type=std_logic lab=N_IN_N
}
C {devices/res.sym} 1500 -290 0 0 {name=R1
value=100
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1500 -220 0 0 {name=l26 lab=GND}
C {sky130_stdcells/inv_4.sym} 690 -550 0 0 {name=x1 VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hvl__ }
C {sky130_stdcells/inv_4.sym} 640 -460 0 0 {name=x3 VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hvl__ }
C {sky130_stdcells/inv_4.sym} 570 -290 0 0 {name=x4 VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hvl__ }
C {sky130_stdcells/inv_4.sym} 670 -290 0 0 {name=x6 VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hvl__ }
C {sky130_stdcells/inv_4.sym} 620 -200 0 0 {name=x7 VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hvl__ }
C {devices/res.sym} 1450 -380 1 0 {name=R2
value=8000
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1560 -380 0 0 {name=l27 lab=GND}
C {devices/vsource.sym} 620 -790 0 0 {name=V6 value=0}
C {devices/vsource.sym} 700 -790 0 0 {name=V7 value=0}
C {devices/lab_pin.sym} 1440 -320 0 0 {name=l28 sig_type=std_logic lab=SW_NODE
}
C {devices/isource.sym} 1580 -280 0 0 {name=I0 value=400m}
C {devices/gnd.sym} 1580 -220 0 0 {name=l18 lab=GND}
C {devices/lab_pin.sym} 1410 -200 0 0 {name=l29 sig_type=std_logic lab=SW_ESD
}
