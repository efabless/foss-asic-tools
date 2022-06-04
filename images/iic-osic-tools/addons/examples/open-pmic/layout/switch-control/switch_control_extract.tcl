load switch_control.mag
box 0 0 0 0

#flatten switch_control_extracted
#load switch_control_extracted
box -100um -100um 100um 100um 


extract all
ext2spice lvs
ext2spice -o switch_control_lvs.spice
