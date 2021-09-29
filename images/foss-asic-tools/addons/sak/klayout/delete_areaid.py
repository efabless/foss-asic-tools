
# Enter your Python code here

import pya
from time import sleep

print("Starting...")
app = pya.Application.instance()
win = app.main_window()

# Load technology file
#tech = pya.Technology()
#tech.load(tech_file)
#layoutOptions = tech.load_layout_options

# Load def/gds file in the main window
#cell_view = win.load_layout(input_layout, layoutOptions, 0)
#layout_view = cell_view.view()
#layout_view.max_hier()

# gets the corresponding layout object
#layout = cell_view.layout()
layout = pya.Layout()
layout.read(input_layout)
#layout.clear_layer(81)
#layout.delete_layer(81)

# gets the cell to change is "INV2X"
# cell = layout.cell("Active_area")
#cell = cell_view.cell

# finds source layer
#areaid_layer = layout.layer(81, 14)
#areaid_layer.delete()

#layout.write(input_layout)
layout.write('junk.gds')

print("Successfully wrote", input_layout)

app.exit(0)
