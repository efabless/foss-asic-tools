load oscillator.mag
box 0 0 0 0

flatten oscillator_extracted
load oscillator_extracted
box -200um -200um 200um 200um 

extract all
ext2spice lvs
ext2spice -o oscillator_lvs.spice

# extract all
# ext2sim labels on
# ext2sim
# extresist tolerance 10
# extresist
# ext2spice lvs
# ext2spice cthresh 0.01
# ext2spice -o oscillator_pex.spice
# ext2spice extresist on
# ext2spice -o oscillator_w_res_pex.spice
