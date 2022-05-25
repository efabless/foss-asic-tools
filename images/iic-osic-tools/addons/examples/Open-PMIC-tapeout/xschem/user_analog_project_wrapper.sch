v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {requires 4 analog pins, 3 bias pins (7 total)} 3860 -650 0 0 0.4 0.4 {}
T {requires 9 digital inputs} 4870 -680 0 0 0.4 0.4 {}
T {requires 1 bias pin} 3980 350 0 0 0.4 0.4 {}
T {clamps for io_analog[4]} 3400 1060 0 0 0.4 0.4 {}
T {clamps for io_analog[5]} 4330 1050 0 0 0.4 0.4 {}
T {clamps for io_analog[6]} 3850 1060 0 0 0.4 0.4 {}
T {metal resistors as net ties} 4680 1700 0 0 1 1 {}
T {second pass ESD clamps} 6140 190 0 0 1 1 {}
N 4020 -560 4020 -540 { lab=vdda2}
N 4140 -560 4140 -540 { lab=vssa2}
N 4940 -600 4940 -580 { lab=vdda2}
N 5180 -600 5180 -580 { lab=vssa2}
N 4260 -300 4280 -300 { lab=cycle_end}
N 4260 -360 4280 -360 { lab=overcurrent}
N 3880 -180 3900 -180 { lab=TIMEOUT_OUT}
N 5280 -120 5300 -120 { lab=TIMEOUT_OUT}
N 4880 240 4900 240 { lab=VDD_PWR}
N 4880 320 4900 320 { lab=vssa2}
N 4880 420 4900 420 { lab=P_IN}
N 4880 460 4900 460 { lab=P_IN_N}
N 4880 520 4900 520 { lab=N_IN}
N 4880 560 4900 560 { lab=N_IN_N}
N 5300 320 5320 320 { lab=SENSE_FET_KELVIN}
N 5300 360 5310 360 { lab=SENSE_FET}
N 5310 360 5320 360 { lab=SENSE_FET}
N 5300 460 5320 460 { lab=SW_NODE_ESD}
N 5300 400 5320 400 { lab=SW_NODE}
N 4820 -320 4840 -320 { lab=overcurrent}
N 5280 -200 5300 -200 { lab=N_IN_N}
N 5280 -240 5300 -240 { lab=N_IN}
N 5280 -300 5300 -300 { lab=P_IN_N}
N 5280 -340 5300 -340 { lab=P_IN}
N 3880 -360 3900 -360 { lab=SW_NODE_ESD}
N 3880 -400 3900 -400 { lab=SENSE_FET}
N 3880 -440 3900 -440 { lab=SENSE_FET_KELVIN}
N 4020 100 4020 120 { lab=vdda2}
N 4170 210 4190 210 { lab=timeout_int}
N 4820 -480 4840 -480 { lab=timeout_int}
N 4820 -360 4840 -360 { lab=cycle_end}
N 4820 -400 4840 -400 { lab=io_in_3v3[15]}
N 4820 -440 4840 -440 { lab=io_in_3v3[16]}
N 4820 -280 4840 -280 { lab=io_in_3v3[14]}
N 4820 -240 4840 -240 { lab=io_in_3v3[13]}
N 4820 -200 4840 -200 { lab=io_in_3v3[12]}
N 4820 -160 4840 -160 { lab=io_in_3v3[11]}
N 4820 -120 4840 -120 { lab=io_in_3v3[10]}
N 4820 -80 4840 -80 { lab=io_in_3v3[9]}
N 4820 -40 4840 -40 { lab=io_in_3v3[8]}
N 4260 -220 4280 -220 { lab=gpio_analog[10]}
N 3880 -320 3900 -320 { lab=gpio_analog[12]}
N 3880 -280 3900 -280 { lab=gpio_analog[13]}
N 3880 -240 3900 -240 { lab=gpio_analog[11]}
N 3850 190 3870 190 { lab=gpio_analog[14]}
N 4000 -60 4000 -40 { lab=gpio_analog[17]}
N 4060 -60 4060 0 { lab=gpio_analog[16]}
N 4140 -60 4140 40 { lab=gpio_analog[15]}
N 5180 800 5180 820 { lab=io_analog[3]}
N 5180 800 5420 800 { lab=io_analog[3]}
N 5420 800 5420 820 { lab=io_analog[3]}
N 5300 800 5300 820 { lab=io_analog[3]}
N 5300 780 5300 800 { lab=io_analog[3]}
N 5180 880 5180 900 { lab=SW_NODE}
N 5180 900 5420 900 { lab=SW_NODE}
N 5420 880 5420 900 { lab=SW_NODE}
N 5300 880 5300 900 { lab=SW_NODE}
N 5300 900 5300 920 { lab=SW_NODE}
N 5560 800 5560 820 { lab=io_analog[2]}
N 5560 800 5800 800 { lab=io_analog[2]}
N 5800 800 5800 820 { lab=io_analog[2]}
N 5680 800 5680 820 { lab=io_analog[2]}
N 5680 780 5680 800 { lab=io_analog[2]}
N 5560 880 5560 900 { lab=SW_NODE}
N 5560 900 5800 900 { lab=SW_NODE}
N 5800 880 5800 900 { lab=SW_NODE}
N 5680 880 5680 900 { lab=SW_NODE}
N 5680 900 5680 920 { lab=SW_NODE}
N 5940 800 5940 820 { lab=io_analog[1]}
N 5940 800 6180 800 { lab=io_analog[1]}
N 6180 800 6180 820 { lab=io_analog[1]}
N 6060 800 6060 820 { lab=io_analog[1]}
N 6060 780 6060 800 { lab=io_analog[1]}
N 5940 880 5940 900 { lab=SW_NODE}
N 5940 900 6180 900 { lab=SW_NODE}
N 6180 880 6180 900 { lab=SW_NODE}
N 6060 880 6060 900 { lab=SW_NODE}
N 6060 900 6060 920 { lab=SW_NODE}
N 5300 760 5300 780 { lab=io_analog[3]}
N 5680 760 5680 780 { lab=io_analog[2]}
N 6060 760 6060 780 { lab=io_analog[1]}
N 5300 920 5300 940 { lab=SW_NODE}
N 5300 940 5680 940 { lab=SW_NODE}
N 5680 920 5680 940 { lab=SW_NODE}
N 5680 940 6060 940 { lab=SW_NODE}
N 6060 920 6060 940 { lab=SW_NODE}
N 5680 940 5680 980 { lab=SW_NODE}
N 5180 1100 5180 1120 { lab=io_analog[10]}
N 5180 1100 5420 1100 { lab=io_analog[10]}
N 5420 1100 5420 1120 { lab=io_analog[10]}
N 5300 1100 5300 1120 { lab=io_analog[10]}
N 5300 1080 5300 1100 { lab=io_analog[10]}
N 5180 1180 5180 1200 { lab=vssa2}
N 5180 1200 5420 1200 { lab=vssa2}
N 5420 1180 5420 1200 { lab=vssa2}
N 5300 1180 5300 1200 { lab=vssa2}
N 5560 1100 5560 1120 { lab=io_analog[9]}
N 5560 1100 5800 1100 { lab=io_analog[9]}
N 5800 1100 5800 1120 { lab=io_analog[9]}
N 5680 1100 5680 1120 { lab=io_analog[9]}
N 5680 1080 5680 1100 { lab=io_analog[9]}
N 5560 1180 5560 1200 { lab=vssa2}
N 5560 1200 5800 1200 { lab=vssa2}
N 5800 1180 5800 1200 { lab=vssa2}
N 5680 1180 5680 1200 { lab=vssa2}
N 5940 1100 5940 1120 { lab=io_analog[8]}
N 5940 1100 6180 1100 { lab=io_analog[8]}
N 6180 1100 6180 1120 { lab=io_analog[8]}
N 6060 1100 6060 1120 { lab=io_analog[8]}
N 6060 1080 6060 1100 { lab=io_analog[8]}
N 5940 1180 5940 1200 { lab=vssa2}
N 5940 1200 6180 1200 { lab=vssa2}
N 6180 1180 6180 1200 { lab=vssa2}
N 6060 1180 6060 1200 { lab=vssa2}
N 6320 1100 6320 1120 { lab=io_analog[0]}
N 6320 1100 6560 1100 { lab=io_analog[0]}
N 6560 1100 6560 1120 { lab=io_analog[0]}
N 6440 1100 6440 1120 { lab=io_analog[0]}
N 6440 1080 6440 1100 { lab=io_analog[0]}
N 6320 1180 6320 1200 { lab=vssa2}
N 6320 1200 6560 1200 { lab=vssa2}
N 6560 1180 6560 1200 { lab=vssa2}
N 6440 1180 6440 1200 { lab=vssa2}
N 5300 1200 5300 1220 { lab=vssa2}
N 5300 1220 6440 1220 { lab=vssa2}
N 6440 1200 6440 1220 { lab=vssa2}
N 6060 1200 6060 1220 { lab=vssa2}
N 5680 1200 5680 1220 { lab=vssa2}
N 5300 1220 5300 1260 { lab=vssa2}
N 3420 880 3420 920 { lab=VDD_PWR}
N 3420 980 3420 1020 { lab=io_clamp_high[0]}
N 3580 980 3580 1020 { lab=io_clamp_low[0]}
N 3580 880 3580 920 { lab=vssa2}
N 3880 880 3880 920 { lab=VDD_PWR}
N 3880 980 3880 1020 { lab=io_clamp_high[2]}
N 4040 980 4040 1020 { lab=io_clamp_low[2]}
N 4040 880 4040 920 { lab=vssa2}
N 4340 880 4340 920 { lab=VDD_PWR}
N 4340 980 4340 1020 { lab=io_clamp_high[1]}
N 4500 880 4500 920 { lab=vssa2}
N 4500 980 4500 1020 { lab=io_clamp_low[1]}
N 3360 1240 3360 1260 { lab=io_analog[4]}
N 3360 1240 3600 1240 { lab=io_analog[4]}
N 3600 1240 3600 1260 { lab=io_analog[4]}
N 3480 1240 3480 1260 { lab=io_analog[4]}
N 3360 1320 3360 1340 { lab=VDD_PWR}
N 3360 1340 3600 1340 { lab=VDD_PWR}
N 3600 1320 3600 1340 { lab=VDD_PWR}
N 3480 1320 3480 1340 { lab=VDD_PWR}
N 3720 1240 3720 1260 { lab=io_analog[4]}
N 3720 1240 3960 1240 { lab=io_analog[4]}
N 3960 1240 3960 1260 { lab=io_analog[4]}
N 3840 1240 3840 1260 { lab=io_analog[4]}
N 3720 1320 3720 1340 { lab=VDD_PWR}
N 3720 1340 3960 1340 { lab=VDD_PWR}
N 3960 1320 3960 1340 { lab=VDD_PWR}
N 3840 1320 3840 1340 { lab=VDD_PWR}
N 3600 1240 3720 1240 { lab=io_analog[4]}
N 3600 1340 3720 1340 { lab=VDD_PWR}
N 3360 1200 3360 1240 { lab=io_analog[4]}
N 3360 1340 3360 1380 { lab=VDD_PWR}
N 4120 1240 4120 1260 { lab=io_analog[5]}
N 4120 1240 4360 1240 { lab=io_analog[5]}
N 4360 1240 4360 1260 { lab=io_analog[5]}
N 4240 1240 4240 1260 { lab=io_analog[5]}
N 4120 1320 4120 1340 { lab=VDD_PWR}
N 4120 1340 4360 1340 { lab=VDD_PWR}
N 4360 1320 4360 1340 { lab=VDD_PWR}
N 4240 1320 4240 1340 { lab=VDD_PWR}
N 4480 1240 4480 1260 { lab=io_analog[5]}
N 4480 1240 4720 1240 { lab=io_analog[5]}
N 4720 1240 4720 1260 { lab=io_analog[5]}
N 4600 1240 4600 1260 { lab=io_analog[5]}
N 4480 1320 4480 1340 { lab=VDD_PWR}
N 4480 1340 4720 1340 { lab=VDD_PWR}
N 4720 1320 4720 1340 { lab=VDD_PWR}
N 4600 1320 4600 1340 { lab=VDD_PWR}
N 4360 1240 4480 1240 { lab=io_analog[5]}
N 4360 1340 4480 1340 { lab=VDD_PWR}
N 4120 1200 4120 1240 { lab=io_analog[5]}
N 4120 1340 4120 1380 { lab=VDD_PWR}
N 3360 1520 3360 1540 { lab=io_analog[6]}
N 3360 1520 3600 1520 { lab=io_analog[6]}
N 3600 1520 3600 1540 { lab=io_analog[6]}
N 3480 1520 3480 1540 { lab=io_analog[6]}
N 3360 1600 3360 1620 { lab=VDD_PWR}
N 3360 1620 3600 1620 { lab=VDD_PWR}
N 3600 1600 3600 1620 { lab=VDD_PWR}
N 3480 1600 3480 1620 { lab=VDD_PWR}
N 3720 1520 3720 1540 { lab=io_analog[6]}
N 3720 1520 3960 1520 { lab=io_analog[6]}
N 3960 1520 3960 1540 { lab=io_analog[6]}
N 3840 1520 3840 1540 { lab=io_analog[6]}
N 3720 1600 3720 1620 { lab=VDD_PWR}
N 3720 1620 3960 1620 { lab=VDD_PWR}
N 3960 1600 3960 1620 { lab=VDD_PWR}
N 3840 1600 3840 1620 { lab=VDD_PWR}
N 3600 1520 3720 1520 { lab=io_analog[6]}
N 3600 1620 3720 1620 { lab=VDD_PWR}
N 3360 1480 3360 1520 { lab=io_analog[6]}
N 3360 1620 3360 1660 { lab=VDD_PWR}
N 5940 -240 5940 -220 { lab=vssa2}
N 5950 -220 7180 -220 { lab=vssa2}
N 7270 -240 7270 -220 { lab=vssa2}
N 6820 -240 6820 -220 { lab=vssa2}
N 6380 -240 6380 -220 { lab=vssa2}
N 5940 -220 5950 -220 { lab=vssa2}
N 5940 -460 5940 -440 { lab=vdda2}
N 5940 -460 7180 -460 { lab=vdda2}
N 7270 -460 7270 -440 { lab=vdda2}
N 6820 -460 6820 -440 { lab=vdda2}
N 6380 -460 6380 -440 { lab=vdda2}
N 5760 -340 5780 -340 { lab=gpio_analog[12]}
N 6200 -340 6220 -340 { lab=gpio_analog[13]}
N 6640 -340 6660 -340 { lab=gpio_analog[11]}
N 7090 -340 7110 -340 { lab=gpio_analog[17]}
N 5940 60 5940 80 { lab=vssa2}
N 6820 60 6820 80 { lab=vssa2}
N 6380 60 6380 80 { lab=vssa2}
N 5940 -160 5940 -140 { lab=vdda2}
N 6820 -160 6820 -140 { lab=vdda2}
N 6380 -160 6380 -140 { lab=vdda2}
N 5760 -40 5780 -40 { lab=gpio_analog[16]}
N 6200 -40 6220 -40 { lab=gpio_analog[15]}
N 6640 -40 6660 -40 { lab=gpio_analog[14]}
N 7180 -460 7270 -460 { lab=vdda2}
N 7180 -220 7270 -220 { lab=vssa2}
N 5940 -160 6380 -160 { lab=vdda2}
N 6380 -160 6820 -160 { lab=vdda2}
N 5940 80 6380 80 { lab=vssa2}
N 6380 80 6820 80 { lab=vssa2}
N 6780 1100 6780 1120 { lab=io_analog[7]}
N 6780 1100 7020 1100 { lab=io_analog[7]}
N 7020 1100 7020 1120 { lab=io_analog[7]}
N 6900 1100 6900 1120 { lab=io_analog[7]}
N 6900 1080 6900 1100 { lab=io_analog[7]}
N 6780 1180 6780 1200 { lab=vssa2}
N 6780 1200 7020 1200 { lab=vssa2}
N 7020 1180 7020 1200 { lab=vssa2}
N 6900 1180 6900 1200 { lab=vssa2}
N 6900 1200 6900 1220 { lab=vssa2}
N 6440 1220 6900 1220 { lab=vssa2}
N 4020 260 4020 280 {}
N 4170 170 4180 170 {}
C {devices/iopin.sym} 3240 -470 0 0 {name=p1 lab=vdda1}
C {devices/iopin.sym} 3240 -440 0 0 {name=p2 lab=vdda2}
C {devices/iopin.sym} 3240 -410 0 0 {name=p3 lab=vssa1}
C {devices/iopin.sym} 3240 -380 0 0 {name=p4 lab=vssa2}
C {devices/iopin.sym} 3240 -350 0 0 {name=p5 lab=vccd1}
C {devices/iopin.sym} 3240 -320 0 0 {name=p6 lab=vccd2}
C {devices/iopin.sym} 3240 -290 0 0 {name=p7 lab=vssd1}
C {devices/iopin.sym} 3240 -260 0 0 {name=p8 lab=vssd2}
C {devices/ipin.sym} 3290 -190 0 0 {name=p9 lab=wb_clk_i}
C {devices/ipin.sym} 3290 -160 0 0 {name=p10 lab=wb_rst_i}
C {devices/ipin.sym} 3290 -130 0 0 {name=p11 lab=wbs_stb_i}
C {devices/ipin.sym} 3290 -100 0 0 {name=p12 lab=wbs_cyc_i}
C {devices/ipin.sym} 3290 -70 0 0 {name=p13 lab=wbs_we_i}
C {devices/ipin.sym} 3290 -40 0 0 {name=p14 lab=wbs_sel_i[3:0]}
C {devices/ipin.sym} 3290 -10 0 0 {name=p15 lab=wbs_dat_i[31:0]}
C {devices/ipin.sym} 3290 20 0 0 {name=p16 lab=wbs_adr_i[31:0]}
C {devices/opin.sym} 3280 80 0 0 {name=p17 lab=wbs_ack_o}
C {devices/opin.sym} 3280 110 0 0 {name=p18 lab=wbs_dat_o[31:0]}
C {devices/ipin.sym} 3290 150 0 0 {name=p19 lab=la_data_in[127:0]}
C {devices/opin.sym} 3280 180 0 0 {name=p20 lab=la_data_out[127:0]}
C {devices/ipin.sym} 3290 260 0 0 {name=p21 lab=io_in[26:0]}
C {devices/ipin.sym} 3290 290 0 0 {name=p22 lab=io_in_3v3[26:0]}
C {devices/ipin.sym} 3280 570 0 0 {name=p23 lab=user_clock2}
C {devices/opin.sym} 3280 320 0 0 {name=p24 lab=io_out[26:0]}
C {devices/opin.sym} 3280 350 0 0 {name=p25 lab=io_oeb[26:0]}
C {devices/iopin.sym} 3250 410 0 0 {name=p26 lab=gpio_analog[17:0]}
C {devices/iopin.sym} 3250 440 0 0 {name=p27 lab=gpio_noesd[17:0]}
C {devices/iopin.sym} 3250 470 0 0 {name=p29 lab=io_analog[10:0]}
C {devices/iopin.sym} 3250 500 0 0 {name=p30 lab=io_clamp_high[2:0]}
C {devices/iopin.sym} 3250 530 0 0 {name=p31 lab=io_clamp_low[2:0]}
C {devices/opin.sym} 3270 600 0 0 {name=p32 lab=user_irq[2:0]}
C {devices/ipin.sym} 3290 210 0 0 {name=p28 lab=la_oenb[127:0]}
C {analog_subsystem.sym} 4080 -300 0 0 {name=x1}
C {switch_control.sym} 5060 -280 0 0 {name=x2}
C {power_stage.sym} 5100 380 0 0 {name=x3}
C {devices/lab_wire.sym} 4020 -560 0 0 {name=l1 sig_type=std_logic lab=vdda2}
C {devices/lab_wire.sym} 4940 -600 0 0 {name=l2 sig_type=std_logic lab=vdda2}
C {devices/lab_wire.sym} 4140 -560 0 0 {name=l3 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 5180 -600 0 0 {name=l4 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 4820 -440 0 0 {name=l5 sig_type=std_logic lab=io_in_3v3[16]}
C {devices/lab_wire.sym} 4820 -280 0 0 {name=l6 sig_type=std_logic lab=io_in_3v3[14]}
C {devices/lab_wire.sym} 4280 -300 0 1 {name=l7 sig_type=std_logic lab=cycle_end}
C {devices/lab_wire.sym} 4280 -360 0 1 {name=l8 sig_type=std_logic lab=overcurrent}
C {devices/lab_wire.sym} 4820 -400 0 0 {name=l9 sig_type=std_logic lab=io_in_3v3[15]}
C {devices/lab_wire.sym} 4820 -240 0 0 {name=l10 sig_type=std_logic lab=io_in_3v3[13]}
C {devices/lab_wire.sym} 4820 -200 0 0 {name=l11 sig_type=std_logic lab=io_in_3v3[12]}
C {devices/lab_wire.sym} 4820 -160 0 0 {name=l12 sig_type=std_logic lab=io_in_3v3[11]}
C {devices/lab_wire.sym} 4820 -120 0 0 {name=l13 sig_type=std_logic lab=io_in_3v3[10]}
C {devices/lab_wire.sym} 4820 -80 0 0 {name=l14 sig_type=std_logic lab=io_in_3v3[9]}
C {devices/lab_wire.sym} 4820 -40 0 0 {name=l15 sig_type=std_logic lab=io_in_3v3[8]}
C {devices/lab_wire.sym} 4820 -320 0 0 {name=l16 sig_type=std_logic lab=overcurrent}
C {devices/lab_wire.sym} 4820 -360 0 0 {name=l17 sig_type=std_logic lab=cycle_end}
C {devices/lab_wire.sym} 5300 -340 0 1 {name=l18 sig_type=std_logic lab=P_IN}
C {devices/lab_wire.sym} 5300 -300 0 1 {name=l19 sig_type=std_logic lab=P_IN_N}
C {devices/lab_wire.sym} 5300 -240 0 1 {name=l20 sig_type=std_logic lab=N_IN}
C {devices/lab_wire.sym} 5300 -200 0 1 {name=l21 sig_type=std_logic lab=N_IN_N}
C {devices/lab_wire.sym} 4880 240 0 0 {name=l22 sig_type=std_logic lab=VDD_PWR}
C {devices/lab_wire.sym} 3880 -440 0 0 {name=l23 sig_type=std_logic lab=SENSE_FET_KELVIN}
C {devices/lab_wire.sym} 3880 -400 0 0 {name=l24 sig_type=std_logic lab=SENSE_FET}
C {devices/lab_wire.sym} 3880 -360 0 0 {name=l25 sig_type=std_logic lab=SW_NODE_ESD}
C {devices/lab_wire.sym} 5300 -120 0 1 {name=l26 sig_type=std_logic lab=TIMEOUT_OUT}
C {devices/lab_wire.sym} 3880 -180 0 0 {name=l27 sig_type=std_logic lab=TIMEOUT_OUT}
C {devices/lab_wire.sym} 4880 420 0 0 {name=l28 sig_type=std_logic lab=P_IN}
C {devices/lab_wire.sym} 4880 460 0 0 {name=l29 sig_type=std_logic lab=P_IN_N}
C {devices/lab_wire.sym} 4880 520 0 0 {name=l30 sig_type=std_logic lab=N_IN}
C {devices/lab_wire.sym} 4880 560 0 0 {name=l31 sig_type=std_logic lab=N_IN_N}
C {devices/lab_wire.sym} 5320 320 0 1 {name=l33 sig_type=std_logic lab=SENSE_FET_KELVIN}
C {devices/lab_wire.sym} 5320 360 0 1 {name=l34 sig_type=std_logic lab=SENSE_FET}
C {devices/lab_wire.sym} 5320 460 0 1 {name=l35 sig_type=std_logic lab=SW_NODE_ESD}
C {devices/lab_wire.sym} 5320 400 0 1 {name=l36 sig_type=std_logic lab=SW_NODE}
C {devices/lab_wire.sym} 4020 100 0 0 {name=l37 sig_type=std_logic lab=vdda2}
C {devices/lab_wire.sym} 4020 280 0 0 {name=l38 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 4190 210 0 1 {name=l39 sig_type=std_logic lab=timeout_int}
C {devices/lab_wire.sym} 4820 -480 0 0 {name=l40 sig_type=std_logic lab=timeout_int}
C {devices/lab_wire.sym} 4000 -40 0 0 {name=l41 sig_type=std_logic lab=gpio_analog[17]}
C {devices/lab_wire.sym} 4060 0 0 0 {name=l45 sig_type=std_logic lab=gpio_analog[16]}
C {devices/lab_wire.sym} 4140 40 0 0 {name=l46 sig_type=std_logic lab=gpio_analog[15]}
C {devices/lab_wire.sym} 3850 190 0 0 {name=l42 sig_type=std_logic lab=gpio_analog[14]}
C {devices/lab_wire.sym} 3880 -280 0 0 {name=l43 sig_type=std_logic lab=gpio_analog[13]}
C {devices/lab_wire.sym} 3880 -320 0 0 {name=l44 sig_type=std_logic lab=gpio_analog[12]}
C {devices/lab_wire.sym} 3880 -240 0 0 {name=l47 sig_type=std_logic lab=gpio_analog[11]}
C {devices/lab_wire.sym} 4280 -220 0 1 {name=l48 sig_type=std_logic lab=gpio_analog[10]}
C {res_generic_m2.sym} 5300 850 2 0 {name=R17
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5180 850 2 0 {name=R18
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5420 850 2 0 {name=R19
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 5300 760 0 1 {name=l74 sig_type=std_logic lab=io_analog[3]}
C {res_generic_m2.sym} 5680 850 2 0 {name=R20
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5560 850 2 0 {name=R21
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5800 850 2 0 {name=R22
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 6060 850 2 0 {name=R23
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5940 850 2 0 {name=R24
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 6180 850 2 0 {name=R25
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 5680 760 0 1 {name=l75 sig_type=std_logic lab=io_analog[2]}
C {devices/lab_wire.sym} 6060 760 0 1 {name=l76 sig_type=std_logic lab=io_analog[1]}
C {devices/lab_wire.sym} 5680 980 0 1 {name=l70 sig_type=std_logic lab=SW_NODE}
C {res_generic_m2.sym} 5300 1150 2 0 {name=R14
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5180 1150 2 0 {name=R15
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5420 1150 2 0 {name=R16
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5680 1150 2 0 {name=R26
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5560 1150 2 0 {name=R27
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5800 1150 2 0 {name=R28
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 6060 1150 2 0 {name=R29
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 5940 1150 2 0 {name=R30
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 6180 1150 2 0 {name=R31
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 6440 1150 2 0 {name=R32
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 6320 1150 2 0 {name=R33
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 6560 1150 2 0 {name=R34
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 5300 1080 0 1 {name=l71 sig_type=std_logic lab=io_analog[10]}
C {devices/lab_wire.sym} 5680 1080 0 1 {name=l72 sig_type=std_logic lab=io_analog[9]}
C {devices/lab_wire.sym} 6060 1080 0 1 {name=l73 sig_type=std_logic lab=io_analog[8]}
C {devices/lab_wire.sym} 6440 1080 0 1 {name=l77 sig_type=std_logic lab=io_analog[0]}
C {res_generic_m2.sym} 3420 950 2 0 {name=R10
W=11
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 3420 1020 0 1 {name=l50 sig_type=std_logic lab=io_clamp_high[0]}
C {res_generic_m2.sym} 3580 950 2 0 {name=R11
W=11
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 3580 1020 0 1 {name=l67 sig_type=std_logic lab=io_clamp_low[0]}
C {res_generic_m2.sym} 3880 950 2 0 {name=R4
W=11
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 4040 950 2 0 {name=R5
W=11
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 3880 1020 0 1 {name=l53 sig_type=std_logic lab=io_clamp_high[2]}
C {devices/lab_wire.sym} 4040 1020 0 1 {name=l55 sig_type=std_logic lab=io_clamp_low[2]}
C {res_generic_m2.sym} 4340 950 2 0 {name=R8
W=11
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 4500 950 2 0 {name=R9
W=11
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 4340 1020 0 1 {name=l62 sig_type=std_logic lab=io_clamp_high[1]}
C {devices/lab_wire.sym} 4500 1020 0 1 {name=l64 sig_type=std_logic lab=io_clamp_low[1]}
C {res_generic_m2.sym} 3480 1290 2 0 {name=R6
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3360 1290 2 0 {name=R7
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3600 1290 2 0 {name=R12
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3840 1290 2 0 {name=R13
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3720 1290 2 0 {name=R35
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3960 1290 2 0 {name=R36
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 4240 1290 2 0 {name=R37
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 4120 1290 2 0 {name=R38
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 4360 1290 2 0 {name=R39
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 4600 1290 2 0 {name=R40
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 4480 1290 2 0 {name=R41
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 4720 1290 2 0 {name=R42
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3480 1570 2 0 {name=R43
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3360 1570 2 0 {name=R44
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3600 1570 2 0 {name=R45
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3840 1570 2 0 {name=R46
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3720 1570 2 0 {name=R47
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 3960 1570 2 0 {name=R48
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 3360 1200 0 1 {name=l56 sig_type=std_logic lab=io_analog[4]}
C {devices/lab_wire.sym} 4120 1200 0 1 {name=l57 sig_type=std_logic lab=io_analog[5]}
C {devices/lab_wire.sym} 3360 1480 0 1 {name=l58 sig_type=std_logic lab=io_analog[6]}
C {devices/lab_wire.sym} 3360 1380 0 0 {name=l59 sig_type=std_logic lab=VDD_PWR}
C {devices/lab_wire.sym} 4120 1380 0 0 {name=l69 sig_type=std_logic lab=VDD_PWR}
C {devices/lab_wire.sym} 3360 1660 0 0 {name=l79 sig_type=std_logic lab=VDD_PWR}
C {esd_cell.sym} 5940 -340 0 0 {name=x5}
C {esd_cell.sym} 6380 -340 0 0 {name=x6}
C {esd_cell.sym} 6820 -340 0 0 {name=x7}
C {esd_cell.sym} 7270 -340 0 0 {name=x8}
C {devices/lab_wire.sym} 5940 -460 0 1 {name=l49 sig_type=std_logic lab=vdda2}
C {devices/lab_wire.sym} 6040 -220 0 1 {name=l51 sig_type=std_logic lab=vssa2}
C {esd_cell.sym} 5940 -40 0 0 {name=x9}
C {esd_cell.sym} 6380 -40 0 0 {name=x10}
C {esd_cell.sym} 6820 -40 0 0 {name=x11}
C {devices/lab_wire.sym} 5940 -160 0 1 {name=l60 sig_type=std_logic lab=vdda2}
C {devices/lab_wire.sym} 6040 80 0 1 {name=l65 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 5760 -340 0 0 {name=l80 sig_type=std_logic lab=gpio_analog[12]}
C {devices/lab_wire.sym} 6200 -340 0 0 {name=l81 sig_type=std_logic lab=gpio_analog[13]}
C {devices/lab_wire.sym} 6640 -340 0 0 {name=l82 sig_type=std_logic lab=gpio_analog[11]}
C {devices/lab_wire.sym} 7090 -340 0 0 {name=l83 sig_type=std_logic lab=gpio_analog[17]}
C {devices/lab_wire.sym} 5760 -40 0 0 {name=l84 sig_type=std_logic lab=gpio_analog[16]}
C {devices/lab_wire.sym} 6200 -40 0 0 {name=l85 sig_type=std_logic lab=gpio_analog[15]}
C {devices/lab_wire.sym} 6640 -40 0 0 {name=l86 sig_type=std_logic lab=gpio_analog[14]}
C {devices/code.sym} 4510 -730 0 0 {name=s1 only_toplevel=true value="
.include /usr/share/pdk/sky130A/libs.ref/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice
"}
C {res_generic_m2.sym} 6900 1150 2 0 {name=R1
W=25
L=1
model=res_generic_m4
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 6780 1150 2 0 {name=R2
W=25
L=1
model=res_generic_m3
spiceprefix=R
mult=1}
C {res_generic_m2.sym} 7020 1150 2 0 {name=R3
W=25
L=1
model=res_generic_m5
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 6900 1080 0 1 {name=l87 sig_type=std_logic lab=io_analog[7]}
C {devices/lab_wire.sym} 5300 1260 0 1 {name=l32 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 4500 880 0 1 {name=l54 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 4040 880 0 1 {name=l63 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 3580 880 0 1 {name=l68 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 4880 320 0 0 {name=l78 sig_type=std_logic lab=vssa2}
C {devices/lab_wire.sym} 4340 880 0 0 {name=l61 sig_type=std_logic lab=VDD_PWR}
C {devices/lab_wire.sym} 3880 880 0 0 {name=l52 sig_type=std_logic lab=VDD_PWR}
C {devices/lab_wire.sym} 3420 880 0 0 {name=l66 sig_type=std_logic lab=VDD_PWR}
C {oscillator.sym} 4020 190 0 0 {name=x4}
C {devices/lab_wire.sym} 4180 170 0 1 {name=l88 sig_type=std_logic lab=gpio_analog[0]}
