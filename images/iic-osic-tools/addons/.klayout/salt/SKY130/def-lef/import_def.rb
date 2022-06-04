# Usage
#
#  klayout -rd input=in.def -rd map=in.map -rd lefs=in.lef,in_tech.lef -rm path_to_script/import_def.rb
#
# Variables (-rd <name>=<value):
#  input:  path to DEF file
#  map:    path to map file
#  lefs:   comma-separated list of LEF files (relative to DEF file location)
#
# Optional:
#  lef_macros: (without value) if given, LEF macro geometries will be read into DEF  
#  macros:     A comma-separated list of other layout files to read for substituting LEF macros

$input || raise("Use -rd input=... to specify the input DEF file")
$map   || raise("Use -rd map=... to specify the map file")
$lefs  || raise("Use -rd lefs=a.lef,b.lef,... to specify the LEF files (paths relative to DEF file)")

opt = RBA::LoadLayoutOptions::new
opt.lefdef_config.map_file = $map
opt.lefdef_config.read_lef_with_def = false
opt.lefdef_config.lef_files = $lefs.split(",")
opt.lefdef_config.macro_resolution_mode = $lef_macros ? 0 : 2
opt.lefdef_config.dbu = 0.0005

# read and install the substitution layouts
macro_layouts = []
if $macros
  macro_layouts = $macros.split(",").collect do |m|
    lm = RBA::Layout::new
    lm.read(File.absolute_path(m, File.dirname($input)))
    lm
  end
end
opt.lefdef_config.macro_layouts = macro_layouts

# actually read the DEF file
mw = RBA::MainWindow::instance
mw.load_layout($input, opt, 1)
