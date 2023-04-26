#!/usr/bin/ruby
# usage: gdsFlat.rb <gdsFile> <topCellName> <gdsOutFile>
#
# Runs klayout (in batch) to flatten the topCell to a new output file.
# Script starts as regular ruby, then exec's via klayout passing self to it.
# (klayout requirement is this script-name *must* end in .rb).
#
InKlayout=$InKlayout
if InKlayout.to_s.empty?
  thisScript = $0
  mode="flat"
  argvLenReq = 3

  f = ARGV[0]
  c = ARGV[1]
  fout = ARGV[2]

  if f == "--version" || f == "-v"
    exec "klayout -nc -zz -rx -v"
  end

  if f == "--hier"
    argvLenReq = 4
    mode="hier"
    f = ARGV[1]
    c = ARGV[2]
    fout = ARGV[3]
  end

  if ARGV.length != argvLenReq
    puts "ERROR, must give three non-option arguments, usage: gdsFlat.rb [--hier] <gdsFile> <topCellName> <gdsOutFile>"
    puts 'Output format inferred from gdsOutFile: .gds[.gz] -> "GDS2", .oas[.gz] -> "OASIS"'
    exit 1
  end


  # construct command from our script arguments, replace self with klayout...
  # puts "got: mode='#{mode}' f='#{f}' c='#{c}' fout='#{fout}'"
  exec "klayout -nc -zz -rx -rd InKlayout=1 -rd mode=#{mode} -rd file=#{f} -rd topcell=#{c} -rd fileOut=#{fout} -r #{thisScript}"
end

#
#   -d : debug level, no details during GDS-reading however, try 20 or 40 or (timing too:) 21 or 41
#   -z/-zz : -z pseudo-batch mode, still needs X-DISPLAY connection; -zz true batch
#   -nc : don't use/update configuration file
#   -rx : disable built-in macros, stuff not needed for batch usually
#   -rd : define variables the script can reference
#

m = $mode
f = $file
c = $topcell
fout = $fileOut

# puts "got: m='#{m}' f='#{f}' c='#{c}' fout='#{fout}'"

if f == ""
  puts "ERROR: missing gdsFile argument, usage: gdsFlat.rb <gdsFile> <topCellName> <gdsOutFile>"
  exit 1
elsif c == ""
  puts "ERROR: missing gdsFile argument, usage: gdsFlat.rb <gdsFile> <topCellName> <gdsOutFile>"
  exit 1
elsif fout == ""
  puts "ERROR: missing gdsFile argument, usage: gdsFlat.rb <gdsFile> <topCellName> <gdsOutFile>"
  exit 1
end

if m == "hier"
  puts "WARNING: hierarchical output is experimental (needs more testing)."
elsif m != "flat"
  puts "ERROR: mode, '#{m}' is unknown/unsupported."
  exit 1
end

include RBA
 
begin
  puts "Reading file #{f} for topcell #{c}"
  # make new layout. Also editable: needed for flatten only (SLOWER, avoid if possible)
  if m == "flat"
    layout = Layout.new(true)
  else
    layout = Layout.new(false)
  end
  layout.read(f)

  cell = layout.cell(c)
  if cell.to_s.empty?
    puts "couldn't open the cell #{c}"
    exit 1
  end

  # flatten cell (i.e. each instance replaced with direct content)?
  if m == "flat"
    puts "Flattening topcell #{c}"
    cell.flatten(true)
  end
  # flatten within each subcell only?
  # cell.each_child_cell do |subcellName|
  #     subcell = layout.cell(subCellName)
  #     subcell.flatten(true)
  # end 

  # make options that say: save just one cell (and its sub-hier)
  slo = SaveLayoutOptions.new
  cellNdx = cell.cell_index
  slo.add_cell(cellNdx)

  # format="OASIS"
  # compress = false
  # slo.format=format
  # ...
  # layout.write(fout, compress, slo)

  # Infer format from output filename (i.e *.oas => "OASIS")
  slo.set_format_from_filename(fout)

  # save (usually flattened) cell (and its sub-hier)
  puts "Writing file #{fout} format:#{slo.format} for topcell: #{c} and sub-hier"
  layout.write(fout, slo)

end

puts "Done."

