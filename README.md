# FOSS-ASIC-TOOLS

FOSS-ASIC-TOOLS is an all-in-one Docker container for SKY130-based design for both analog and digital circuit design flows. Both `x86_64` and `aarch64` are available based on RockyLinux 8.5.

**This environment is based on the efabless.com container and adapted and curated by the Institute for Integrated Circuits, Johannes Kepler University**.

Below is a list of the current tools already installed and ready to use (note there are some adaptions in our container vs. efabless):

* [covered](https://github.com/hpretl/verilog-covered) Verilog code coverage
* [cu-gr](https://github.com/ax3ghazy/cu-gr.git) global router *(not yet included, build failing)*
* [cvc](https://github.com/d-m-bailey/cvc) circuit validity checker (ERC)
* [dr-cu](https://github.com/cuhk-eda/dr-cu.git) detail router *(not yet included, build failing)*
* [fault](https://github.com/Cloud-V/Fault) design-for-test (DFT) solution
* [gaw3-xschem](https://github.com/StefanSchippers/xschem-gaw.git) waveform plot tool for xschem
* [gtkwave](https://github.com/gtkwave/gtkwave) waveform plot tool for digital simulation
* [iic-osic](https://github.com/hpretl/iic-osic.git) collection of useful scripts and docs
* [irsim](https://github.com/rtimothyedwards/irsim) switch-level digital simulator
* [iverilog](https://github.com/steveicarus/iverilog.git) Verilog simulator
* [klayout](https://github.com/KLayout/klayout) layout tool
* [magic](https://github.com/rtimothyedwards/magic) layout tool with DRC and PEX
* [netgen](https://github.com/rtimothyedwards/netgen) netlist comparison (LVS)
* [ngscope](https://sourceforge.net/projects/ngscope/) waveform plot tool for ngspice
* [ngspice](http://ngspice.sourceforge.net) SPICE analog simulator
* [open_pdks](https://github.com/RTimothyEdwards/open_pdks) PDK setup scripts
* [openlane](https://github.com/The-OpenROAD-Project/OpenLane) digital RTL2GDS flow
* [openroad](https://github.com/The-OpenROAD-Project/OpenROAD.git) collection of tools for openlane
* [opensta](https://github.com/The-OpenROAD-Project/OpenSTA) static timing analyzer for digital flow
* [padring](https://github.com/donn/padring) padring generation tool
* [vlog2verilog](https://github.com/RTimothyEdwards/qflow.git) Verilog file conversion
* [risc-v toolchain](https://github.com/riscv/riscv-gnu-toolchain) GNU compiler toolchain for RISC-V RV32I cores
* [sky130](https://github.com/google/skywater-pdk.git) SkyWater Technologies 130nm CMOS PDK
* [verilator](https://github.com/verilator/verilator) fast Verilog simulator
* [xschem](https://github.com/StefanSchippers/xschem.git) schematic editor
* [xyce](https://github.com/Xyce/Xyce.git) fast parallel SPICE simulator
* [yosys](https://github.com/YosysHQ/yosys) Verilog synthesis tool

The tool versions used for `OpenLane` are documented in `tool_metadata.yml`.

## Quick Launch for Designers

Download and install Docker for your operating system:

* [Linux](https://hub.docker.com/search?q=&type=edition&offering=community&operating_system=linux&utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header)
* [Windows](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header)
* [Mac with Intel Chip](https://desktop.docker.com/mac/main/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header)
* [Mac with Apple Chip](https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header)

If you compiled the Docker containers locally use this:

```
cd $HOME
mkdir my-local-design-files
export DESIGNS=$HOME/my-local-design-files
docker run -it -p 80:80 -p 5901:5901 --user $(id -u):$(id -g) -v $DESIGNS:/foss/designs foss-asic-tools:latest bash
```

Use this to use the pre-made Docker container from us (swap `hpretl` for `efabless` for the original efabless container):

```
cd $HOME
mkdir my-local-design-files
export DESIGNS=$HOME/my-local-design-files
docker pull hpretl/foss-asic-tools:alpha
docker run -it -p 80:80 -p 5901:5901 --user $(id -u):$(id -g) -v $DESIGNS:/foss/designs hpretl/foss-asic-tools:alpha bash
```
- Open your browser of choice and go to [https://localhost](https://localhost) when asked for a password use `abc123` (default)
- [Watch this 5min video](https://youtu.be/EP3ozAtTQDw) to kickstart your analog project (Draft - more detailed information is coming)

## Details for Developers and Contributors

## Prerequisites

- [Docker](https://docs.docker.com/engine/install/)
- Python3
- Python virtualenv
  - `pip3 install virtualenv`
  - Setup the venv:
 
    ```
    virtualenv -p python3 venv
    source venv/bin/activate
    pip3 install -r requirements.txt
    ```

## Installation and Update

- Using a recipe CSV file

  ```
  python3 run.py recipe --csv recipe.csv
  ```

- Building an individual image

  ```
  python3 run.py build openlane
  ```
  
- Updating an individual image
  - Run:
 
    ```
    python3 run.py update open_pdks
    ```
  - You will be prompted with:
   
    ```
    A new commit for (open_pdks) is available:
    44c13e2256d5907090d6a2a62d9b9f8ddf23758d
    Would you like to update? (y/N)
    ```
- Updating all images in a given recipe file
 
    ```
    python3 run.py recipe --csv ./recipes/recipe.csv --update-reference
    ```
    
## Setting Screen Resolution and Custom Password:

```
docker run -it -p 80:80 -p 5901:5901 --user $(id -u):$(id -g) -v $DESIGNS:/foss/designs -e VNC_PW=<your password> -e VNC_RESOLUTION=1920x1080 efabless/foss-asic-tools:beta bash
```

## Notes

- Images are under the `images` directory
- Versions in the recipe file overwrite the image version
- The images are tagged `<name>:<version>`
- The final image is called `foss-tools:<tag>`, so if you want to run multiple recipes modify the tag of `foss-tools`

## Todo

- Dependancies handling (build based on `tool_metadata.yml`)
- Differentiate between git and non git based packages
- Compressed PDK
- Add more examples and documentation
- Fix `fault` (missing libs), `cugr` and `drcu` (failing build on aarch64)
- Allow direct connection to X server in addition to VNC and browser
