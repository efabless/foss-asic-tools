load current_sense.mag
box 0 0 0 0

flatten current_sense_extracted
load current_sense_extracted
box -100um -100um 100um 100um 

extract all
ext2spice lvs
ext2spice -o current_sense_lvs.spice
