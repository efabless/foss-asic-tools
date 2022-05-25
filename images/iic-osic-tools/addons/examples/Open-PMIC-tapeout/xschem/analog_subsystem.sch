v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 20 -340 20 -320 { lab=VDD}
N 140 -340 140 -320 { lab=VSS}
N 260 -200 280 -200 { lab=BIAS_OPA_N}
N 260 -140 280 -140 { lab=BIAS_OPA_P}
N 260 -80 280 -80 { lab=BIAS_CMP}
N 660 -420 660 -400 { lab=VDD}
N 800 -420 800 -400 { lab=VSS}
N 820 -40 820 0 { lab=BIAS_OPA_P}
N 1500 -800 1500 -780 { lab=VSS}
N 1380 -800 1380 -780 { lab=VDD}
N 680 -800 680 -780 { lab=VDD}
N 800 -800 800 -780 { lab=VSS}
N 560 -540 580 -540 { lab=BIAS_OPA_N}
N 1660 -600 1680 -600 { lab=CYCLE_END}
N 1200 -540 1220 -540 { lab=TIMEOUT}
N 1200 -600 1220 -600 { lab=VCOMP}
N 1200 -660 1220 -660 { lab=ISENSE}
N 1580 -420 1580 -400 { lab=BIAS_CMP}
N 1300 -420 1300 -340 { lab=ISLOPE}
N 900 -640 920 -640 { lab=IMON}
N 900 -580 920 -580 { lab=ISENSE}
N -120 -140 -100 -140 { lab=IBIAS}
N 540 -260 560 -260 { lab=VREF}
N 540 -180 560 -180 { lab=VFB}
N 900 -220 920 -220 { lab=VCOMP}
N 560 -660 580 -660 { lab=SW_NODE}
N 1500 -420 1500 -380 { lab=BIAS_CMP2}
N 1380 -420 1380 -350 { lab=IOC}
N 1660 -560 1680 -560 { lab=OVERCURRENT}
N 260 -40 280 -40 { lab=BIAS_CMP2}
N 260 20 280 20 { lab=BIAS_SHIFT}
N 1440 -420 1440 -320 { lab=BIAS_SHIFT}
N 560 -580 580 -580 { lab=SENSE_FET}
N 560 -620 580 -620 { lab=SENSE_FET_KELVIN}
C {devices/iopin.sym} 0 -1000 0 0 {name=p11 lab=CYCLE_END
}
C {devices/iopin.sym} 0 -960 0 0 {name=p3 lab=IBIAS
}
C {devices/iopin.sym} 0 -940 0 0 {name=p12 lab=IMON
}
C {devices/iopin.sym} 0 -920 0 0 {name=p13 lab=IOC
}
C {devices/iopin.sym} 0 -900 0 0 {name=p6 lab=ISLOPE
}
C {devices/iopin.sym} 0 -880 0 0 {name=p14 lab=OVERCURRENT}
C {devices/iopin.sym} 0 -830 0 0 {name=p4 lab=SENSE_FET
}
C {devices/iopin.sym} 0 -810 0 0 {name=p15 lab=SENSE_FET_KELVIN
}
C {devices/iopin.sym} 0 -790 0 0 {name=p5 lab=SW_NODE
}
C {devices/iopin.sym} 0 -740 0 0 {name=p10 lab=TIMEOUT
}
C {devices/iopin.sym} 0 -690 0 0 {name=p9 lab=VCOMP
}
C {devices/iopin.sym} 0 -670 0 0 {name=p1 lab=VDD
}
C {devices/iopin.sym} 0 -650 0 0 {name=p8 lab=VFB
}
C {devices/iopin.sym} 0 -620 0 0 {name=p7 lab=VREF
}
C {devices/iopin.sym} 0 -600 0 0 {name=p2 lab=VSS
}
C {devices/lab_wire.sym} 280 -140 0 1 {name=l10 sig_type=std_logic lab=BIAS_OPA_P}
C {devices/lab_wire.sym} 280 -80 0 1 {name=l11 sig_type=std_logic lab=BIAS_CMP}
C {devices/lab_wire.sym} 560 -540 0 0 {name=l13 sig_type=std_logic lab=BIAS_OPA_N}
C {devices/lab_wire.sym} 1680 -600 0 1 {name=l14 sig_type=std_logic lab=CYCLE_END}
C {devices/lab_wire.sym} 920 -640 0 1 {name=l15 sig_type=std_logic lab=IMON}
C {devices/lab_wire.sym} 920 -580 0 1 {name=l16 sig_type=std_logic lab=ISENSE}
C {devices/lab_wire.sym} 1200 -660 0 0 {name=l17 sig_type=std_logic lab=ISENSE}
C {devices/lab_wire.sym} 1200 -600 0 0 {name=l18 sig_type=std_logic lab=VCOMP}
C {devices/lab_wire.sym} 1200 -540 0 0 {name=l19 sig_type=std_logic lab=TIMEOUT}
C {devices/lab_wire.sym} 1580 -400 0 1 {name=l20 sig_type=std_logic lab=BIAS_CMP}
C {devices/lab_wire.sym} 1300 -340 0 1 {name=l21 sig_type=std_logic lab=ISLOPE}
C {devices/lab_wire.sym} 280 -200 0 1 {name=l9 sig_type=std_logic lab=BIAS_OPA_N}
C {devices/lab_wire.sym} 680 -800 0 1 {name=l1 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 660 -420 0 1 {name=l3 sig_type=std_logic lab=VDD}
C {modulator.sym} 1440 -600 0 0 {name=x3}
C {devices/lab_wire.sym} 1500 -800 0 1 {name=l8 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 800 -800 0 1 {name=l7 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} 20 -340 0 1 {name=l5 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 540 -260 0 0 {name=l22 sig_type=std_logic lab=VREF}
C {devices/lab_wire.sym} 540 -180 0 0 {name=l23 sig_type=std_logic lab=VFB}
C {devices/lab_wire.sym} 800 -420 0 1 {name=l4 sig_type=std_logic lab=VSS}
C {devices/lab_wire.sym} -120 -140 0 0 {name=l24 sig_type=std_logic lab=IBIAS}
C {devices/lab_wire.sym} 920 -220 0 1 {name=l25 sig_type=std_logic lab=VCOMP}
C {devices/lab_wire.sym} 560 -660 0 0 {name=l26 sig_type=std_logic lab=SW_NODE}
C {devices/lab_wire.sym} 560 -580 0 0 {name=l27 sig_type=std_logic lab=SENSE_FET}
C {devices/lab_wire.sym} 140 -340 0 1 {name=l6 sig_type=std_logic lab=VSS}
C {folded_cascode_p_in.sym} 720 -220 0 0 {name=x1}
C {devices/lab_wire.sym} 820 0 0 1 {name=l12 sig_type=std_logic lab=BIAS_OPA_P}
C {devices/lab_wire.sym} 1500 -380 0 1 {name=l29 sig_type=std_logic lab=BIAS_CMP2}
C {devices/lab_wire.sym} 1380 -350 0 1 {name=l30 sig_type=std_logic lab=IOC}
C {current_sense.sym} 740 -600 0 0 {name=x2}
C {bias_distribution.sym} 80 -140 0 0 {name=x4}
C {devices/lab_wire.sym} 1680 -560 0 1 {name=l31 sig_type=std_logic lab=OVERCURRENT}
C {devices/lab_wire.sym} 280 -40 0 1 {name=l32 sig_type=std_logic lab=BIAS_CMP2}
C {devices/lab_wire.sym} 280 20 0 1 {name=l33 sig_type=std_logic lab=BIAS_SHIFT}
C {devices/lab_wire.sym} 1440 -320 0 1 {name=l34 sig_type=std_logic lab=BIAS_SHIFT}
C {devices/lab_wire.sym} 1380 -800 0 1 {name=l2 sig_type=std_logic lab=VDD}
C {devices/lab_wire.sym} 560 -620 0 0 {name=l35 sig_type=std_logic lab=SENSE_FET_KELVIN}
