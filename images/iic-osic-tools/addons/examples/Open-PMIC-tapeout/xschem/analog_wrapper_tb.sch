v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {slope = ri * Vin / L 
ri = 1.69} -840 -850 0 0 0.4 0.4 {}
T {external bias power supplies} -520 -460 0 0 0.4 0.4 {}
T {I/O Pad Emulation} -1040 -2510 0 0 0.4 0.4 {}
T {supply rail parasitics modeling} 580 -1570 0 0 0.4 0.4 {}
T {source for current sensing} 1220 -950 0 0 0.4 0.4 {}
T {simplified model for coilcraft LPS6235-223} 1480 -760 0 0 0.4 0.4 {}
T {source for current sensing} 1620 -280 0 0 0.4 0.4 {}
N -300 -810 -300 -790 { lab=GND}
N -300 -890 -300 -870 { lab=#net1}
N -520 -620 -520 -600 { lab=#net2}
N -520 -540 -520 -520 { lab=GND}
N -40 -820 -40 -800 { lab=GND}
N -40 -900 -40 -880 { lab=#net3}
N 200 -820 200 -780 { lab=GND}
N 200 -900 200 -880 { lab=#net4}
N -560 -810 -560 -790 { lab=GND}
N -560 -890 -560 -870 { lab=#net5}
N -520 -700 -520 -680 { lab=vref}
N -560 -970 -560 -950 { lab=iosc}
N -300 -970 -300 -950 { lab=ibias}
N -40 -980 -40 -960 { lab=islope}
N 200 -980 200 -960 { lab=vcomp}
N -40 -890 30 -890 { lab=#net3}
N 30 -890 30 -880 { lab=#net3}
N 30 -820 30 -800 { lab=GND}
N -220 -880 -220 -870 { lab=#net1}
N -220 -810 -220 -790 { lab=GND}
N -480 -880 -480 -870 { lab=#net5}
N -480 -810 -480 -790 { lab=GND}
N -560 -880 -480 -880 { lab=#net5}
N -300 -880 -220 -880 { lab=#net1}
N -300 -540 -300 -520 { lab=GND}
N -300 -620 -300 -600 { lab=#net6}
N -300 -700 -300 -680 { lab=ioc}
N -220 -610 -220 -600 { lab=#net6}
N -220 -540 -220 -520 { lab=GND}
N -300 -610 -220 -610 { lab=#net6}
N -520 -2480 -480 -2480 { lab=ibias}
N -520 -2480 -520 -2460 { lab=ibias}
N -420 -2480 -400 -2480 { lab=gpio_analog[17]}
N -560 -2480 -520 -2480 { lab=ibias}
N 280 -20 300 -20 { lab=gpio_analog[17:0]}
N 280 20 300 20 { lab=io_analog[10:0]}
N 280 40 300 40 { lab=io_clamp_high[2:0]}
N 280 60 300 60 { lab=io_clamp_low[2:0]}
N 280 -280 300 -280 { lab=vdda1}
N 280 -260 300 -260 { lab=vdda2}
N 280 -240 300 -240 { lab=vssa1}
N 280 -220 300 -220 { lab=vssa2}
N 280 -200 300 -200 { lab=vccd1}
N 280 -180 300 -180 { lab=vccd2}
N 280 -160 300 -160 { lab=vssd1}
N 280 -140 300 -140 { lab=vssd2}
N 1200 -1460 1200 -1420 { lab=vssa1}
N 1160 -1420 1200 -1420 { lab=vssa1}
N 1160 -1680 1200 -1680 { lab=vdda1}
N 1080 -1680 1100 -1680 { lab=#net7}
N 1080 -1420 1100 -1420 { lab=#net8}
N 980 -1420 1020 -1420 { lab=GND}
N 980 -1420 980 -1400 { lab=GND}
N 980 -1680 1020 -1680 { lab=#net9}
N 1200 -1680 1220 -1680 { lab=vdda1}
N 1200 -1420 1220 -1420 { lab=vssa1}
N 980 -1560 980 -1520 { lab=#net9}
N 980 -1460 980 -1420 { lab=GND}
N 1160 -1880 1160 -1840 { lab=vssa2}
N 1120 -1840 1160 -1840 { lab=vssa2}
N 1120 -2100 1160 -2100 { lab=vdda2}
N 1160 -1980 1160 -1940 { lab=#net10}
N 1040 -2100 1060 -2100 { lab=#net11}
N 1040 -1840 1060 -1840 { lab=#net12}
N 940 -1840 980 -1840 { lab=GND}
N 940 -1840 940 -1820 { lab=GND}
N 940 -2100 980 -2100 { lab=#net13}
N 1160 -2100 1180 -2100 { lab=vdda2}
N 1160 -1840 1180 -1840 { lab=vssa2}
N 940 -2100 940 -2060 { lab=#net13}
N 940 -1880 940 -1840 { lab=GND}
N 1160 -2260 1160 -2220 { lab=vssd1}
N 1120 -2220 1160 -2220 { lab=vssd1}
N 1120 -2480 1160 -2480 { lab=vccd1}
N 1160 -2480 1160 -2440 { lab=vccd1}
N 1040 -2480 1060 -2480 { lab=#net14}
N 1040 -2220 1060 -2220 { lab=#net15}
N 940 -2220 980 -2220 { lab=GND}
N 940 -2220 940 -2200 { lab=GND}
N 940 -2480 980 -2480 { lab=#net16}
N 1160 -2480 1180 -2480 { lab=vccd1}
N 1160 -2220 1180 -2220 { lab=vssd1}
N 940 -2480 940 -2440 { lab=#net16}
N 940 -2260 940 -2220 { lab=GND}
N 1160 -2620 1160 -2580 { lab=vssd2}
N 1120 -2580 1160 -2580 { lab=vssd2}
N 1120 -2820 1160 -2820 { lab=vccd2}
N 1160 -2820 1160 -2780 { lab=vccd2}
N 1040 -2820 1060 -2820 { lab=#net17}
N 1040 -2580 1060 -2580 { lab=#net18}
N 940 -2580 980 -2580 { lab=GND}
N 940 -2580 940 -2560 { lab=GND}
N 940 -2820 980 -2820 { lab=#net19}
N 1160 -2820 1180 -2820 { lab=vccd2}
N 1160 -2580 1180 -2580 { lab=vssd2}
N 940 -2720 940 -2680 { lab=#net19}
N 940 -2620 940 -2580 { lab=GND}
N 1590 -1460 1590 -1420 { lab=io_analog[10:8]}
N 1550 -1420 1590 -1420 { lab=io_analog[10:8]}
N 1550 -1660 1590 -1660 { lab=io_analog[6:4]}
N 1590 -1660 1590 -1620 { lab=io_analog[6:4]}
N 1470 -1660 1490 -1660 { lab=#net20}
N 1470 -1420 1490 -1420 { lab=#net21}
N 1370 -1420 1410 -1420 { lab=GND}
N 1370 -1420 1370 -1400 { lab=GND}
N 1370 -1660 1410 -1660 { lab=#net22}
N 1590 -1660 1610 -1660 { lab=io_analog[6:4]}
N 1590 -1420 1610 -1420 { lab=io_analog[10:8]}
N 1370 -1560 1370 -1520 { lab=#net22}
N 1370 -1460 1370 -1420 { lab=GND}
N 1590 -1420 1590 -1380 { lab=io_analog[10:8]}
N 1590 -1380 1620 -1380 { lab=io_analog[0]}
N 1590 -1380 1590 -1340 { lab=io_analog[10:8]}
N 1590 -1340 1600 -1340 { lab=io_analog[10:8]}
N 1600 -1340 1620 -1340 { lab=io_clamp_low[2:0]}
N 1610 -1420 1620 -1420 { lab=io_analog[10:8]}
N 1590 -1700 1590 -1670 { lab=io_analog[6:4]}
N 1590 -1700 1610 -1700 { lab=io_clamp_high[2:0]}
N 1590 -1670 1590 -1660 { lab=io_analog[6:4]}
N 280 -120 300 -120 { lab=wbs_ack_o}
N 280 -100 300 -100 { lab=wbs_dat_o[31:0]}
N 280 -80 300 -80 { lab=la_data_out[127:0]}
N 280 -60 300 -60 { lab=io_out[26:0]}
N 280 -40 300 -40 { lab=io_oeb[26:0]}
N -40 -80 -20 -80 { lab=io_in[26:0]}
N -40 -60 -20 -60 { lab=io_in3v3[26:0]}
N -40 -40 -20 -40 { lab=user_clock2}
N -40 -120 -20 -120 { lab=la_data_in[127:0]}
N -40 -140 -20 -140 { lab=wbs_addr_i[31:0]}
N -40 -160 -20 -160 { lab=wbs_dat_i[31:0]}
N -40 -180 -20 -180 { lab=wbs_sel_i[3:0]}
N 280 80 300 80 { lab=user_irq[2:0]}
N 280 0 300 0 { lab=gpio_noesd[17:0]}
N -40 -280 -20 -280 { lab=wb_clk_i}
N -40 -260 -20 -260 { lab=wbs_rst_i}
N -40 -240 -20 -240 { lab=wbs_stb_i}
N -40 -220 -20 -220 { lab=wbs_cyc_i}
N -40 -200 -20 -200 { lab=wbs_we_i}
N -40 -100 -20 -100 { lab=la_oenb[127:0]}
N -520 -2400 -520 -2380 { lab=GND}
N -520 -2320 -480 -2320 { lab=ioc}
N -520 -2320 -520 -2300 { lab=ioc}
N -420 -2320 -400 -2320 { lab=gpio_analog[16]}
N -560 -2320 -520 -2320 { lab=ioc}
N -520 -2240 -520 -2220 { lab=GND}
N -520 -2160 -480 -2160 { lab=islope}
N -520 -2160 -520 -2140 { lab=islope}
N -420 -2160 -400 -2160 { lab=gpio_analog[15]}
N -560 -2160 -520 -2160 { lab=islope}
N -520 -2080 -520 -2060 { lab=GND}
N -520 -2000 -480 -2000 { lab=iosc}
N -520 -2000 -520 -1980 { lab=iosc}
N -420 -2000 -400 -2000 { lab=gpio_analog[14]}
N -560 -2000 -520 -2000 { lab=iosc}
N -520 -1920 -520 -1900 { lab=GND}
N -520 -2000 -480 -2000 { lab=iosc}
N -520 -2000 -520 -1980 { lab=iosc}
N -420 -2000 -400 -2000 { lab=gpio_analog[14]}
N -560 -2000 -520 -2000 { lab=iosc}
N -520 -1920 -520 -1900 { lab=GND}
N -120 -2480 -80 -2480 { lab=vfb}
N -120 -2480 -120 -2460 { lab=vfb}
N -20 -2480 0 -2480 { lab=gpio_analog[13]}
N -160 -2480 -120 -2480 { lab=vfb}
N -120 -2400 -120 -2380 { lab=GND}
N -120 -2320 -80 -2320 { lab=vref}
N -120 -2320 -120 -2300 { lab=vref}
N -20 -2320 0 -2320 { lab=gpio_analog[12]}
N -160 -2320 -120 -2320 { lab=vref}
N -120 -2240 -120 -2220 { lab=GND}
N -120 -2160 -80 -2160 { lab=vcomp}
N -120 -2160 -120 -2140 { lab=vcomp}
N -20 -2160 0 -2160 { lab=gpio_analog[11]}
N -160 -2160 -120 -2160 { lab=vcomp}
N -120 -2080 -120 -2060 { lab=GND}
N -120 -2000 -80 -2000 { lab=imon}
N -120 -2000 -120 -1980 { lab=imon}
N -20 -2000 0 -2000 { lab=gpio_analog[10]}
N -160 -2000 -120 -2000 { lab=imon}
N -120 -1920 -120 -1900 { lab=GND}
N -120 -2000 -80 -2000 { lab=imon}
N -120 -2000 -120 -1980 { lab=imon}
N -20 -2000 0 -2000 { lab=gpio_analog[10]}
N -160 -2000 -120 -2000 { lab=imon}
N -120 -1920 -120 -1900 { lab=GND}
N -460 -1640 -440 -1640 { lab=io_in3v3[16]}
N -540 -1640 -520 -1640 { lab=timeout_ext}
N -460 -1560 -440 -1560 { lab=io_in3v3[15]}
N -540 -1560 -520 -1560 { lab=timeout_sel}
N -460 -1480 -440 -1480 { lab=io_in3v3[14]}
N -540 -1480 -520 -1480 { lab=oc_en}
N -460 -1400 -440 -1400 { lab=io_in3v3[13]}
N -540 -1400 -520 -1400 { lab=sw_en}
N -80 -1640 -60 -1640 { lab=io_in3v3[12]}
N -160 -1640 -140 -1640 { lab=sw_override}
N -80 -1560 -60 -1560 { lab=io_in3v3[11]}
N -160 -1560 -140 -1560 { lab=pmos_val}
N -80 -1480 -60 -1480 { lab=io_in3v3[10]}
N -160 -1480 -140 -1480 { lab=nmos_val}
N -80 -1400 -60 -1400 { lab=io_in3v3[9]}
N -160 -1400 -140 -1400 { lab=pmos_dt}
N -80 -1480 -60 -1480 { lab=io_in3v3[10]}
N -160 -1480 -140 -1480 { lab=nmos_val}
N -80 -1400 -60 -1400 { lab=io_in3v3[9]}
N -160 -1400 -140 -1400 { lab=pmos_dt}
N -80 -1320 -60 -1320 { lab=io_in3v3[8]}
N -160 -1320 -140 -1320 { lab=nmos_dt}
N -1280 -1760 -1280 -1740 { lab=vssa2}
N -1280 -1840 -1280 -1820 { lab=timeout_sel}
N -1280 -1900 -1280 -1880 { lab=vssa2}
N -1280 -1980 -1280 -1960 { lab=oc_en}
N -1180 -1900 -1180 -1880 { lab=vssa2}
N -1180 -1980 -1180 -1960 { lab=sw_en}
N -1180 -1760 -1180 -1740 { lab=vssa2}
N -1180 -1840 -1180 -1820 { lab=sw_override}
N -1080 -1760 -1080 -1740 { lab=vssa2}
N -1080 -1840 -1080 -1820 { lab=pmos_val}
N -1280 -1600 -1280 -1580 { lab=vssa2}
N -1280 -1680 -1280 -1660 { lab=nmos_val}
N -1180 -1600 -1180 -1580 { lab=vssa2}
N -1180 -1680 -1180 -1660 { lab=pmos_dt}
N -1080 -1600 -1080 -1580 { lab=vssa2}
N -1080 -1680 -1080 -1660 { lab=nmos_dt}
N -1280 -2060 -1280 -2040 { lab=vssa2}
N -1280 -2140 -1280 -2120 { lab=timeout_ext}
N -1280 -2160 -1260 -2160 { lab=timeout_ext}
N -1280 -2160 -1280 -2140 { lab=timeout_ext}
N 740 -980 800 -980 { lab=io_analog[1]}
N 740 -1060 800 -1060 { lab=io_analog[2]}
N 740 -1140 800 -1140 { lab=io_analog[3]}
N 860 -1140 880 -1140 { lab=vsw}
N 880 -1140 880 -1060 { lab=vsw}
N 860 -1060 880 -1060 { lab=vsw}
N 860 -980 880 -980 { lab=vsw}
N 880 -1060 880 -980 { lab=vsw}
N 880 -1140 920 -1140 { lab=vsw}
N 1320 -820 1320 -800 { lab=#net23}
N 1320 -580 1420 -580 { lab=VOUT}
N 1320 -600 1320 -580 { lab=VOUT}
N 1420 -290 1420 -270 { lab=GND}
N 1420 -580 1420 -540 { lab=VOUT}
N 1740 -390 1740 -370 { lab=GND}
N 1420 -580 1540 -580 { lab=VOUT}
N 1740 -480 1740 -450 { lab=#net24}
N 1540 -580 1540 -570 { lab=VOUT}
N 1160 -980 1160 -960 { lab=vsw}
N 1160 -900 1160 -840 { lab=#net25}
N 1160 -840 1220 -840 { lab=#net25}
N 1540 -480 1540 -440 { lab=VFB}
N 1540 -380 1540 -360 { lab=GND}
N 1540 -580 1660 -580 { lab=VOUT}
N 1540 -460 1560 -460 { lab=VFB}
N 1540 -620 1540 -580 { lab=VOUT}
N 1420 -780 1420 -760 { lab=#net26}
N 1280 -840 1320 -840 { lab=#net23}
N 1320 -840 1320 -820 { lab=#net23}
N 1320 -840 1420 -840 { lab=#net23}
N 1420 -700 1420 -680 { lab=VOUT}
N 1320 -680 1420 -680 { lab=VOUT}
N 1320 -740 1320 -680 { lab=VOUT}
N 1160 -680 1160 -660 { lab=GND}
N 1160 -840 1160 -800 { lab=#net25}
N 1320 -680 1320 -600 { lab=VOUT}
N 1420 -450 1420 -430 { lab=#net27}
N 1420 -370 1420 -350 { lab=#net28}
N 1420 -540 1420 -510 { lab=VOUT}
N 1660 -580 1820 -580 { lab=VOUT}
N 1540 -570 1540 -540 { lab=VOUT}
N 1740 -500 1740 -480 { lab=#net24}
N 1740 -580 1740 -560 { lab=VOUT}
N 1820 -580 1840 -580 { lab=VOUT}
N 1900 -580 1960 -580 { lab=VOUT_FILT}
N 1960 -480 1960 -440 { lab=GND}
N 1960 -580 1960 -540 { lab=VOUT_FILT}
N 1960 -580 1980 -580 { lab=VOUT_FILT}
N 1590 -1620 1590 -1610 { lab=io_analog[6:4]}
N 1590 -1610 1590 -1600 { lab=io_analog[6:4]}
N 1590 -1540 1590 -1520 { lab=#net29}
N 1370 -1660 1370 -1560 { lab=#net22}
N 940 -2820 940 -2720 { lab=#net19}
N 1160 -2780 1160 -2760 { lab=vccd2}
N 1160 -2700 1160 -2680 { lab=#net30}
N 940 -2440 940 -2320 { lab=#net16}
N 1160 -2440 1160 -2400 { lab=vccd1}
N 1160 -2340 1160 -2320 { lab=#net31}
N 940 -2060 940 -1940 { lab=#net13}
N 1160 -2100 1160 -2040 { lab=vdda2}
N 1200 -1560 1200 -1520 { lab=#net32}
N 1200 -1680 1200 -1620 { lab=vdda1}
N 980 -1680 980 -1560 { lab=#net9}
N -840 -1880 -840 -1860 { lab=GND}
N -840 -1960 -840 -1940 { lab=isensea}
N -840 -2040 -840 -2020 { lab=imon}
N -840 -1940 -800 -1940 { lab=isensea}
C {user_analog_project_wrapper.sym} 130 -100 0 0 {name=x1}
C {devices/code_shown.sym} 920 -130 0 0 {name=s1 only_toplevel=false value="
.param VIN = 3.3
.param RL = 20
.option temp=70

.param mc_mm_switch=0
.lib /usr/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /usr/share/pdk/sky130A/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice

.control
save all
tran 40n 40u
write analog_wrapper_tb.raw
.endc
"}
C {devices/isource.sym} -300 -840 2 0 {name=I0 value=100u
}
C {devices/gnd.sym} -300 -790 0 0 {name=l10 lab=GND}
C {devices/lab_pin.sym} -300 -970 0 0 {name=l13 sig_type=std_logic lab=ibias
}
C {devices/vsource.sym} -520 -570 0 0 {name=V6 value=1.25}
C {devices/gnd.sym} -520 -520 0 0 {name=l54 lab=GND}
C {devices/lab_pin.sym} -520 -700 0 0 {name=l55 sig_type=std_logic lab=vref
}
C {devices/isource.sym} -40 -850 2 0 {name=I4 value=80u
}
C {devices/gnd.sym} -40 -800 0 0 {name=l78 lab=GND}
C {devices/lab_pin.sym} -40 -980 0 0 {name=l79 sig_type=std_logic lab=islope
}
C {devices/capa.sym} 200 -850 0 0 {name=C5
m=1
value=5n
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 200 -780 0 0 {name=l61 lab=GND}
C {devices/lab_pin.sym} 200 -980 2 1 {name=l16 sig_type=std_logic lab=vcomp
}
C {devices/isource.sym} -560 -840 2 0 {name=I1 value=50u
}
C {devices/gnd.sym} -560 -790 0 0 {name=l18 lab=GND}
C {devices/lab_pin.sym} -560 -970 0 0 {name=l19 sig_type=std_logic lab=iosc
}
C {devices/res.sym} -520 -650 0 1 {name=R12
value=120
footprint=10
device=resistor
m=1}
C {devices/res.sym} -560 -920 0 1 {name=R14
value=10
footprint=10
device=resistor
m=1}
C {devices/res.sym} -300 -920 0 1 {name=R15
value=10
footprint=10
device=resistor
m=1}
C {devices/res.sym} -40 -930 0 1 {name=R16
value=10
footprint=10
device=resistor
m=1}
C {devices/res.sym} 200 -930 0 1 {name=R17
value=7.8E3
footprint=10
device=resistor
m=1}
C {devices/capa.sym} 30 -850 0 0 {name=C11
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 30 -800 0 0 {name=l60 lab=GND}
C {devices/capa.sym} -220 -840 0 0 {name=C12
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -220 -790 0 0 {name=l62 lab=GND}
C {devices/capa.sym} -480 -840 0 0 {name=C13
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -480 -790 0 0 {name=l63 lab=GND}
C {devices/isource.sym} -300 -570 2 0 {name=I2 value=100u
}
C {devices/gnd.sym} -300 -520 0 0 {name=l69 lab=GND}
C {devices/lab_pin.sym} -300 -700 0 0 {name=l70 sig_type=std_logic lab=ioc
}
C {devices/res.sym} -300 -650 0 1 {name=R25
value=10
footprint=10
device=resistor
m=1}
C {devices/capa.sym} -220 -570 0 0 {name=C17
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -220 -520 0 0 {name=l71 lab=GND}
C {devices/res.sym} -450 -2480 1 0 {name=R11
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -520 -2430 0 0 {name=C10
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 300 -280 0 1 {name=l14 sig_type=std_logic lab=vdda1}
C {devices/lab_wire.sym} 300 -260 0 1 {name=l15 sig_type=std_logic lab=vdda2}
C {devices/lab_wire.sym} 300 -240 0 1 {name=l17 sig_type=std_logic lab=vssa1}
C {devices/lab_wire.sym} 300 -220 0 1 {name=l20 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 300 -200 0 1 {name=l21 sig_type=std_logic lab=vccd1}
C {devices/lab_wire.sym} 300 -180 0 1 {name=l22 sig_type=std_logic lab=vccd2}
C {devices/lab_wire.sym} 300 -160 0 1 {name=l23 sig_type=std_logic lab=vssd1}
C {devices/lab_wire.sym} 300 -140 0 1 {name=l24 sig_type=std_logic lab=vssd2}
C {devices/lab_wire.sym} 300 20 0 1 {name=l25 sig_type=std_logic lab=io_analog[10:0]}
C {devices/lab_wire.sym} 300 40 0 1 {name=l12 sig_type=std_logic lab=io_clamp_high[2:0]}
C {devices/lab_wire.sym} 300 60 0 1 {name=l27 sig_type=std_logic lab=io_clamp_low[2:0]}
C {devices/lab_wire.sym} 300 -20 0 1 {name=l28 sig_type=std_logic lab=gpio_analog[17:0]}
C {devices/lab_wire.sym} -40 -60 0 0 {name=l29 sig_type=std_logic lab=io_in3v3[26:0]}
C {devices/res.sym} 1050 -1680 3 1 {name=R2
value=20m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1130 -1680 1 0 {name=L7
m=1
value=1.5n
footprint=1206
device=inductor}
C {devices/res.sym} 1050 -1420 3 1 {name=R3
value=20m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1130 -1420 1 0 {name=L1
m=1
value=1n
footprint=1206
device=inductor}
C {devices/capa.sym} 1200 -1490 0 0 {name=C21
m=1
value=50p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 1220 -1680 0 1 {name=l30 sig_type=std_logic lab=vdda1}
C {devices/gnd.sym} 980 -1400 0 0 {name=l35 lab=GND}
C {devices/lab_wire.sym} 1220 -1420 0 1 {name=l39 sig_type=std_logic lab=vssa1}
C {devices/vsource.sym} 980 -1490 0 0 {name=V8 value="PWL(0 0 1u \{VIN\})"}
C {devices/res.sym} 1010 -2100 3 1 {name=R4
value=20m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1090 -2100 1 0 {name=L2
m=1
value=1.5n
footprint=1206
device=inductor}
C {devices/res.sym} 1010 -1840 3 1 {name=R5
value=20m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1090 -1840 1 0 {name=L3
m=1
value=1n
footprint=1206
device=inductor}
C {devices/capa.sym} 1160 -1910 0 0 {name=C2
m=1
value=50p
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 1180 -2100 0 1 {name=l42 sig_type=std_logic lab=vdda2}
C {devices/gnd.sym} 940 -1820 0 0 {name=l43 lab=GND}
C {devices/lab_wire.sym} 1180 -1840 0 1 {name=l57 sig_type=std_logic lab=vssa2}
C {devices/vsource.sym} 940 -1910 0 0 {name=V4 value="PWL(0 0 1u \{VIN\})"}
C {devices/res.sym} 1010 -2480 3 1 {name=R13
value=20m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1090 -2480 1 0 {name=L4
m=1
value=1.5n
footprint=1206
device=inductor}
C {devices/res.sym} 1010 -2220 3 1 {name=R18
value=20m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1090 -2220 1 0 {name=L5
m=1
value=1n
footprint=1206
device=inductor}
C {devices/capa.sym} 1160 -2290 0 0 {name=C3
m=1
value=50p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 940 -2200 0 0 {name=l59 lab=GND}
C {devices/vsource.sym} 940 -2290 0 0 {name=V5 value=1.8}
C {devices/lab_wire.sym} 1180 -2480 0 1 {name=l65 sig_type=std_logic lab=vccd1}
C {devices/lab_wire.sym} 1180 -2220 0 1 {name=l58 sig_type=std_logic lab=vssd1}
C {devices/res.sym} 1010 -2820 3 1 {name=R19
value=20m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1090 -2820 1 0 {name=L6
m=1
value=1.5n
footprint=1206
device=inductor}
C {devices/res.sym} 1010 -2580 3 1 {name=R20
value=20m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1090 -2580 1 0 {name=L8
m=1
value=1.5n
footprint=1206
device=inductor}
C {devices/capa.sym} 1160 -2650 0 0 {name=C14
m=1
value=50p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 940 -2560 0 0 {name=l64 lab=GND}
C {devices/vsource.sym} 940 -2650 0 0 {name=V7 value=1.8}
C {devices/lab_wire.sym} 1180 -2820 0 1 {name=l66 sig_type=std_logic lab=vccd2}
C {devices/lab_wire.sym} 1180 -2580 0 1 {name=l67 sig_type=std_logic lab=vssd2}
C {devices/res.sym} 1440 -1660 3 1 {name=R21
value=10m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1520 -1660 1 0 {name=L9
m=1
value=1n
footprint=1206
device=inductor}
C {devices/res.sym} 1440 -1420 3 1 {name=R22
value=10m
footprint=10
device=resistor
m=1}
C {devices/ind.sym} 1520 -1420 1 0 {name=L10
m=1
value=0.5n
footprint=1206
device=inductor}
C {devices/capa.sym} 1590 -1490 0 0 {name=C15
m=1
value=200p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1370 -1400 0 0 {name=l72 lab=GND}
C {devices/vsource.sym} 1370 -1490 0 0 {name=V9 value="PWL(0 0 1u \{VIN\})"}
C {devices/lab_wire.sym} 1610 -1660 0 1 {name=l68 sig_type=std_logic lab=io_analog[6:4]}
C {devices/lab_wire.sym} 1620 -1420 0 1 {name=l73 sig_type=std_logic lab=io_analog[10:8]}
C {devices/lab_wire.sym} 1620 -1380 0 1 {name=l74 sig_type=std_logic lab=io_analog[0]}
C {devices/lab_wire.sym} 1600 -1700 0 1 {name=l75 sig_type=std_logic lab=io_clamp_high[2:0]}
C {devices/lab_wire.sym} 1620 -1340 0 1 {name=l76 sig_type=std_logic lab=io_clamp_low[2:0]}
C {devices/lab_wire.sym} -40 -80 0 0 {name=l77 sig_type=std_logic lab=io_in[26:0]}
C {devices/lab_wire.sym} -40 -100 0 0 {name=l80 sig_type=std_logic lab=la_oenb[127:0]}
C {devices/lab_wire.sym} -40 -120 0 0 {name=l81 sig_type=std_logic lab=la_data_in[127:0]}
C {devices/lab_wire.sym} -40 -140 0 0 {name=l82 sig_type=std_logic lab=wbs_addr_i[31:0]}
C {devices/lab_wire.sym} -40 -160 0 0 {name=l83 sig_type=std_logic lab=wbs_dat_i[31:0]}
C {devices/lab_wire.sym} -40 -180 0 0 {name=l84 sig_type=std_logic lab=wbs_sel_i[3:0]}
C {devices/lab_wire.sym} -40 -200 0 0 {name=l85 sig_type=std_logic lab=wbs_we_i}
C {devices/lab_wire.sym} -40 -220 0 0 {name=l86 sig_type=std_logic lab=wbs_cyc_i}
C {devices/lab_wire.sym} -40 -240 0 0 {name=l87 sig_type=std_logic lab=wbs_stb_i}
C {devices/lab_wire.sym} -40 -260 0 0 {name=l88 sig_type=std_logic lab=wbs_rst_i}
C {devices/lab_wire.sym} -40 -280 0 0 {name=l89 sig_type=std_logic lab=wb_clk_i}
C {devices/lab_wire.sym} -40 -40 0 0 {name=l90 sig_type=std_logic lab=user_clock2}
C {devices/lab_wire.sym} 300 -120 0 1 {name=l91 sig_type=std_logic lab=wbs_ack_o}
C {devices/lab_wire.sym} 300 -100 0 1 {name=l92 sig_type=std_logic lab=wbs_dat_o[31:0]}
C {devices/lab_wire.sym} 300 -80 0 1 {name=l93 sig_type=std_logic lab=la_data_out[127:0]}
C {devices/lab_wire.sym} 300 -60 0 1 {name=l94 sig_type=std_logic lab=io_out[26:0]}
C {devices/lab_wire.sym} 300 -40 0 1 {name=l95 sig_type=std_logic lab=io_oeb[26:0]}
C {devices/lab_wire.sym} 300 0 0 1 {name=l96 sig_type=std_logic lab=gpio_noesd[17:0]}
C {devices/lab_wire.sym} 300 80 0 1 {name=l97 sig_type=std_logic lab=user_irq[2:0]}
C {devices/gnd.sym} -520 -2380 0 0 {name=l26 lab=GND}
C {devices/lab_wire.sym} -400 -2480 0 1 {name=l31 sig_type=std_logic lab=gpio_analog[17]}
C {devices/lab_wire.sym} -560 -2480 0 0 {name=l32 sig_type=std_logic lab=ibias}
C {devices/res.sym} -450 -2320 1 0 {name=R1
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -520 -2270 0 0 {name=C1
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -520 -2220 0 0 {name=l33 lab=GND}
C {devices/lab_wire.sym} -400 -2320 0 1 {name=l34 sig_type=std_logic lab=gpio_analog[16]}
C {devices/lab_wire.sym} -560 -2320 0 0 {name=l36 sig_type=std_logic lab=ioc}
C {devices/res.sym} -450 -2160 1 0 {name=R6
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -520 -2110 0 0 {name=C4
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -520 -2060 0 0 {name=l37 lab=GND}
C {devices/lab_wire.sym} -400 -2160 0 1 {name=l38 sig_type=std_logic lab=gpio_analog[15]}
C {devices/lab_wire.sym} -560 -2160 0 0 {name=l40 sig_type=std_logic lab=islope}
C {devices/res.sym} -450 -2000 1 0 {name=R8
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -520 -1950 0 0 {name=C7
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -520 -1900 0 0 {name=l46 lab=GND}
C {devices/lab_wire.sym} -400 -2000 0 1 {name=l47 sig_type=std_logic lab=gpio_analog[14]}
C {devices/lab_wire.sym} -560 -2000 0 0 {name=l48 sig_type=std_logic lab=iosc}
C {devices/res.sym} -50 -2480 1 0 {name=R9
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -120 -2430 0 0 {name=C8
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -120 -2380 0 0 {name=l49 lab=GND}
C {devices/lab_wire.sym} 0 -2480 0 1 {name=l50 sig_type=std_logic lab=gpio_analog[13]}
C {devices/lab_wire.sym} -160 -2480 0 0 {name=l51 sig_type=std_logic lab=vfb}
C {devices/res.sym} -50 -2320 1 0 {name=R10
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -120 -2270 0 0 {name=C9
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -120 -2220 0 0 {name=l52 lab=GND}
C {devices/lab_wire.sym} 0 -2320 0 1 {name=l53 sig_type=std_logic lab=gpio_analog[12]}
C {devices/lab_wire.sym} -160 -2320 0 0 {name=l56 sig_type=std_logic lab=vref}
C {devices/res.sym} -50 -2160 1 0 {name=R23
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -120 -2110 0 0 {name=C16
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -120 -2060 0 0 {name=l98 lab=GND}
C {devices/lab_wire.sym} 0 -2160 0 1 {name=l99 sig_type=std_logic lab=gpio_analog[11]}
C {devices/lab_wire.sym} -160 -2160 0 0 {name=l100 sig_type=std_logic lab=vcomp}
C {devices/lab_wire.sym} 0 -2000 0 1 {name=l102 sig_type=std_logic lab=gpio_analog[10]}
C {devices/lab_wire.sym} -160 -2000 0 0 {name=l103 sig_type=std_logic lab=imon}
C {devices/res.sym} -50 -2000 1 0 {name=R26
value=120
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} -120 -1950 0 0 {name=C19
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} -120 -1900 0 0 {name=l104 lab=GND}
C {devices/res.sym} -490 -1640 1 0 {name=R7
value=120
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -440 -1640 0 1 {name=l41 sig_type=std_logic lab=io_in3v3[16]}
C {devices/lab_wire.sym} -540 -1640 0 0 {name=l44 sig_type=std_logic lab=timeout_ext}
C {devices/res.sym} -490 -1560 1 0 {name=R24
value=120
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -440 -1560 0 1 {name=l45 sig_type=std_logic lab=io_in3v3[15]}
C {devices/lab_wire.sym} -540 -1560 0 0 {name=l101 sig_type=std_logic lab=timeout_sel}
C {devices/res.sym} -490 -1480 1 0 {name=R27
value=120
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -440 -1480 0 1 {name=l105 sig_type=std_logic lab=io_in3v3[14]}
C {devices/lab_wire.sym} -540 -1480 0 0 {name=l106 sig_type=std_logic lab=oc_en}
C {devices/res.sym} -490 -1400 1 0 {name=R28
value=120
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -440 -1400 0 1 {name=l107 sig_type=std_logic lab=io_in3v3[13]}
C {devices/lab_wire.sym} -540 -1400 0 0 {name=l108 sig_type=std_logic lab=sw_en}
C {devices/res.sym} -110 -1640 1 0 {name=R29
value=120
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -60 -1640 0 1 {name=l109 sig_type=std_logic lab=io_in3v3[12]}
C {devices/lab_wire.sym} -160 -1640 0 0 {name=l110 sig_type=std_logic lab=sw_override}
C {devices/res.sym} -110 -1560 1 0 {name=R30
value=120
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -60 -1560 0 1 {name=l111 sig_type=std_logic lab=io_in3v3[11]}
C {devices/lab_wire.sym} -160 -1560 0 0 {name=l112 sig_type=std_logic lab=pmos_val}
C {devices/res.sym} -110 -1480 1 0 {name=R33
value=120
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -60 -1480 0 1 {name=l117 sig_type=std_logic lab=io_in3v3[10]}
C {devices/lab_wire.sym} -160 -1480 0 0 {name=l118 sig_type=std_logic lab=nmos_val}
C {devices/res.sym} -110 -1400 1 0 {name=R34
value=120
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -60 -1400 0 1 {name=l119 sig_type=std_logic lab=io_in3v3[9]}
C {devices/lab_wire.sym} -160 -1400 0 0 {name=l120 sig_type=std_logic lab=pmos_dt}
C {devices/res.sym} -110 -1320 1 0 {name=R35
value=120
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} -60 -1320 0 1 {name=l121 sig_type=std_logic lab=io_in3v3[8]}
C {devices/lab_wire.sym} -160 -1320 0 0 {name=l122 sig_type=std_logic lab=nmos_dt}
C {devices/lab_wire.sym} -1280 -1740 0 1 {name=l1 sig_type=std_logic lab=vssa2}
C {devices/vsource.sym} -1280 -1790 0 0 {name=V1 value=\{VIN\}}
C {devices/lab_wire.sym} -1280 -1840 0 1 {name=l2 sig_type=std_logic lab=timeout_sel}
C {devices/lab_wire.sym} -1280 -1880 0 1 {name=l3 sig_type=std_logic lab=vssa2}
C {devices/vsource.sym} -1280 -1930 0 0 {name=V2 value=\{VIN\}}
C {devices/lab_wire.sym} -1280 -1980 0 1 {name=l4 sig_type=std_logic lab=oc_en}
C {devices/lab_wire.sym} -1180 -1880 0 1 {name=l5 sig_type=std_logic lab=vssa2}
C {devices/vsource.sym} -1180 -1930 0 0 {name=V3 value=\{VIN\}}
C {devices/lab_wire.sym} -1180 -1980 0 1 {name=l6 sig_type=std_logic lab=sw_en}
C {devices/lab_wire.sym} -1180 -1740 0 1 {name=l7 sig_type=std_logic lab=vssa2}
C {devices/vsource.sym} -1180 -1790 0 0 {name=V10 value=0}
C {devices/lab_wire.sym} -1180 -1840 0 1 {name=l8 sig_type=std_logic lab=sw_override}
C {devices/lab_wire.sym} -1080 -1740 0 1 {name=l113 sig_type=std_logic lab=vssa2}
C {devices/vsource.sym} -1080 -1790 0 0 {name=V12 value=0}
C {devices/lab_wire.sym} -1080 -1840 0 1 {name=l114 sig_type=std_logic lab=pmos_val}
C {devices/lab_wire.sym} -1280 -1580 0 1 {name=l9 sig_type=std_logic lab=vssa2}
C {devices/vsource.sym} -1280 -1630 0 0 {name=V11 value=0}
C {devices/lab_wire.sym} -1280 -1680 0 1 {name=l11 sig_type=std_logic lab=nmos_val}
C {devices/lab_wire.sym} -1180 -1580 0 1 {name=l115 sig_type=std_logic lab=vssa2}
C {devices/vsource.sym} -1180 -1630 0 0 {name=V13 value=0}
C {devices/lab_wire.sym} -1180 -1680 0 1 {name=l116 sig_type=std_logic lab=pmos_dt}
C {devices/lab_wire.sym} -1080 -1580 0 1 {name=l123 sig_type=std_logic lab=vssa2}
C {devices/vsource.sym} -1080 -1630 0 0 {name=V14 value=0}
C {devices/lab_wire.sym} -1080 -1680 0 1 {name=l124 sig_type=std_logic lab=nmos_dt}
C {devices/vsource.sym} -1280 -2090 0 0 {name=V15 value="PULSE(0 \{VIN\} 0 3n 3n 200n 2u)"}
C {devices/lab_pin.sym} -1260 -2160 0 1 {name=l125 sig_type=std_logic lab=timeout_ext
}
C {devices/lab_wire.sym} -1280 -2040 0 1 {name=l126 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 740 -1140 0 0 {name=l127 sig_type=std_logic lab=io_analog[3]}
C {devices/res.sym} 830 -1060 3 1 {name=R31
value=10m
footprint=10
device=resistor
m=1}
C {devices/lab_wire.sym} 740 -1060 0 0 {name=l128 sig_type=std_logic lab=io_analog[2]}
C {devices/lab_wire.sym} 740 -980 0 0 {name=l129 sig_type=std_logic lab=io_analog[1]}
C {devices/res.sym} 830 -1140 3 1 {name=R32
value=10m
footprint=10
device=resistor
m=1}
C {devices/res.sym} 830 -980 3 1 {name=R36
value=10m
footprint=10
device=resistor
m=1}
C {devices/lab_pin.sym} 920 -1140 2 0 {name=l130 sig_type=std_logic lab=vsw
}
C {devices/ind.sym} 1320 -770 0 0 {name=L11
m=1
value=22u
footprint=1206
device=inductor}
C {devices/res.sym} 1250 -840 3 0 {name=R37
value=0.145
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 1420 -730 0 0 {name=C6
m=1
value=3.32p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 1420 -320 0 0 {name=C18
m=1
value=47u
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1420 -270 0 0 {name=l131 lab=GND}
C {devices/res.sym} 1740 -420 2 0 {name=R38
value=\{RL\}
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1740 -370 0 0 {name=l132 lab=GND}
C {devices/lab_pin.sym} 1160 -980 2 0 {name=l133 sig_type=std_logic lab=vsw
}
C {devices/vsource.sym} 1160 -930 0 0 {name=V16 value=0}
C {devices/res.sym} 1540 -510 2 0 {name=R39
value=17.6k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 1540 -620 2 0 {name=l134 sig_type=std_logic lab=VOUT
}
C {devices/res.sym} 1540 -410 2 0 {name=R40
value=40k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1540 -360 0 0 {name=l135 lab=GND}
C {devices/lab_pin.sym} 1560 -460 2 0 {name=l136 sig_type=std_logic lab=VFB
}
C {devices/res.sym} 1420 -810 0 0 {name=R41
value=45
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 1160 -710 0 0 {name=C20
m=1
value=15p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1160 -660 0 0 {name=l137 lab=GND}
C {devices/res.sym} 1160 -770 0 0 {name=R42
value=1
footprint=1206
device=resistor
m=1}
C {devices/ind.sym} 1420 -400 0 0 {name=L12
m=1
value=5n
footprint=1206
device=inductor}
C {devices/res.sym} 1420 -480 0 0 {name=R43
value=10m
footprint=1206
device=resistor
m=1}
C {devices/vsource.sym} 1740 -530 0 0 {name=V17 value=0}
C {devices/res.sym} 1870 -580 3 0 {name=R44
value=10k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 1960 -510 0 0 {name=C22
m=1
value=200p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1960 -440 0 0 {name=l138 lab=GND}
C {devices/lab_pin.sym} 1980 -580 2 0 {name=l139 sig_type=std_logic lab=VOUT_FILT}
C {devices/res.sym} 1590 -1570 0 1 {name=R45
value=10m
footprint=10
device=resistor
m=1}
C {devices/res.sym} 1160 -2730 0 1 {name=R46
value=20m
footprint=10
device=resistor
m=1}
C {devices/res.sym} 1160 -2370 0 1 {name=R47
value=20m
footprint=10
device=resistor
m=1}
C {devices/res.sym} 1160 -2010 0 1 {name=R48
value=20m
footprint=10
device=resistor
m=1}
C {devices/res.sym} 1200 -1590 0 1 {name=R49
value=20m
footprint=10
device=resistor
m=1}
C {devices/vsource.sym} -840 -1990 0 0 {name=V18 value=1}
C {devices/res.sym} -840 -1910 0 0 {name=R50
value=120
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} -840 -1860 0 0 {name=l140 lab=GND}
C {devices/lab_wire.sym} -840 -2040 0 1 {name=l141 sig_type=std_logic lab=imon}
C {devices/lab_wire.sym} -800 -1940 0 1 {name=l142 sig_type=std_logic lab=isensea}
