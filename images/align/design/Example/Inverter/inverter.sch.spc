** sch_path: /foss/designs/ALIGN-Tests/Inverter3/inverter.sch
.subckt inverter A Y VDD VSS
*.PININFO A:I Y:O VDD:B VSS:B
.param Wn=1.05
.param L=0.15
.param Wp=0.84
XM2 Y A VDD VDD sky130_fd_pr__pfet_01v8 L=L W='Wp * 2' nf=2 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM1 Y A VSS VSS sky130_fd_pr__nfet_01v8 L=L W='Wn * 2' nf=2 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends
.end
