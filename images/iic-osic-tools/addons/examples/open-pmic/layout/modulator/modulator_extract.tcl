load modulator.mag
box 0 0 0 0

#flatten modulator_extracted
#load modulator_extracted
box -100um -100um 100um 100um 


extract all
ext2spice lvs
ext2spice -o modulator_lvs.spice
