v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {slope = ri * Vin / L 
ri = 1.69} 20 -190 0 0 0.4 0.4 {}
T {source for current sensing} 2140 -750 0 0 0.4 0.4 {}
T {I/O Pad Emulation} 260 -1590 0 0 0.4 0.4 {}
T {simplified model for coilcraft LPS6235-223} 2400 -560 0 0 0.4 0.4 {}
T {switch node capacitance} 1930 -430 0 0 0.4 0.4 {}
T {source for current sensing} 2540 -80 0 0 0.4 0.4 {}
T {external compensation components} 980 -70 0 0 0.4 0.4 {}
T {Digital inputs from IO} -80 -810 0 0 0.4 0.4 {}
T {supply rails} 2000 -1670 0 0 0.4 0.4 {}
T {monitoring for current sense} 1190 -1560 0 0 0.4 0.4 {}
T {external bias power supplies} 340 200 0 0 0.4 0.4 {}
T {on die capacitance?} 2290 -1390 0 0 0.4 0.4 {}
T {on die capacitance?} 2280 -1040 0 0 0.4 0.4 {}
N 560 -150 560 -130 { lab=GND}
N 560 -230 560 -210 { lab=#net1}
N 1790 -1200 1790 -1180 { lab=#net2}
N 1790 -1120 1790 -1100 { lab=GND}
N 340 40 340 60 { lab=#net3}
N 340 120 340 140 { lab=GND}
N 820 -160 820 -140 { lab=GND}
N 820 -240 820 -220 { lab=#net4}
N 1200 -720 1210 -720 { lab=V3V3}
N 1210 -720 1220 -720 { lab=V3V3}
N 1200 -680 1220 -680 { lab=VDD_PWR}
N 1200 -640 1220 -640 { lab=VSS}
N 2240 -620 2240 -600 { lab=#net5}
N 2240 -380 2340 -380 { lab=VOUT}
N 2240 -400 2240 -380 { lab=VOUT}
N 2340 -90 2340 -70 { lab=GND}
N 2340 -380 2340 -340 { lab=VOUT}
N 2660 -190 2660 -170 { lab=GND}
N 2340 -380 2460 -380 { lab=VOUT}
N 2660 -280 2660 -250 { lab=#net6}
N 2460 -380 2460 -370 { lab=VOUT}
N 2080 -780 2080 -760 { lab=SW_NODE}
N 2080 -700 2080 -640 { lab=#net7}
N 2080 -640 2140 -640 { lab=#net7}
N 2460 -280 2460 -240 { lab=VFB}
N 2460 -180 2460 -160 { lab=GND}
N 2460 -380 2580 -380 { lab=VOUT}
N 2460 -260 2480 -260 { lab=VFB}
N 1200 -540 1220 -540 { lab=VREF}
N 1200 -500 1220 -500 { lab=VFB}
N 1060 -160 1060 -120 { lab=GND}
N 1060 -240 1060 -220 { lab=#net8}
N 1200 -460 1220 -460 { lab=VCOMP}
N 1200 -380 1220 -380 { lab=ISLOPE}
N 1200 -420 1220 -420 { lab=IBIAS}
N 1300 -1410 1300 -1390 { lab=#net9}
N 1300 -1330 1300 -1310 { lab=GND}
N 1200 -340 1220 -340 { lab=IMON}
N 300 -150 300 -130 { lab=GND}
N 300 -230 300 -210 { lab=#net10}
N 1200 -300 1220 -300 { lab=IOSC}
N -140 -640 -140 -620 { lab=VSS}
N -140 -720 -140 -700 { lab=TIMEOUT_EXT}
N -140 -740 -120 -740 { lab=TIMEOUT_EXT}
N -140 -740 -140 -720 { lab=TIMEOUT_EXT}
N 1780 -680 1800 -680 { lab=TIMEOUT_EXT}
N 1780 -720 1800 -720 { lab=SW_EN}
N 1780 -580 1800 -580 { lab=VSS}
N 1780 -540 1800 -540 { lab=VSS}
N 1780 -500 1800 -500 { lab=VSS}
N 1780 -460 1800 -460 { lab=VSS}
N 1780 -420 1800 -420 { lab=VSS}
N 1780 -380 1800 -380 { lab=VSS}
N -140 -900 -140 -880 { lab=SW_EN}
N -140 -820 -140 -800 { lab=VSS}
N 780 -940 820 -940 { lab=VREF_EXT}
N 780 -940 780 -920 { lab=VREF_EXT}
N 780 -860 780 -840 { lab=VSS}
N 760 -840 780 -840 { lab=VSS}
N 880 -940 900 -940 { lab=VREF}
N 740 -940 780 -940 { lab=VREF_EXT}
N 380 -940 420 -940 { lab=IBIAS_EXT}
N 380 -940 380 -920 { lab=IBIAS_EXT}
N 380 -860 380 -840 { lab=VSS}
N 360 -840 380 -840 { lab=VSS}
N 480 -940 500 -940 { lab=IBIAS}
N 340 -940 380 -940 { lab=IBIAS_EXT}
N 760 -1140 800 -1140 { lab=VFB_EXT}
N 760 -1140 760 -1120 { lab=VFB_EXT}
N 760 -1060 760 -1040 { lab=VSS}
N 740 -1040 760 -1040 { lab=VSS}
N 860 -1140 880 -1140 { lab=VFB}
N 720 -1140 760 -1140 { lab=VFB_EXT}
N 380 -1140 420 -1140 { lab=VCOMP_EXT}
N 380 -1140 380 -1120 { lab=VCOMP_EXT}
N 380 -1060 380 -1040 { lab=VSS}
N 360 -1040 380 -1040 { lab=VSS}
N 480 -1140 500 -1140 { lab=VCOMP}
N 340 -1140 380 -1140 { lab=VCOMP_EXT}
N 800 -1360 840 -1360 { lab=ISLOPE_EXT}
N 800 -1360 800 -1340 { lab=ISLOPE_EXT}
N 800 -1280 800 -1260 { lab=VSS}
N 780 -1260 800 -1260 { lab=VSS}
N 900 -1360 920 -1360 { lab=ISLOPE}
N 760 -1360 800 -1360 { lab=ISLOPE_EXT}
N 400 -1360 440 -1360 { lab=IOSC_EXT}
N 400 -1360 400 -1340 { lab=IOSC_EXT}
N 400 -1280 400 -1260 { lab=VSS}
N 380 -1260 400 -1260 { lab=VSS}
N 500 -1360 520 -1360 { lab=IOSC}
N 360 -1360 400 -1360 { lab=IOSC_EXT}
N 780 -1560 820 -1560 { lab=IMON_EXT}
N 780 -1560 780 -1540 { lab=IMON_EXT}
N 780 -1480 780 -1460 { lab=VSS}
N 760 -1460 780 -1460 { lab=VSS}
N 880 -1560 900 -1560 { lab=IMON}
N 740 -1560 780 -1560 { lab=IMON_EXT}
N 340 -40 340 -20 { lab=VREF_EXT}
N 1300 -1490 1300 -1470 { lab=IMON_EXT}
N 300 -310 300 -290 { lab=IOSC_EXT}
N 560 -310 560 -290 { lab=IBIAS_EXT}
N 820 -320 820 -300 { lab=ISLOPE_EXT}
N 1060 -320 1060 -300 { lab=VCOMP_EXT}
N 1890 -1220 1910 -1220 { lab=VDD_PWR_PRE}
N 1790 -1220 1830 -1220 { lab=#net2}
N 1790 -1220 1790 -1200 { lab=#net2}
N 1200 -640 1200 -610 { lab=VSS}
N 1120 -640 1200 -640 { lab=VSS}
N 1040 -640 1060 -640 { lab=#net11}
N 1040 -540 1040 -520 { lab=GND}
N 820 -230 890 -230 { lab=#net4}
N 890 -230 890 -220 { lab=#net4}
N 890 -160 890 -140 { lab=GND}
N 640 -220 640 -210 { lab=#net1}
N 640 -150 640 -130 { lab=GND}
N 380 -220 380 -210 { lab=#net10}
N 380 -150 380 -130 { lab=GND}
N 300 -220 380 -220 { lab=#net10}
N 560 -220 640 -220 { lab=#net1}
N 2460 -420 2460 -380 { lab=VOUT}
N 2340 -580 2340 -560 { lab=#net12}
N 2200 -640 2240 -640 { lab=#net5}
N 2240 -640 2240 -620 { lab=#net5}
N 2240 -640 2340 -640 { lab=#net5}
N 2340 -500 2340 -480 { lab=VOUT}
N 2240 -480 2340 -480 { lab=VOUT}
N 2240 -540 2240 -480 { lab=VOUT}
N 2080 -480 2080 -460 { lab=GND}
N 2080 -640 2080 -600 { lab=#net7}
N 2240 -480 2240 -400 { lab=VOUT}
N 2340 -250 2340 -230 { lab=#net13}
N 2340 -170 2340 -150 { lab=#net14}
N 2340 -340 2340 -310 { lab=VOUT}
N 2100 -970 2100 -950 { lab=GND}
N 2100 -1130 2100 -1110 { lab=#net15}
N 2100 -1050 2100 -1030 { lab=#net16}
N 2100 -1220 2100 -1190 { lab=VDD_PWR_PRE}
N 2100 -1220 2140 -1220 { lab=VDD_PWR_PRE}
N 2200 -1220 2240 -1220 { lab=VDD_PWR}
N 1800 -1300 1840 -1300 { lab=#net2}
N 1800 -1300 1800 -1220 { lab=#net2}
N 1900 -1300 1940 -1300 { lab=VDD_PWR_PRE}
N 1940 -1300 1940 -1220 { lab=VDD_PWR_PRE}
N 1910 -1220 1940 -1220 { lab=VDD_PWR_PRE}
N 1940 -1220 2100 -1220 { lab=VDD_PWR_PRE}
N 1800 -1540 1800 -1520 { lab=#net17}
N 1800 -1460 1800 -1440 { lab=GND}
N 1900 -1560 1920 -1560 { lab=V3V3_PRE}
N 1800 -1560 1840 -1560 { lab=#net17}
N 1800 -1560 1800 -1540 { lab=#net17}
N 2110 -1310 2110 -1290 { lab=GND}
N 2110 -1470 2110 -1450 { lab=#net18}
N 2110 -1390 2110 -1370 { lab=#net19}
N 2110 -1560 2110 -1530 { lab=V3V3_PRE}
N 2110 -1560 2150 -1560 { lab=V3V3_PRE}
N 2210 -1560 2250 -1560 { lab=V3V3}
N 1810 -1640 1850 -1640 { lab=#net17}
N 1810 -1640 1810 -1560 { lab=#net17}
N 1910 -1640 1950 -1640 { lab=V3V3_PRE}
N 1950 -1640 1950 -1560 { lab=V3V3_PRE}
N 1920 -1560 1950 -1560 { lab=V3V3_PRE}
N 1950 -1560 2110 -1560 { lab=V3V3_PRE}
N 2580 -380 2740 -380 { lab=VOUT}
N 2460 -370 2460 -340 { lab=VOUT}
N 2660 -300 2660 -280 { lab=#net6}
N 2660 -380 2660 -360 { lab=VOUT}
N 1780 -260 1800 -260 { lab=SW_NODE}
N 1780 -340 1800 -340 { lab=SW_EN}
N 560 120 560 140 { lab=GND}
N 560 40 560 60 { lab=#net20}
N 560 -40 560 -20 { lab=IOC}
N 640 50 640 60 { lab=#net20}
N 640 120 640 140 { lab=GND}
N 560 50 640 50 { lab=#net20}
N 1200 -260 1220 -260 { lab=IOC}
N 1800 -380 1820 -380 { lab=VSS}
N 1800 -580 1800 -380 { lab=VSS}
N 1040 -640 1040 -600 { lab=#net11}
N 2740 -380 2760 -380 { lab=VOUT}
N 2820 -380 2880 -380 { lab=VOUT_FILT}
N 2880 -280 2880 -240 { lab=GND}
N 2880 -380 2880 -340 { lab=VOUT_FILT}
N 2880 -380 2900 -380 { lab=VOUT_FILT}
N 2000 -970 2000 -950 { lab=GND}
N 2000 -1130 2000 -1110 { lab=#net21}
N 2000 -1050 2000 -1030 { lab=#net22}
N 2000 -1220 2000 -1190 { lab=VDD_PWR_PRE}
N 2010 -1310 2010 -1290 { lab=GND}
N 2010 -1470 2010 -1450 { lab=#net23}
N 2010 -1390 2010 -1370 { lab=#net24}
N 2010 -1560 2010 -1530 { lab=V3V3_PRE}
N 2260 -1380 2260 -1360 { lab=GND}
N 2260 -1460 2260 -1440 { lab=#net25}
N 2260 -1560 2260 -1520 { lab=V3V3}
N 2250 -1560 2260 -1560 { lab=V3V3}
N 2260 -1560 2280 -1560 { lab=V3V3}
N 2220 -1010 2220 -990 { lab=GND}
N 2220 -1090 2220 -1070 { lab=#net26}
N 2220 -1220 2220 -1160 { lab=VDD_PWR}
N 2220 -1160 2220 -1150 { lab=VDD_PWR}
C {devices/code_shown.sym} 198.75 -701.875 0 0 {name=NGSPICE
only_toplevel=true
value="

.param VIN = 3.3
.param RL = 20
.option temp=70

.control
save all
tran 10n 300u
write full_system_tb.raw
.endc
.measure tran Iin_avg AVG i(V5) from=400u to=600u
.measure tran Iaux_avg AVG i(V8) from=400u to=600u
.measure tran Iload_avg RMS i(V1) from=400u to=600u
.measure tran Vout_max MAX v(vout_filt) from=400u to=600u
.measure tran Vout_min MIN v(vout_filt) from=400u to=600u
.measure tran vout_tran_max MAX v(vout_filt) from=0u to=600u
.measure tran Il_max MAX i(V4) from=0u to=600u
.measure tran Il_min MIN i(V4) from=0u to=600u
"}
C {devices/code.sym} -290 -440 0 0 {name=STDCELL_MODELS 
only_toplevel=true
place=end
format="tcleval(@value )"
value="[sky130_models]"
}
C {devices/code.sym} -290 -270 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib \\\\$::SKYWATER_MODELS\\\\/models/sky130.lib.spice ss
.option wnflag=1
"
}
C {devices/isource.sym} 560 -180 2 0 {name=I0 value=100u
}
C {devices/gnd.sym} 560 -130 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 560 -310 0 0 {name=l4 sig_type=std_logic lab=IBIAS_EXT
}
C {devices/vsource.sym} 1790 -1150 0 0 {name=V5 value=\{VIN\}}
C {devices/gnd.sym} 1790 -1100 0 0 {name=l42 lab=GND}
C {devices/lab_pin.sym} 2240 -1220 0 1 {name=l43 sig_type=std_logic lab=VDD_PWR
}
C {devices/vsource.sym} 340 90 0 0 {name=V6 value=1.25}
C {devices/gnd.sym} 340 140 0 0 {name=l54 lab=GND}
C {devices/lab_pin.sym} 340 -40 0 0 {name=l55 sig_type=std_logic lab=VREF_EXT
}
C {devices/isource.sym} 820 -190 2 0 {name=I4 value=80u
}
C {devices/gnd.sym} 820 -140 0 0 {name=l78 lab=GND}
C {devices/lab_pin.sym} 820 -320 0 0 {name=l79 sig_type=std_logic lab=ISLOPE_EXT
}
C {design/system/full_system.sym} 1500 -460 0 0 {name=x1}
C {devices/lab_pin.sym} 1200 -720 0 0 {name=l9 sig_type=std_logic lab=V3V3
}
C {devices/lab_pin.sym} 1200 -680 0 0 {name=l10 sig_type=std_logic lab=VDD_PWR
}
C {devices/lab_pin.sym} 1200 -540 0 0 {name=l12 sig_type=std_logic lab=VREF
}
C {devices/ind.sym} 2240 -570 0 0 {name=L1
m=1
value=22u
footprint=1206
device=inductor}
C {devices/res.sym} 2170 -640 3 0 {name=R3
value=0.145
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 2340 -530 0 0 {name=C2
m=1
value=3.32p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 2340 -120 0 0 {name=C3
m=1
value=47u
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2340 -70 0 0 {name=l35 lab=GND}
C {devices/res.sym} 2660 -220 2 0 {name=R4
value=\{RL\}
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 2660 -170 0 0 {name=l39 lab=GND}
C {devices/lab_pin.sym} 2080 -780 2 0 {name=l20 sig_type=std_logic lab=SW_NODE
}
C {devices/vsource.sym} 2080 -730 0 0 {name=V4 value=0}
C {devices/res.sym} 2460 -310 2 0 {name=R2
value=17.6k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 2460 -420 2 0 {name=l57 sig_type=std_logic lab=VOUT
}
C {devices/res.sym} 2460 -210 2 0 {name=R5
value=40k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 2460 -160 0 0 {name=l58 lab=GND}
C {devices/lab_pin.sym} 2480 -260 2 0 {name=l59 sig_type=std_logic lab=VFB
}
C {devices/lab_pin.sym} 1800 -260 2 0 {name=l13 sig_type=std_logic lab=SW_NODE
}
C {devices/lab_pin.sym} 1200 -500 2 1 {name=l14 sig_type=std_logic lab=VFB
}
C {devices/capa.sym} 1060 -190 0 0 {name=C5
m=1
value=5n
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1060 -120 0 0 {name=l61 lab=GND}
C {devices/lab_pin.sym} 1200 -460 2 1 {name=l15 sig_type=std_logic lab=VCOMP
}
C {devices/lab_pin.sym} 1060 -320 2 1 {name=l16 sig_type=std_logic lab=VCOMP_EXT
}
C {devices/lab_pin.sym} 1200 -380 0 0 {name=l5 sig_type=std_logic lab=ISLOPE
}
C {devices/lab_pin.sym} 1200 -420 0 0 {name=l6 sig_type=std_logic lab=IBIAS
}
C {devices/vsource.sym} 1300 -1360 0 0 {name=V2 value=\{VIN\}}
C {devices/gnd.sym} 1300 -1310 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 1300 -1490 0 0 {name=l8 sig_type=std_logic lab=IMON_EXT
}
C {devices/lab_pin.sym} 1200 -340 0 0 {name=l17 sig_type=std_logic lab=IMON
}
C {devices/isource.sym} 300 -180 2 0 {name=I1 value=20u
}
C {devices/gnd.sym} 300 -130 0 0 {name=l18 lab=GND}
C {devices/lab_pin.sym} 300 -310 0 0 {name=l19 sig_type=std_logic lab=IOSC_EXT
}
C {devices/lab_pin.sym} 1200 -300 0 0 {name=l21 sig_type=std_logic lab=IOSC
}
C {devices/vsource.sym} -140 -670 0 0 {name=V7 value="PULSE(0 \{VIN\} 0 3n 3n 200n 2u)"}
C {devices/lab_pin.sym} -120 -740 0 1 {name=l23 sig_type=std_logic lab=TIMEOUT_EXT
}
C {devices/lab_pin.sym} 1800 -680 0 1 {name=l24 sig_type=std_logic lab=TIMEOUT_EXT
}
C {devices/lab_pin.sym} 1200 -610 0 0 {name=l27 sig_type=std_logic lab=VSS
}
C {devices/lab_pin.sym} 1820 -380 0 1 {name=l28 sig_type=std_logic lab=VSS
}
C {devices/vsource.sym} -140 -850 0 0 {name=V3 value=\{VIN\}}
C {devices/lab_pin.sym} -140 -900 0 0 {name=l29 sig_type=std_logic lab=SW_EN
}
C {devices/lab_pin.sym} 1800 -720 0 1 {name=l30 sig_type=std_logic lab=SW_EN
}
C {devices/lab_pin.sym} -140 -800 0 0 {name=l22 sig_type=std_logic lab=VSS
}
C {devices/lab_pin.sym} -140 -620 0 0 {name=l25 sig_type=std_logic lab=VSS
}
C {devices/lab_pin.sym} 900 -940 0 1 {name=l26 sig_type=std_logic lab=VREF
}
C {devices/lab_pin.sym} 880 -1140 2 0 {name=l31 sig_type=std_logic lab=VFB
}
C {devices/lab_pin.sym} 500 -1140 2 0 {name=l32 sig_type=std_logic lab=VCOMP
}
C {devices/lab_pin.sym} 920 -1360 0 1 {name=l33 sig_type=std_logic lab=ISLOPE
}
C {devices/lab_pin.sym} 500 -940 0 1 {name=l34 sig_type=std_logic lab=IBIAS
}
C {devices/lab_pin.sym} 900 -1560 0 1 {name=l36 sig_type=std_logic lab=IMON
}
C {devices/lab_pin.sym} 520 -1360 0 1 {name=l37 sig_type=std_logic lab=IOSC
}
C {devices/res.sym} 850 -940 1 0 {name=R1
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 780 -890 0 0 {name=C1
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 760 -840 0 0 {name=l38 sig_type=std_logic lab=VSS
}
C {devices/lab_pin.sym} 740 -940 0 0 {name=l40 sig_type=std_logic lab=VREF_EXT
}
C {devices/res.sym} 450 -940 1 0 {name=R6
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 380 -890 0 0 {name=C4
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 360 -840 0 0 {name=l44 sig_type=std_logic lab=VSS
}
C {devices/res.sym} 830 -1140 1 0 {name=R7
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 760 -1090 0 0 {name=C6
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 740 -1040 0 0 {name=l47 sig_type=std_logic lab=VSS
}
C {devices/res.sym} 450 -1140 1 0 {name=R8
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 380 -1090 0 0 {name=C7
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 360 -1040 0 0 {name=l50 sig_type=std_logic lab=VSS
}
C {devices/res.sym} 870 -1360 1 0 {name=R9
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 800 -1310 0 0 {name=C8
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 780 -1260 0 0 {name=l49 sig_type=std_logic lab=VSS
}
C {devices/lab_pin.sym} 760 -1360 0 0 {name=l51 sig_type=std_logic lab=ISLOPE_EXT
}
C {devices/res.sym} 470 -1360 1 0 {name=R10
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 400 -1310 0 0 {name=C9
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 380 -1260 0 0 {name=l52 sig_type=std_logic lab=VSS
}
C {devices/res.sym} 850 -1560 1 0 {name=R11
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 780 -1510 0 0 {name=C10
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_pin.sym} 760 -1460 0 0 {name=l53 sig_type=std_logic lab=VSS
}
C {devices/lab_pin.sym} 360 -1360 0 0 {name=l41 sig_type=std_logic lab=IOSC_EXT
}
C {devices/lab_pin.sym} 340 -1140 2 1 {name=l45 sig_type=std_logic lab=VCOMP_EXT
}
C {devices/lab_pin.sym} 340 -940 0 0 {name=l46 sig_type=std_logic lab=IBIAS_EXT
}
C {devices/lab_pin.sym} 720 -1140 2 1 {name=l48 sig_type=std_logic lab=VFB_EXT
}
C {devices/lab_pin.sym} 740 -1560 0 0 {name=l56 sig_type=std_logic lab=IMON_EXT

}
C {devices/res.sym} 340 10 0 1 {name=R12
value=120
footprint=10
device=resistor
m=1}
C {devices/res.sym} 1300 -1440 0 1 {name=R13
value=120
footprint=10
device=resistor
m=1}
C {devices/res.sym} 300 -260 0 1 {name=R14
value=10
footprint=10
device=resistor
m=1}
C {devices/res.sym} 560 -260 0 1 {name=R15
value=10
footprint=10
device=resistor
m=1}
C {devices/res.sym} 820 -270 0 1 {name=R16
value=10
footprint=10
device=resistor
m=1}
C {devices/res.sym} 1060 -270 0 1 {name=R17
value=7.8E3
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1860 -1220 1 0 {name=L2
m=1
value=100n
footprint=1206
device=inductor}
C {devices/ind.sym} 1090 -640 1 0 {name=L4
m=1
value=1n
footprint=1206
device=inductor}
C {devices/gnd.sym} 1040 -520 0 0 {name=l11 lab=GND}
C {devices/capa.sym} 890 -190 0 0 {name=C11
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 890 -140 0 0 {name=l60 lab=GND}
C {devices/capa.sym} 640 -180 0 0 {name=C12
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 640 -130 0 0 {name=l62 lab=GND}
C {devices/capa.sym} 380 -180 0 0 {name=C13
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 380 -130 0 0 {name=l63 lab=GND}
C {devices/res.sym} 2340 -610 0 0 {name=R18
value=45
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 2080 -510 0 0 {name=C14
m=1
value=15p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2080 -460 0 0 {name=l64 lab=GND}
C {devices/res.sym} 2080 -570 0 0 {name=R19
value=1
footprint=1206
device=resistor
m=1}
C {devices/ind.sym} 2340 -200 0 0 {name=L5
m=1
value=5n
footprint=1206
device=inductor}
C {devices/res.sym} 2340 -280 0 0 {name=R20
value=10m
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 2100 -1000 0 0 {name=C15
m=1
value=47u
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2100 -950 0 0 {name=l65 lab=GND}
C {devices/ind.sym} 2100 -1080 0 0 {name=L6
m=1
value=1n
footprint=1206
device=inductor}
C {devices/res.sym} 2100 -1160 0 0 {name=R21
value=10m
footprint=1206
device=resistor
m=1}
C {devices/ind.sym} 2170 -1220 1 0 {name=L7
m=1
value=1n
footprint=1206
device=inductor}
C {devices/res.sym} 1870 -1300 3 0 {name=R22
value=5
footprint=1206
device=resistor
m=1}
C {devices/vsource.sym} 1800 -1490 0 0 {name=V8 value=\{VIN\}}
C {devices/gnd.sym} 1800 -1440 0 0 {name=l66 lab=GND}
C {devices/ind.sym} 1870 -1560 1 0 {name=L8
m=1
value=100n
footprint=1206
device=inductor}
C {devices/capa.sym} 2110 -1340 0 0 {name=C16
m=1
value=47u
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2110 -1290 0 0 {name=l68 lab=GND}
C {devices/ind.sym} 2110 -1420 0 0 {name=L9
m=1
value=5n
footprint=1206
device=inductor}
C {devices/res.sym} 2110 -1500 0 0 {name=R23
value=10m
footprint=1206
device=resistor
m=1}
C {devices/ind.sym} 2180 -1560 1 0 {name=L10
m=1
value=5n
footprint=1206
device=inductor}
C {devices/res.sym} 1880 -1640 3 0 {name=R24
value=5
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 2280 -1560 0 1 {name=l67 sig_type=std_logic lab=V3V3
}
C {devices/vsource.sym} 2660 -330 0 0 {name=V1 value=0}
C {devices/lab_wire.sym} 1990 -1560 0 1 {name=l2 sig_type=std_logic lab=V3V3_PRE}
C {devices/lab_wire.sym} 1980 -1220 0 1 {name=l3 sig_type=std_logic lab=VDD_PWR_PRE}
C {devices/isource.sym} 560 90 2 0 {name=I2 value=100u
}
C {devices/gnd.sym} 560 140 0 0 {name=l69 lab=GND}
C {devices/lab_pin.sym} 560 -40 0 0 {name=l70 sig_type=std_logic lab=IOC
}
C {devices/res.sym} 560 10 0 1 {name=R25
value=10
footprint=10
device=resistor
m=1}
C {devices/capa.sym} 640 90 0 0 {name=C17
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 640 140 0 0 {name=l71 lab=GND}
C {devices/lab_pin.sym} 1200 -260 0 0 {name=l72 sig_type=std_logic lab=IOC
}
C {devices/lab_pin.sym} 1800 -340 0 1 {name=l73 sig_type=std_logic lab=SW_EN
}
C {devices/res.sym} 1040 -570 0 0 {name=R26
value=30m
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 2790 -380 3 0 {name=R27
value=10k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 2880 -310 0 0 {name=C18
m=1
value=200p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2880 -240 0 0 {name=l74 lab=GND}
C {devices/lab_pin.sym} 2900 -380 2 0 {name=l75 sig_type=std_logic lab=VOUT_FILT}
C {devices/capa.sym} 2000 -1000 0 0 {name=C19
m=1
value=200u
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2000 -950 0 0 {name=l76 lab=GND}
C {devices/ind.sym} 2000 -1080 0 0 {name=L3
m=1
value=20n
footprint=1206
device=inductor}
C {devices/res.sym} 2000 -1160 0 0 {name=R28
value=40m
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 2010 -1340 0 0 {name=C20
m=1
value=200u
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 2010 -1290 0 0 {name=l77 lab=GND}
C {devices/ind.sym} 2010 -1420 0 0 {name=L11
m=1
value=20n
footprint=1206
device=inductor}
C {devices/res.sym} 2010 -1500 0 0 {name=R29
value=40m
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 2260 -1410 0 0 {name=C21
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/res.sym} 2260 -1490 0 0 {name=R30
value=10m
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 2260 -1360 0 0 {name=l80 lab=GND}
C {devices/capa.sym} 2220 -1040 0 0 {name=C22
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/res.sym} 2220 -1120 0 0 {name=R31
value=10m
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 2220 -990 0 0 {name=l81 lab=GND}
