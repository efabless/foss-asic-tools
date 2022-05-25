load bias_distribution
box 0 0 0 0

flatten bias_distribution_extracted
load bias_distribution_extracted
box -100um -100um 100um 100um 

extract all
ext2spice lvs
ext2spice -o bias_distribution_lvs.spice

extract all
ext2sim labels on
ext2sim
extresist tolerance 10
extresist
ext2spice lvs
ext2spice cthresh 0.01
ext2spice -o bias_distribution_pex.spice
ext2spice extresist on
ext2spice -o bias_distribution_w_res_pex.spice