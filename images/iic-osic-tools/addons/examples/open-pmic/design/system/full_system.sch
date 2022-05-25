v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {Power Rails} -500 -1530 0 0 0.4 0.4 {}
T {Signals to analog mux GPIO} -500 -1370 0 0 0.4 0.4 {}
T {Logic Signals to GPIO Pad} -500 -1060 0 0 0.4 0.4 {}
T {Logic Signals driven by LA bus} -500 -930 0 0 0.4 0.4 {}
T {switching node} -500 -660 0 0 0.4 0.4 {}
T {I/O ESD and filtering} 410 420 0 0 0.4 0.4 {}
N 820 -1490 820 -1470 { lab=VDD}
N 820 -1490 900 -1490 { lab=VDD}
N 900 -1490 900 -1470 { lab=VDD}
N 980 -1490 980 -1470 { lab=VSS}
N 980 -1490 1060 -1490 { lab=VSS}
N 1060 -1490 1060 -1470 { lab=VSS}
N 1160 -1230 1440 -1230 { lab=PMOS_CTRL}
N 1160 -1190 1440 -1190 { lab=PMOS_CTRL_N}
N 1160 -1130 1440 -1130 { lab=NMOS_CTRL}
N 1160 -1090 1440 -1090 { lab=NMOS_CTRL_N}
N 1160 -1010 1200 -1010 { lab=TIMEOUT_SIG}
N 1100 -510 1120 -510 { lab=CYCLE_END}
N 720 -390 740 -390 { lab=TIMEOUT_SIG}
N 1420 -1410 1440 -1410 { lab=VDD_PWR}
N 1420 -1330 1440 -1330 { lab=VSS}
N 1840 -1250 1860 -1250 { lab=SW_NODE}
N 1840 -1290 1860 -1290 { lab=SENSE_FET}
N 720 -610 740 -610 { lab=SENSE_FET}
N 720 -570 740 -570 { lab=SW_NODE_ESD}
N 720 -530 740 -530 { lab=VREF}
N 720 -490 740 -490 { lab=VFB}
N 720 -450 740 -450 { lab=VCOMP}
N 1100 -430 1120 -430 { lab=IMON}
N 980 -270 980 -230 { lab=ISLOPE}
N 840 -270 840 -230 { lab=IBIAS}
N 700 -1130 720 -1130 { lab=SW_EN}
N 700 -1250 720 -1250 { lab=CYCLE_END}
N 700 -1330 720 -1330 { lab=TIMEOUT_EXT}
N 700 -1290 720 -1290 { lab=TIMEOUT_SEL}
N 700 -1090 720 -1090 { lab=SW_OVERRIDE}
N 700 -1050 720 -1050 { lab=PMOS_VAL}
N 700 -1010 720 -1010 { lab=NMOS_VAL}
N 700 -970 720 -970 { lab=PMOS_DT}
N 700 -930 720 -930 { lab=NMOS_DT}
N 860 -770 860 -750 { lab=VDD}
N 1540 -790 1540 -770 { lab=VDD}
N 1660 -790 1660 -770 { lab=VSS}
N 980 -770 980 -750 { lab=VSS}
N 1420 -650 1440 -650 { lab=IOSC}
N 1760 -650 1780 -650 { lab=TIMEOUT_INT}
N 700 -1370 720 -1370 { lab=TIMEOUT_INT}
N 900 -270 900 -190 { lab=IOC}
N 1100 -570 1120 -570 { lab=OVERCURRENT}
N 700 -1210 720 -1210 { lab=OVERCURRENT}
N 700 -1170 720 -1170 { lab=OC_EN}
N -90 -660 -90 -620 { lab=VREF}
N -130 -640 -90 -640 { lab=VREF}
N -150 -690 -130 -690 { lab=VDD}
N -150 -740 -150 -690 { lab=VDD}
N -150 -740 -70 -740 { lab=VDD}
N -90 -740 -90 -720 { lab=VDD}
N -90 -690 -70 -690 { lab=VDD}
N -70 -740 -70 -690 { lab=VDD}
N -150 -590 -130 -590 { lab=VSS}
N -150 -590 -150 -540 { lab=VSS}
N -150 -540 -90 -540 { lab=VSS}
N -90 -560 -90 -540 { lab=VSS}
N -90 -590 -70 -590 { lab=VSS}
N -70 -590 -70 -540 { lab=VSS}
N -90 -540 -70 -540 { lab=VSS}
N -90 -760 -90 -740 { lab=VDD}
N -120 -300 -120 -260 { lab=VFB}
N -160 -280 -120 -280 { lab=VFB}
N -180 -330 -160 -330 { lab=VDD}
N -180 -380 -180 -330 { lab=VDD}
N -180 -380 -100 -380 { lab=VDD}
N -120 -380 -120 -360 { lab=VDD}
N -120 -330 -100 -330 { lab=VDD}
N -100 -380 -100 -330 { lab=VDD}
N -180 -230 -160 -230 { lab=VSS}
N -180 -230 -180 -180 { lab=VSS}
N -180 -180 -120 -180 { lab=VSS}
N -120 -200 -120 -180 { lab=VSS}
N -120 -230 -100 -230 { lab=VSS}
N -100 -230 -100 -180 { lab=VSS}
N -120 -180 -100 -180 { lab=VSS}
N -120 -400 -120 -380 { lab=VDD}
N 160 -300 160 -260 { lab=VCOMP}
N 120 -280 160 -280 { lab=VCOMP}
N 100 -330 120 -330 { lab=VDD}
N 100 -380 100 -330 { lab=VDD}
N 100 -380 180 -380 { lab=VDD}
N 160 -380 160 -360 { lab=VDD}
N 160 -330 180 -330 { lab=VDD}
N 180 -380 180 -330 { lab=VDD}
N 100 -230 120 -230 { lab=VSS}
N 100 -230 100 -180 { lab=VSS}
N 100 -180 160 -180 { lab=VSS}
N 160 -200 160 -180 { lab=VSS}
N 160 -230 180 -230 { lab=VSS}
N 180 -230 180 -180 { lab=VSS}
N 160 -180 180 -180 { lab=VSS}
N 160 -400 160 -380 { lab=VDD}
N 160 -20 160 20 { lab=ISLOPE}
N 120 0 160 0 { lab=ISLOPE}
N 100 -50 120 -50 { lab=VDD}
N 100 -100 100 -50 { lab=VDD}
N 100 -100 180 -100 { lab=VDD}
N 160 -100 160 -80 { lab=VDD}
N 160 -50 180 -50 { lab=VDD}
N 180 -100 180 -50 { lab=VDD}
N 100 50 120 50 { lab=VSS}
N 100 50 100 100 { lab=VSS}
N 100 100 160 100 { lab=VSS}
N 160 80 160 100 { lab=VSS}
N 160 50 180 50 { lab=VSS}
N 180 50 180 100 { lab=VSS}
N 160 100 180 100 { lab=VSS}
N 160 -120 160 -100 { lab=VDD}
N -120 -20 -120 20 { lab=IBIAS}
N -160 0 -120 0 { lab=IBIAS}
N -180 -50 -160 -50 { lab=VDD}
N -180 -100 -180 -50 { lab=VDD}
N -180 -100 -100 -100 { lab=VDD}
N -120 -100 -120 -80 { lab=VDD}
N -120 -50 -100 -50 { lab=VDD}
N -100 -100 -100 -50 { lab=VDD}
N -180 50 -160 50 { lab=VSS}
N -180 50 -180 100 { lab=VSS}
N -180 100 -120 100 { lab=VSS}
N -120 80 -120 100 { lab=VSS}
N -120 50 -100 50 { lab=VSS}
N -100 50 -100 100 { lab=VSS}
N -120 100 -100 100 { lab=VSS}
N -120 -120 -120 -100 { lab=VDD}
N -120 260 -120 300 { lab=IMON}
N -160 280 -120 280 { lab=IMON}
N -180 230 -160 230 { lab=VDD}
N -180 180 -180 230 { lab=VDD}
N -180 180 -100 180 { lab=VDD}
N -120 180 -120 200 { lab=VDD}
N -120 230 -100 230 { lab=VDD}
N -100 180 -100 230 { lab=VDD}
N -180 330 -160 330 { lab=VSS}
N -180 330 -180 380 { lab=VSS}
N -180 380 -120 380 { lab=VSS}
N -120 360 -120 380 { lab=VSS}
N -120 330 -100 330 { lab=VSS}
N -100 330 -100 380 { lab=VSS}
N -120 380 -100 380 { lab=VSS}
N -120 160 -120 180 { lab=VDD}
N 160 260 160 300 { lab=IOSC}
N 120 280 160 280 { lab=IOSC}
N 100 230 120 230 { lab=VDD}
N 100 180 100 230 { lab=VDD}
N 100 180 180 180 { lab=VDD}
N 160 180 160 200 { lab=VDD}
N 160 230 180 230 { lab=VDD}
N 180 180 180 230 { lab=VDD}
N 100 330 120 330 { lab=VSS}
N 100 330 100 380 { lab=VSS}
N 100 380 160 380 { lab=VSS}
N 160 360 160 380 { lab=VSS}
N 160 330 180 330 { lab=VSS}
N 180 330 180 380 { lab=VSS}
N 160 380 180 380 { lab=VSS}
N 160 160 160 180 { lab=VDD}
N -120 540 -120 580 { lab=IOC}
N -160 560 -120 560 { lab=IOC}
N -180 510 -160 510 { lab=VDD}
N -180 460 -180 510 { lab=VDD}
N -180 460 -100 460 { lab=VDD}
N -120 460 -120 480 { lab=VDD}
N -120 510 -100 510 { lab=VDD}
N -100 460 -100 510 { lab=VDD}
N -180 610 -160 610 { lab=VSS}
N -180 610 -180 660 { lab=VSS}
N -180 660 -120 660 { lab=VSS}
N -120 640 -120 660 { lab=VSS}
N -120 610 -100 610 { lab=VSS}
N -100 610 -100 660 { lab=VSS}
N -120 660 -100 660 { lab=VSS}
N -120 440 -120 460 { lab=VDD}
N 1840 -1190 1860 -1190 { lab=SW_NODE_ESD}
N 720 -650 740 -650 { lab=SENSE_FET_KELVIN}
N 1840 -1330 1860 -1330 { lab=SENSE_FET_KELVIN}
C {devices/iopin.sym} -500 -1480 0 0 {name=p1 lab=VDD
}
C {devices/iopin.sym} -500 -1420 0 0 {name=p2 lab=VSS
}
C {devices/iopin.sym} -500 -1230 0 0 {name=p3 lab=IBIAS
}
C {devices/iopin.sym} -500 -1200 0 0 {name=p6 lab=ISLOPE
}
C {devices/iopin.sym} -500 -1320 0 0 {name=p7 lab=VREF
}
C {devices/iopin.sym} -500 -1290 0 0 {name=p8 lab=VFB
}
C {devices/iopin.sym} -500 -1260 0 0 {name=p9 lab=VCOMP
}
C {design/system/analog_subsystem.sym} 920 -510 0 0 {name=x1}
C {design/power-stage/power_stage.sym} 1640 -1270 0 0 {name=x2}
C {design/switch-control/switch_control.sym} 940 -1170 0 0 {name=x3}
C {devices/lab_wire.sym} 820 -1490 0 1 {name=l1 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 860 -770 0 1 {name=l2 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 1120 -510 0 1 {name=l3 sig_type=std_logic lab=CYCLE_END}
C {devices/lab_wire.sym} 700 -1250 0 0 {name=l4 sig_type=std_logic lab=CYCLE_END}
C {devices/lab_wire.sym} 1200 -1010 0 1 {name=l5 sig_type=std_logic lab=TIMEOUT_SIG}
C {devices/lab_wire.sym} 1180 -1230 0 1 {name=l6 sig_type=std_logic lab=PMOS_CTRL}
C {devices/lab_wire.sym} 1180 -1190 0 1 {name=l7 sig_type=std_logic lab=PMOS_CTRL_N}
C {devices/lab_wire.sym} 1180 -1130 0 1 {name=l8 sig_type=std_logic lab=NMOS_CTRL}
C {devices/lab_wire.sym} 1180 -1090 0 1 {name=l9 sig_type=std_logic lab=NMOS_CTRL_N}
C {devices/lab_wire.sym} 720 -390 0 0 {name=l10 sig_type=std_logic lab=TIMEOUT_SIG}
C {devices/lab_wire.sym} 980 -1490 0 1 {name=l11 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1420 -1410 0 0 {name=l12 sig_type=std_logic lab=VDD_PWR}
C {devices/lab_wire.sym} 1420 -1330 0 0 {name=l13 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1860 -1250 0 1 {name=l14 sig_type=std_logic lab=SW_NODE}
C {devices/lab_wire.sym} 1860 -1290 0 1 {name=l15 sig_type=std_logic lab=SENSE_FET}
C {devices/iopin.sym} -500 -1450 0 0 {name=p11 lab=VDD_PWR
}
C {devices/lab_wire.sym} 720 -610 0 0 {name=l16 sig_type=std_logic lab=SENSE_FET}
C {devices/lab_wire.sym} 720 -490 0 0 {name=l19 sig_type=std_logic lab=VFB}
C {devices/lab_wire.sym} 720 -450 0 0 {name=l20 sig_type=std_logic lab=VCOMP}
C {devices/lab_wire.sym} 840 -230 0 0 {name=l21 sig_type=std_logic lab=IBIAS}
C {devices/lab_wire.sym} 980 -230 0 0 {name=l22 sig_type=std_logic lab=ISLOPE}
C {devices/lab_wire.sym} 1120 -430 0 1 {name=l23 sig_type=std_logic lab=IMON}
C {devices/iopin.sym} -500 -1170 0 0 {name=p12 lab=IMON}
C {devices/iopin.sym} -500 -1010 0 0 {name=p13 lab=SW_EN
}
C {devices/iopin.sym} -500 -980 0 0 {name=p14 lab=TIMEOUT_EXT
}
C {devices/iopin.sym} -500 -890 0 0 {name=p15 lab=TIMEOUT_SEL
}
C {devices/iopin.sym} -500 -860 0 0 {name=p16 lab=SW_OVERRIDE
}
C {devices/iopin.sym} -500 -830 0 0 {name=p17 lab=PMOS_VAL
}
C {devices/iopin.sym} -500 -800 0 0 {name=p18 lab=NMOS_VAL
}
C {devices/iopin.sym} -500 -770 0 0 {name=p19 lab=PMOS_DT
}
C {devices/iopin.sym} -500 -740 0 0 {name=p20 lab=NMOS_DT
}
C {devices/lab_wire.sym} 700 -1130 0 0 {name=l24 sig_type=std_logic lab=SW_EN}
C {devices/lab_wire.sym} 700 -1330 0 0 {name=l25 sig_type=std_logic lab=TIMEOUT_EXT}
C {devices/lab_wire.sym} 700 -1290 0 0 {name=l26 sig_type=std_logic lab=TIMEOUT_SEL}
C {devices/lab_wire.sym} 700 -1090 0 0 {name=l27 sig_type=std_logic lab=SW_OVERRIDE}
C {devices/lab_wire.sym} 700 -1050 0 0 {name=l28 sig_type=std_logic lab=PMOS_VAL}
C {devices/lab_wire.sym} 700 -1010 0 0 {name=l29 sig_type=std_logic lab=NMOS_VAL}
C {devices/lab_wire.sym} 700 -970 0 0 {name=l30 sig_type=std_logic lab=PMOS_DT}
C {devices/lab_wire.sym} 700 -930 0 0 {name=l31 sig_type=std_logic lab=NMOS_DT}
C {devices/iopin.sym} -500 -1140 0 0 {name=p4 lab=IOSC}
C {design/oscillator/osc_placeholder.sym} 1590 -670 0 0 {name=x4}
C {devices/lab_wire.sym} 1540 -790 0 1 {name=l32 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 1660 -790 0 1 {name=l33 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 980 -770 0 1 {name=l34 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1420 -650 0 0 {name=l35 sig_type=std_logic lab=IOSC}
C {devices/lab_wire.sym} 1780 -650 0 1 {name=l36 sig_type=std_logic lab=TIMEOUT_INT}
C {devices/lab_wire.sym} 700 -1370 0 0 {name=l37 sig_type=std_logic lab=TIMEOUT_INT}
C {devices/iopin.sym} -500 -600 0 0 {name=p5 lab=SW_NODE
}
C {devices/iopin.sym} -500 -1110 0 0 {name=p10 lab=IOC}
C {devices/lab_wire.sym} 900 -190 0 0 {name=l38 sig_type=std_logic lab=IOC}
C {devices/iopin.sym} -500 -710 0 0 {name=p21 lab=OC_EN
}
C {devices/lab_wire.sym} 1120 -570 0 1 {name=l39 sig_type=std_logic lab=OVERCURRENT}
C {devices/lab_wire.sym} 700 -1210 0 0 {name=l40 sig_type=std_logic lab=OVERCURRENT}
C {devices/lab_wire.sym} 700 -1170 0 0 {name=l41 sig_type=std_logic lab=OC_EN}
C {devices/lab_wire.sym} -130 -640 0 0 {name=l43 sig_type=std_logic lab=VREF}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} -110 -590 0 0 {name=M1
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} -110 -690 0 0 {name=M2
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} -90 -760 0 1 {name=l46 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -140 -540 0 1 {name=l47 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -160 -280 0 0 {name=l45 sig_type=std_logic lab=VFB}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} -140 -230 0 0 {name=M3
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} -140 -330 0 0 {name=M4
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} -120 -400 0 1 {name=l48 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -170 -180 0 1 {name=l49 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 120 -280 0 0 {name=l50 sig_type=std_logic lab=VCOMP}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 140 -230 0 0 {name=M5
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 140 -330 0 0 {name=M6
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} 160 -400 0 1 {name=l51 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 110 -180 0 1 {name=l52 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 120 0 0 0 {name=l53 sig_type=std_logic lab=ISLOPE}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 140 50 0 0 {name=M7
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 140 -50 0 0 {name=M8
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} 160 -120 0 1 {name=l54 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 110 100 0 1 {name=l55 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -160 0 0 0 {name=l56 sig_type=std_logic lab=IBIAS}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} -140 50 0 0 {name=M9
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} -140 -50 0 0 {name=M10
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} -120 -120 0 1 {name=l57 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -170 100 0 1 {name=l58 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -160 280 0 0 {name=l59 sig_type=std_logic lab=IMON}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} -140 330 0 0 {name=M11
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} -140 230 0 0 {name=M12
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} -120 160 0 1 {name=l60 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -170 380 0 1 {name=l61 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 120 280 0 0 {name=l62 sig_type=std_logic lab=IOSC}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 140 330 0 0 {name=M13
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 140 230 0 0 {name=M14
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} 160 160 0 1 {name=l63 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 110 380 0 1 {name=l64 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -160 560 0 0 {name=l65 sig_type=std_logic lab=IOC}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} -140 610 0 0 {name=M15
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} -140 510 0 0 {name=M16
L=0.5
W=5
nf=1
mult=20
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} -120 440 0 1 {name=l66 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} -170 660 0 1 {name=l67 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 1860 -1190 0 1 {name=l68 sig_type=std_logic lab=SW_NODE_ESD}
C {devices/lab_wire.sym} 720 -570 0 0 {name=l69 sig_type=std_logic lab=SW_NODE_ESD}
C {devices/lab_wire.sym} 720 -530 0 0 {name=l18 sig_type=std_logic lab=VREF}
C {devices/lab_wire.sym} 720 -650 0 0 {name=l17 sig_type=std_logic lab=SENSE_FET_KELVIN}
C {devices/lab_wire.sym} 1860 -1330 0 1 {name=l42 sig_type=std_logic lab=SENSE_FET_KELVIN}
