load folded_cascode_n_in 
box 0 0 0 0 
flatten folded_cascode_n_in_extracted
load folded_cascode_n_in_extracted
box -100um -100um 100um 100um 
port ibias index 1
port in_m index 2 
port in_p index 3
port out index 4
port vdd index 5
port vss index 6


extract all
ext2spice lvs
ext2spice -o folded_cascode_n_lvs.spice

extract all
ext2sim labels on
ext2sim
extresist tolerance 10
extresist
ext2spice lvs
ext2spice cthresh 0.01
ext2spice -o folded_cascode_n_pex.spice
ext2spice extresist on
ext2spice -o folded_cascode_n_w_res_pex.spice
