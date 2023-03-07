** sch_path: /foss/designs/ALIGN-Tests/Inverter3/inverter.sch
.subckt inverter A Y VDD VSS
*.PININFO A:I Y:O VDD:B VSS:B
XM2 Y A VDD VDD sky130_fd_pr__pfet_01v8 W=0.84e-6 L=0.15e-6 nf=2 m=1
XM1 Y A VSS VSS sky130_fd_pr__nfet_01v8 W=1.05e-6 L=0.15e-6 nf=2 m=1
.ends
.end
