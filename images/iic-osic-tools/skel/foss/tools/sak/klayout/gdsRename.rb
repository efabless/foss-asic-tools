#!/usr/bin/ruby
# usage: gdsRename.rb <gdsFile> <gdsOutFile> <cellNameFrom> <cellNameTo>
#
# Runs klayout (in batch) to rename a cell and write a new output file.
# Script starts as regular ruby, then exec's via klayout passing self to it.
# (klayout requirement is this script-name *must* end in .rb).
#
InKlayout=$InKlayout
if InKlayout.to_s.empty?
  thisScript = $0
  argvLenReq = 4

  f1 = ARGV[0]

  if f1 == "--version" || f1 == "-v"
    exec "klayout -nc -zz -rx -v"
  end

  if ARGV.length != argvLenReq
    puts "ERROR, 4 arguments required, usage: gdsRename.rb <gdsFile> <gdsOutFile> <cellNameFrom> <cellNameTo>"
    exit 1
  end

  f2 = ARGV[1]
  c1 = ARGV[2]
  c2 = ARGV[3]

  # construct command from our script arguments, replace self with klayout...
  # puts "got: f1='#{f1}' f2='#{f2}' c1='#{c1}' c2='#{c2}'"
  exec "klayout -nc -zz -rx -rd InKlayout=1 -rd file1=#{f1} -rd file2=#{f2} -rd cell1=#{c1} -rd cell2=#{c2} -r #{thisScript}"
end

#
#   -d : debug level, no details during GDS-reading however, try 20 or 40 or (timing too:) 21 or 41
#   -z/-zz : -z pseudo-batch mode, still needs X-DISPLAY connection; -zz true batch
#   -nc : don't use/update configuration file
#   -rx : disable built-in macros, stuff not needed for batch usually
#   -rd : define variables the script can reference
#

f1 = $file1
f2 = $file2
c1 = $cell1
c2 = $cell2
# puts "got: f1='#{f1}' f2='#{f2}' c1='#{c1}' c2='#{c2}'"

if f1 == "" || f2 == "" || c1 == "" || c2 == ""
  puts "ERROR, 4 arguments required, usage: gdsRename.rb <gdsFile> <gdsOutFile> <cellNameFrom> <cellNameTo>"
  exit 1
end

if c1 == c2
  puts "ERROR, cellFrom=#{c1} & cellTo=#{c2} cannot be the same."
  exit 1
end

include RBA
 
begin
  puts "Reading file #{f1}"
  # make new layout and editable (since we'll flatten)
  layout = Layout.new(true)
  layout.read(f1)

  cell1 = layout.cell(c1)
  if cell1.to_s.empty?
    puts "ERROR: couldn't open the cell #{c1}"
    exit 1
  end

  cell2 = layout.cell(c2)
  if ! cell2.to_s.empty?
    puts "ERROR: replacement cellTo #{c2} already exists in source file #{f1}"
    exit 1
  end

  layout.rename_cell(cell1.cell_index, c2)
  puts "renamed cell: #{c1} to #{c2}"

  # save to file2
  puts "Writing file #{f2}"
  layout.write(f2)

end

puts "Done."
