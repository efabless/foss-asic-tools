# merge.rb 
#
# Merges two files into one
#
# Run this script with 
#   klayout -rd file1=first_file.gds -rd file2=second_file.gds -rd output=output_file.gds -z -r merge_files.rb
#
# (Note: -z puts KLayout into non-GUI mode)
#
# Read the first layout
layout = RBA::Layout.new
lmap = layout.read($file1)

# read the second file which basically performs the merge
load_layout_options = RBA::LoadLayoutOptions.new
load_layout_options.set_layer_map(lmap, true)
layout.read($file2, load_layout_options)


layout.write($output)