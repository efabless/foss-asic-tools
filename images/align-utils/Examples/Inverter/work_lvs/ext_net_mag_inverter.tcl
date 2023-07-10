load ../work_magic/inverter_lvs.mag
select top cell
extract all
ext2spice lvs
ext2spice merge conservative
ext2spice -o inverter.ext.spc
quit
