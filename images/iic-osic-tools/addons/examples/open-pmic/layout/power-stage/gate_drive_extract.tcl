load gate_drive
box 0 0 0 0

flatten gate_drive_extracted
load gate_drive_extracted
box -100um -100um 100um 100um 

extract all
ext2spice lvs
ext2spice -o gate_drive_lvs.spice

extract all
ext2sim labels on
ext2sim
extresist tolerance 10
extresist
ext2spice lvs
ext2spice cthresh 0.01
ext2spice -o gate_drive_pex.spice
ext2spice extresist on
ext2spice -o gate_drive_w_res_pex.spice