#!/bin/bash
# usage: gdsArea0.rb [-n] <gdsFileIn> [ <gdsFileOut> ]
#
# Process all layers, all cells, all cells: Find zero-area shapes.
# If gdsFileOut given: then delete such zero-area shapes and write new output file.
# Else report count of number of such shapes found.
# 
# Intent is (default) deep-mode retains hier. as much as possible, just
# merging each layer of each cell "in-place".
# WARNING: if outFile is RELATIVE-PATH it is written in SAME-DIR as input-GDS.
#
# Exit status (does not work in klayout 0.23.11; does in 0.24 and later):
#  1 : I/O error or other internal error (uncaught exceptions).
#  2...127 : means 1... zero-area shapes found. If over 126 such shapes, status is 127 max.
#  0 : zero-area shapes found.
#   If process dies thru signal, exit status is 128+SIGNUM, so that range is reserved.
#   i.e. if kernel oom-killer sends kill -9: status=137.
#
# Runs klayout in batch AND edit-mode.
# (klayout requirement is this script-name *must* end in .rb).
#
# Shebang for: no outer ruby interpreter; generalize arg passing to script.
# for-bash: re-quote args, to import from an env-var
x=%{
  [[ "$1" == "--version" || "$1" == "-v" ]] && exec klayout -b -v    # pass-thru -v

  export _M0=
  for i in "$@" ; do _M0="$_M0${_M0:+,}\"${i//\"/\\\"}\""; done
  exec klayout -e -b -r "$0" -rd tag="$_M0"
  # tag= is NOT USED, cosmetic: So process-listing shows the arguments, and a
  # user can distinguish one process from another, despite running same klayout-script.
}
# for-ruby:

argv=eval("[ #{ENV["_M0"]} ]")   # re-parse args from env-var
# puts "argv.size=#{argv.size}"
# argv.each{ |v| puts v }

  thisScript = $0
  prog="gdsArea0.rb"
  usage = "Usage: #{prog} [options]  <gdsFileIn> [ <gdsFileOut> ]"
  usage += "\n   Find (optionally delete) zero-area objects and optionally write modified gds out."
  require 'optparse'

  if argv.empty?
    argv << '--help'
  end

  o = {:writeAlways=>true}
  OptionParser.new do |opts|
    opts.banner = usage
    opts.on("-n", "Don't write gdsOutFile IF NO SHAPES DELETED. Default, if outFile given: always write.") do
      o[:writeAlways] = false
    end

    opts.on("-v", "--version", "version: pass-thru, JUST show klayout version") do
      exec "klayout -b -v"
    end
    opts.on("--help", "show usage") do
      puts opts
      exit 1
    end
    opts.on("--usage", "show usage") do
      puts opts
      exit 1
    end
  end.parse!(argv)   # default constant ARGV? Doesn't work here: not true ruby.
  # "!" on end of parse: argv parameter is MODIFIED by OptionParser to delete the processed options.

  if argv.length < 1 || argv.length > 2
    puts "ERROR, not 1 or 2 arguments. #{usage}"
    exit 1
  end
f = argv[0]
# c = argv[1]
fout = argv[1]

if f == ""
  puts "ERROR: insufficient arguments. #{usage}"
  exit 1
end

doDel = fout && (fout != "") # actively do deletes IFF given an output file arg.

# include RBA
begin

if doDel
  if o[:writeAlways]
    puts "Running #{prog} on file=#{f}, output to #{fout} always"
  else
    puts "Running #{prog} on file=#{f}, output to #{fout} only if there were deletes"
  end
else
  puts "Running #{prog} on file=#{f} (passive, no gdsFileOut)"
end
puts "  args: #{ENV["_M0"]}"

STDOUT.flush
$errs = 0
del = 0

# based in part on: https://www.klayout.de/forum/discussion/173/use-klayout-in-batch-mode
ly = RBA::Layout.new
ly.read(f)

## source(f, c)
# s = source(f)
# layout = s.layout
# target(fout)

ly.layer_indices.each { |li|
  ly.each_cell { |cell|
    cell.shapes(li).each { |shape|
      # TODO: must we check that shape is one of: box, polygon, path? What happens to text?
      if shape.is_valid? && (!shape.is_null?) &&
          (shape.is_box? || shape.is_path? || shape.is_polygon?) &&
          shape.area == 0
        $errs += 1
        if doDel
          shape.delete
          del += 1
        end
      end
    }
  }
}

if fout && fout != ""
  if (! o[:writeAlways] ) && del == 0
    puts "Skipped write of #{fout} due -n and nothing deleted."
  else
    puts "writing #{fout} ..."
    ly.write(fout)
  end
end

puts "#{$errs} zero-area shapes,  #{del} shapes deleted."

# if we roll-over to 256, exit-status seen by shell is zero.
# uncaught I/O errors will yield (built-in) exit status of 1.
if $errs > 0
  $errs = $errs + 1
end
if $errs > 127
  $errs = 127
end

# experimental: report own peak process-stats. BUT: output-file isn't really written
# until we exit (during exit). So these results are not 100% accurate.
# VmHWM: max-resident-size, VmPeak: max virtual-size.
# don't need: pid=Process.pid
if   File.readable?("/proc/self/status")
  puts File.foreach("/proc/self/status").grep(/^(VmPeak|VmHWM)/)
end

end # end begin

# does not work (to set exit-status) in 0.23.11. Does work in 0.24.2, 0.27.
exit $errs

#
# emacs syntax-mode:
# Local Variables:
# mode:ruby
# End:
