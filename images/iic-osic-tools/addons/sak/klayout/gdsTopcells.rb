#!/usr/bin/ruby
# usage: gdsTopcells.rb <gdsFile>
#
# Runs klayout (in batch) to read gdsFile, and enumerate topcell(s) to STDOUT one per line.
# Script starts as regular ruby, then exec's via klayout passing self to it.
# (klayout requirement is this ruby script-name *must* end in .rb).
#
InKlayout=$InKlayout
if InKlayout.to_s.empty?
  thisScript = $0
  f = ARGV[0]

  if f == "--version" || f == "-v"
    exec "klayout -nc -zz -rx -v"
  end

  if ARGV.length != 1
    puts "ERROR, must give one argument, usage: gdsTopcells.rb <gdsFile>"
    exit 1
  end

  # construct command from our script arguments, replace self with klayout...
  exec "klayout -nc -zz -rx -rd InKlayout=1 -rd file=#{f} -r #{thisScript}"

end

#
#   -d : debug level, no details during GDS-reading however, try 20 or 40 or (timing too:) 21 or 41
#   -z/-zz : -z pseudo-batch mode, still needs X-DISPLAY connection; -zz true batch
#   -nc : don't use/update configuration file
#   -rx : disable built-in macros, stuff not needed for batch usually
#   -rd : define variables the script can reference
#

f = $file

if f == ""
  puts "ERROR: missing gdsFile argument"
  exit 1
end

begin

ly = RBA::Layout::new
ly.read(f)

ly.top_cells.each { |curCell|
  puts "#{curCell.name}"
}
exit 0
end
