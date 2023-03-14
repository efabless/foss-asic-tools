drc off
box 0 0 0 0
cellname rename vtop
gds readonly false
gds warning redirect inverter.mag.log
gds read ../work_align/INVERTER_0
cellname rename INVERTER_0 inverter
load inverter
select top cell
writeall force
select top cell
flatten inverter_lvs
writeall force
quit -noprompt
