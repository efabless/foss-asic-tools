#!/usr/bin/ruby
# usage: gdsLyrdel.rb <gdsInFile> <gdsOutFile> <layerNumToDel> <dataTypeNumToDel>
#
# Runs klayout (in batch) to flatten the topCell to a new output file.
# Script starts as regular ruby, then exec's via klayout passing self to it.
# (klayout requirement is this script-name *must* end in .rb).
#
InKlayout=$InKlayout
if InKlayout.to_s.empty?
  thisScript = $0
  mode="flat"
  argvLenReq = 4

  fin = ARGV[0]
  fout = ARGV[1]
  lnum = ARGV[2]
  dnum = ARGV[3]

  if fin == "--version" || fin == "-v"
    exec "klayout -nc -zz -rx -v"
  end

  if ARGV.length != argvLenReq
    puts "ERROR, must give four non-option arguments, usage: gdsLyrdel.rb <gdsInFile> <gdsOutFile> <layerNumToDel> <dataTypeNumToDel>"
    puts 'Output format inferred from gdsOutFile: .gds[.gz] -> "GDS2", .oas[.gz] -> "OASIS"'
    exit 1
  end


  # construct command from our script arguments, replace self with klayout...
  exec "klayout -nc -zz -rx -r #{thisScript} -rd lnum=#{lnum} -rd dnum=#{dnum} -rd file=#{fin} -rd fileOut=#{fout} -rd InKlayout=1"
end

#
#   -d : debug level, no details during GDS-reading however, try 20 or 40 or (timing too:) 21 or 41
#   -z/-zz : -z pseudo-batch mode, still needs X-DISPLAY connection; -zz true batch
#   -nc : don't use/update configuration file
#   -rx : disable built-in macros, stuff not needed for batch usually
#   -rd : define variables the script can reference
#

fin = $file
fout = $fileOut
lnum = $lnum.to_i
dnum = $dnum.to_i

puts "got: fin='#{fin}' fout='#{fout}' lnum='#{lnum}' dnum='#{dnum}'"


include RBA
 
begin
  puts "Reading file #{fin}"
  # make new layout and editable.
  layout = Layout.new(true)
  layout.read(fin)

  lpp = layout.find_layer(lnum, dnum)
  if lpp
    puts "deleting layer: #{lnum}/#{dnum}"
    STDOUT.flush
    layout.delete_layer(lpp)
  else
    STDERR.puts "ERROR: layer not found: #{lnum}/#{dnum}"
    STDERR.flush
    exit 1
  end

  # Infer format from output filename (i.e *.oas => "OASIS")
  slo = SaveLayoutOptions.new
  slo.set_format_from_filename(fout)

  # save cell and its sub-hier
  puts "Writing file #{fout} format:#{slo.format} ..."
  layout.write(fout, slo)
end

puts "Done."

