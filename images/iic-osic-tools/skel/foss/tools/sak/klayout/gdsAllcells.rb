#!/usr/bin/ruby
# usage: gdsAllcells.rb [-U|-E] [-V] <gdsFile>
#
# Runs klayout (in batch) to read gdsFile, and enumerate all cellnames to STDOUT one per line.
# Script starts as regular ruby, then exec's via klayout passing self to it.
# (klayout requirement is this ruby script-name *must* end in .rb).
#
# -U : print unbound ("ghost") cells only; default is to print all cells incl/ unbound.
#      Does not change STDERR output; does not change exit-status behavior.
# -E : print empty cells only; all "ghost" cells are empty too, but not all empty are ghost/unbound.
# -V : verbose-mode, each line of output, after cellname 1st-word, shows bbox & types of the cell
# Unbounds ALWAYS generate STDERR messages, a summary count error message, and set exit-status.
#
# For "unbound" cells STDERR messages are printed
# and exit-status is incremented (thus non-zero).
#
# Exit-status:
#  I/O errors: 1
#  usage-error (missing arg): 1
#  unbound-cells: 1+number-of-unbounds (up to a maximum of 255)
# The exit status-range 2...255 indicates existence of unbounds.
# WARNING: thus status=255 indistinguishable from: there are 254 OR MORE unbounds.
#
prog="gdsAllcells.rb"
usage = "Usage: #{prog} [options] <gdsFile>"

InKlayout=$InKlayout
if InKlayout.to_s.empty?
  thisScript = $0
  mode = "default"
  verbose = 0
  empty = 0
  argvLenReq = 1    # min-# args, after options -U -V

  require 'optparse'

  argSum = ARGV.join(' ')
  if ARGV.empty?
    ARGV << '--help'
  end

  OptionParser.new do |opts|
    opts.banner = usage
    opts.on("-v", "--version", "version: pass-thru, JUST show klayout version") do
      exec "klayout -nc -zz -rx -v"
    end
    opts.on("-V", "verbose-mode, each line of output, after cellname 1st-word, shows bbox & types of the cell") do
      verbose = 1
    end
    opts.on("-U", "print unbound (ghost) cells only; default prints all incl. unbound") do
      mode = "unbound"
    end
    opts.on("-E", "print empty cells only (ghosts are empty too); default prints all incl. empty; overrides -U") do
      empty = 1
    end
    opts.on("-h", "--help", "show usage") do
      puts opts
      exit 1
    end
    opts.on("--usage", "show usage") do
      puts opts
      exit 1
    end
  end.parse!

  # -E is superset of -U. We do this here, so -E overrides -U if both were given in any order.
  mode = "empty" if empty == 1

  if ARGV.length != argvLenReq
    puts "ERROR, must give one non-option argument, usage: gdsAllcells.rb [-U|-E] [-V] <gdsFile>"
    puts "  -U : just print unbound(ghost) cells (referenced, not defined); instead of all cells."
    puts "  -E : just print empty cells (ghosts are empty too); instead of all cells."
    puts "  -V : verbose-mode, each line of output, after cellname 1st-word, shows bbox & types of the cell."
    puts "  Regardless of -U or not, stderr messages are printed for unbound cells."
    puts "Exit status: 0 success (no unbounds); 1 I/O or usage error; 2...255 for 1... unbounds. See also gdsSize.rb, gdsTopCells.rb"
    # this works (to set exit status) from ruby, not in klayout
    Kernel.exit(1)
  end

  f = ARGV[0]

  # construct command from our script arguments, replace self with klayout...
  exec "klayout -nc -zz -rx -rd InKlayout=1 -rd mode=#{mode} -rd verb=#{verbose} -rd file=#{f} -r #{thisScript}"

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
  STDOUT.flush
  STDERR.flush
  Kernel.exit!(1)
end

m = 0
if $mode == "unbound"
  m = 1
elsif $mode == "empty"
  m = 2
end
verb = 0
if $verb == "1"
  verb = 1
end

begin

ly = RBA::Layout::new
ly.read(f)

errs = 0
ly.each_cell { |c|
  msg = ""
  isempty = c.is_empty?
  isghost = c.is_ghost_cell?
  if verb == 1
    istop = c.is_top?
    isleaf = c.is_leaf?
    ispcellv = c.is_pcell_variant?
    isproxy = c.is_proxy?
    islib   = c.is_library_cell?
    bbox = c.bbox
    msg = " " + bbox.to_s
    (msg << " top")  if istop
    (msg << " leaf") if isleaf
    (msg << " pcellv") if ispcellv
    (msg << " empty") if isempty
    (msg << " ghost") if isghost
    (msg << " proxy") if isproxy
    (msg << " librarycell") if islib
  end

  if isghost
    STDERR.puts "ERROR: unbound (ghost) cell=#{c.name}"
    errs = errs + 1
  end

  # print cell line in all three of these conditions:
  #   default(all):   m == 0
  #   -U ghost-only:  m == 1 && isghost
  #   -E empty-only:  m == 2 && (isempty || isghost)
  # which simplify to:
  if m == 0 || isghost || m == 2 && isempty
    puts c.name + msg
  end
}

# if we roll-over to 256, exit-status seen by shell is zero.
# uncaught I/O errors will yield (built-in) exit status of 1.
if errs > 0
  STDERR.puts "ERROR: Found #{errs} total unbound (ghost) cells"
  errs = errs + 1
end
if errs > 255
  errs = 255
end

# In order to set exit-status, must use exit! not exit.
# But for exit! we'd lose buffered output unless we flush.
STDOUT.flush
STDERR.flush
Kernel.exit!(errs)

# stdout is buffered, exit! quits without flushing buffered output:
#   Kernel.exit!(errs)
# do not set exit-status:
#   Kernel.exit(errs)
#   exit errs
end
