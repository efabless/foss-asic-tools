#!/usr/bin/ruby
# usage: gdsSize.rb <gdsFile> <cellName>
#
# Runs klayout (in batch) to get bbox of a cell in a GDS file.
# Script starts as regular ruby, then exec's via klayout passing self to it.
# (klayout requirement is this script-name *must* end in .rb).
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

  if ARGV.length != 2
    puts "ERROR, must give two arguments, usage: gdsSize.rb <gdsFile> <cellName>"
    puts "  It's an error if <cellName> unbound (referenced by others, not defined)."
    puts "  But that's the only unbound checked, no other cells checked or reported."
    puts "Exit-status: 0 on success; 1 on I/O or usage error; 2 unbound. See also gdsAllcells.rb"
    exit 1
  end


  # construct command from our script arguments, replace self with klayout...
  exec "klayout -nc -zz -rx -rd InKlayout=1 -rd file=#{f} -rd topcell=#{c} -r #{thisScript}"
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
c = $topcell

if f == ""
  STDERR.puts "ERROR: missing gdsFile argument, usage: gdsSize.rb <gdsFile> <cellName>"
  exit 1
elsif c == ""
  STDERR.puts "ERROR: missing cellName argument, usage: gdsSize.rb <gdsFile> <cellName>"
  exit 1
end

include RBA
 
begin
  puts "Reading file #{f} for cell #{c}"
  layout = Layout.new
  layout.read(f)
  dbu = layout.dbu
  puts "dbu=#{dbu}"

  errs = 0
  
  # does not catch case where cell.bbox -> "()"
  if ! layout.has_cell?(c)
    STDERR.puts "ERROR: layout does not have the cell #{c}"
    STDOUT.flush
    STDERR.flush
    Kernel.exit! 1
  end

  cell = layout.cell(c)
  if cell.to_s.empty?
    STDERR.puts "ERROR: couldn't open the cell #{c}"
    STDOUT.flush
    STDERR.flush
    Kernel.exit! 1
  end

  bbox = cell.bbox
  bbox_str = bbox.to_s
  puts "cell #{c} dbu-bbox(ll;ur)=#{bbox}"

  if bbox_str == "()"
    STDERR.puts "ERROR: no or empty bbox for the cell #{c}"
    errs = errs + 1
  else    
    l = bbox.left
                   b = bbox.bottom
    r = bbox.right
                   t = bbox.top
    w = r - l
                   h = t - b
    puts "cell #{c} dbu-bbox(left,bottom,right,top)=(#{l},#{b},#{r},#{t})"
    puts "cell #{c} dbu-size(width,height)=(#{w},#{h})"
    l = l * dbu
                   b = b * dbu
    r = r * dbu
                   t = t * dbu
    w = w * dbu
                   h = h * dbu
    puts "cell #{c} micron-bbox(left,bottom,right,top)=(#{l},#{b},#{r},#{t})"
    puts "cell #{c} micron-size(width,height)=(#{w},#{h})"
  end

end

puts "Done."

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
