#!/usr/bin/ruby
# usage: gdsLayers.rb <gdsFile> 
# LIMITATION: effectively sees/processes layers present in all cells,
# not just the hierarchy of "the" one topcell of interest. i.e. Can be
# multiple topcells, where only the hier. of the "extra" topcells have
# certain layers; where better is to limit output to layers in the hier.
# of just one specific topcell.
#
# TODO: take optional topcell argument: If present, delete the other
# topcells, and loop, until just that one topcell is left. (Assumes
# deleting a topcell will expose/promote subcells as new topcells).
#
# Runs klayout (in batch) to print layer-info of all layers present in a GDS file.
# Script starts as regular ruby, then exec's via klayout passing self to it.
# (klayout requirement is this script-name *must* end in .rb).
# based on ://www.klayout.de/staging/forum/discussion/1066/extract-layer-list-and-top-cell-name-from-gds-file
#
InKlayout=$InKlayout
if InKlayout.to_s.empty?
  thisScript = $0
  f = ARGV[0]
  c = ARGV[1]

  if f == "--version" || f == "-v"
    # these options don't prevent klayout from initializing ~/.klayout unfortunately...
    exec "klayout -nc -rx -zz -v"
  end

  if ARGV.length != 1
    puts "ERROR, must give one argument, usage: gdsLayers.rb <gdsFile>"
    puts "LIMITATION: effectively outputs layers from any cell, i.e. not limited to"
    puts "layers used in hierarchy of just one topcell (if they are multiple topcells)."
    puts "Work-around: 1st isolate the hier. of just one top cell via:"
    puts "  gdsFlat.rb --hier <gds> <topcell> <outTmpGds> && gdsLayers.rb <outTmpGds>"
    puts "Exit-status: 0 on success; 1 on I/O or usage error. See also gdsAllcells.rb"
    exit 1
  end


  # construct command from our script arguments, replace self with klayout...
  exec "klayout -nc -zz -rx -rd InKlayout=1 -rd file=#{f} -r #{thisScript}"
end

#
# to just read a gds in batch (no useful info printed):
#   klayout -d 40 -z xyz.gds >& klayout.read.log
#
#   -d : debug level, no details during GDS-reading however, try 20 or 40 or (timing too:) 21 or 41
#   -z/-zz : -z pseudo-batch mode, still needs X-DISPLAY connection; -zz true batch
#   -nc : don't use/update configuration file
#   -rx : disable built-in macros, stuff not needed for batch usually
#   -rd : define variables the script can reference
#

f = $file

if f == ""
  STDERR.puts "ERROR: missing gdsFile argument, usage: gdsLayers.rb <gdsFile>"
  exit 1
end

include RBA
 
begin
  STDERR.puts "Reading file #{f}"
  layout = Layout.new
  layout.read(f)
  # dbu = layout.dbu
  # STDERR.puts "dbu=#{dbu}"

  errs = 0
  
  STDERR.puts "Layers:"
  STDERR.flush
  layout.layer_indices.each do |layer_id|
    layer_info = layout.get_info(layer_id)
    puts layer_info.to_s
  end

end

# STDERR.puts "Done."

# reserve status=1 for I/O errors
if errs > 0
  errs = errs + 1
end
# don't roll-over exit-status to/past zero
if errs > 255
  errs = 255
end

# exit doesn't work to set status; exit! requires explicit buffered-IO flush.
STDOUT.flush
STDERR.flush
Kernel.exit! errs
