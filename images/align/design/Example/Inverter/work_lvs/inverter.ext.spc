* NGSPICE file created from inverter_lvs.ext - technology: sky130A

.subckt inverter_lvs
X0 Y A VDD VDD sky130_fd_pr__pfet_01v8 ad=2.352e+11p pd=2.24e+06u as=4.452e+11p ps=4.42e+06u w=840000u l=150000u
X1 VDD A Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X2 Y A VSS VSS sky130_fd_pr__nfet_01v8 ad=2.94e+11p pd=2.66e+06u as=5.565e+11p ps=5.26e+06u w=1.05e+06u l=150000u
X3 VSS A Y VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
.ends

