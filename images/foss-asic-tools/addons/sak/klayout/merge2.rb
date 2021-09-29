# merge2.rb 
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

# store and take away the cell names of all cells read so far
# (by setting the cell name to "" the cells basically become invisible for
# the following read)
cell_names = { }
(0..(layout.cells-1)).each do |ci|
  cell_names[ci] = layout.cell_name(ci)
  layout.rename_cell(ci, "") # this prevents a name clash on the next read
end

# read the second file which basically performs the merge
load_layout_options = RBA::LoadLayoutOptions.new
load_layout_options.set_layer_map(lmap, true)
layout.read($file2, load_layout_options)

# rename the cells by using prefix "A" for layout 1 and "B" for layout 2
(0..(layout.cells-1)).each do |ci|
  if cell_names[ci]  
    layout.rename_cell(ci, cell_names[ci])
  else
    layout.rename_cell(ci, "B" + layout.cell_name(ci))
  end
end

ind = 0
ind2 = 0

layout.each_cell do |c|
    # change and the instances

    if c.name == "user_project_wrapper"
        ind = Integer(c.cell_index)
        puts ind
    elsif c.name == "Buser_project_wrapper"
        ind2 = Integer(c.cell_index)
        puts ind2
    end
end

layout.each_cell do |c|
    c.each_inst do |inst|
        if inst.cell_index.equal? ind
            # get the instance object and create a new one with the new cell index
            i = inst.cell_inst
            trans = i.is_complex? ? i.cplx_trans : i.trans
            c.replace(inst, RBA::CellInstArray.new(ind2, trans))
        end

    end

end

layout.delete_cell(ind)
layout.rename_cell(ind2, "user_project_wrapper")
layout.write($output)