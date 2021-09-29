import pya

app = pya.Application.instance()
opt = pya.SaveLayoutOptions()
view = pya.Layout()

# Setting the name of the output file and setting the substitution character
print("[INFO] Changing from " + input_layout + " to " + output)
opt.set_format_from_filename(output)
opt.oasis_substitution_char=''

# Reading the input file and writing it to the output file name
view.read(input_layout)
view.write(output, opt)

app.exit(0)
