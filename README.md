# IIC-OSIC-TOOLS

**This environment is based on the efabless.com FOSS-ASIC-TOOLS <https://github.com/efabless/foss-asic-tools>**

IIC-OSIC-TOOLS is an all-in-one Docker container for SKY130-based integrated circuit designs for analog and digital circuit flows. The CPU architectures `x86_64` and `aarch64` are natively supported based on RockyLinux 9. This collection of tools is curated by the **Institute for Integrated Circuits (IIC), Johannes Kepler University (JKU)**.
It supports two *modes of operation*:

1. Using a complete desktop environment (XFCE) in Xvnc (a VNC server), either directly accessing it with a VNC client of your choice or the integrated [noVNC](https://novnc.com) server that runs now in your browser.
2. Using a local X11 server and directly showing the application windows on your desktop.

[Watch this 5min video](https://youtu.be/EP3ozAtTQDw) to kickstart your analog project (draft - more detailed information is coming).

## Installed Tools

Below is a list of the current tools already installed and ready to use (note there are some adaptions in our container vs. efabless.com):

* [amaranth](https://github.com/amaranth-lang/amaranth) a Python-based HDL toolchain
* [cocotb](https://github.com/cocotb/cocotb) simulation library for writing VHDL and Verilog testbenches in Python
* [covered](https://github.com/hpretl/verilog-covered) Verilog code coverage
* [cvc](https://github.com/d-m-bailey/cvc) circuit validity checker (ERC)
* [fault](https://github.com/Cloud-V/Fault) design-for-test (DFT) solution
* [gaw3-xschem](https://github.com/StefanSchippers/xschem-gaw.git) waveform plot tool for `xschem`
* [gdsfactory](https://github.com/gdsfactory/gdsfactory) Python library for GDS generation
* [gdspy](https://github.com/heitzmann/gdspy) Python module for creation and manipulation of GDS files
* [ghdl](https://github.com/ghdl/ghdl) VHDL simulator
* [gtkwave](https://github.com/gtkwave/gtkwave) waveform plot tool for digital simulation
* [iic-osic](https://github.com/hpretl/iic-osic.git) collection of useful scripts and documentation
* [irsim](https://github.com/rtimothyedwards/irsim) switch-level digital simulator
* [iverilog](https://github.com/steveicarus/iverilog.git) Verilog simulator
* [klayout](https://github.com/KLayout/klayout) layout tool
* [magic](https://github.com/rtimothyedwards/magic) layout tool with DRC and PEX
* [netgen](https://github.com/rtimothyedwards/netgen) netlist comparison (LVS)
* [ngspice](http://ngspice.sourceforge.net) SPICE analog simulator
* [open_pdks](https://github.com/RTimothyEdwards/open_pdks) PDK setup scripts
* [openlane](https://github.com/The-OpenROAD-Project/OpenLane) digital RTL2GDS flow
* [openroad](https://github.com/The-OpenROAD-Project/OpenROAD.git) collection of tools for `openlane`
* [opensta](https://github.com/The-OpenROAD-Project/OpenSTA) static timing analyzer for digital flow
* [padring](https://github.com/donn/padring) padring generation tool
* [pyrtl](https://github.com/UCSBarchlab/PyRTL) collection of classes for pythonic RTL design
* [pyspice](https://github.com/PySpice-org/PySpice) interface `ngspice` and `xyce` from Python
* [pyverilog](https://github.com/PyHDI/Pyverilog) Python toolkit for Verilog
* [rggen](https://github.com/rggen/rggen) code generation tool for configuration and status registers
* [spyci](https://github.com/gmagno/spyci) analyze/plot `ngspice`/`xyce` output data with Python
* [vlog2verilog](https://github.com/RTimothyEdwards/qflow.git) Verilog file conversion
* [risc-v toolchain](https://github.com/riscv/riscv-gnu-toolchain) GNU compiler toolchain for RISC-V RV32I cores
* [siliconcompiler](https://github.com/siliconcompiler/siliconcompiler) modular build system for hardware
* [sky130](https://github.com/google/skywater-pdk.git) SkyWater Technologies 130nm CMOS PDK
* [verilator](https://github.com/verilator/verilator) fast Verilog simulator
* [xschem](https://github.com/StefanSchippers/xschem.git) schematic editor
* [xyce](https://github.com/Xyce/Xyce.git) fast parallel SPICE simulator (incl. `xdm` netlist conversion tool)
* [yosys](https://github.com/YosysHQ/yosys) Verilog synthesis tool (with GHDL plugin for VHDL synthesis)

The tool versions used for `OpenLane` are documented in `tool_metadata.yml` and the other tools in `tool_metadata_add.yml`.

## Quick Launch for Designers

Download and install **Docker** for your operating system:

* [All platforms (Linux)](https://docs.docker.com/engine/install/)
* [Windows](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe)
* [Mac with Intel Chip](https://desktop.docker.com/mac/main/amd64/Docker.dmg)
* [Mac with Apple Chip](https://desktop.docker.com/mac/main/arm64/Docker.dmg)

Note for Linux: Do not run docker commands or the start scripts as root (sudo)! Follow the instructions in [Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/)

The following start scripts are intended as helper scripts for local or small-scale (single instance) deployment. If you need to run a bulk of instances, consider starting the containers with a custom start script.

### Customizing Environment

All user data is persistently placed in the directory pointed to by the environment variable `DESIGNS` (the default is `$HOME/eda/designs` for Linux/macOS and `%USERPROFILE%\eda\designs` for Windows, respectively).

If a file `.designinit` is put in this directory, it is sourced last when starting the Docker environment. In this way, users can adapt settings to their needs.

### Using VNC and noVNC

This mode is recommended for remote operation on a separate server or if you prefer the convenience of a full desktop environment. To start it up, you can use (in a Bash/Unix shell):

`./start_vnc.sh`

On Windows, you can use the equivalent batch script (if the defaults are acceptable, it can also be started by double clicking in the Explorer):

`.\start_vnc.bat`

You can now access the Desktop Environment through your browser ([http://localhost](http://localhost)). The default password is `abc123`.

#### Variables for VNC

Both scripts will use default settings, which you can tweak by settings shell variables (VARIABLE=default is shown):

* `DRY_RUN` (unset by default); if set to any value (also 0, false, etc.), makes the start scripts print all executed commands instead of running. Useful for debugging/testing or just creating "template commands" for unique setups.
* `DESIGNS=$HOME/eda/designs` (`DESIGNS=%USERPROFILE%\eda\designs` for `.bat`) sets the directory that holds your design files. This directory is mounted into the container on `/foss/designs`.
* `WEBSERVER_PORT=80` sets the port on which the Docker daemon will map the webserver port of the container to be reachable from localhost and the outside world. `0` disables the mapping.
* `VNC_PORT=5901` sets the port on which the Docker daemon will map the VNC server port of the container to be reachable from localhost and the outside world. This is only required if you want to access the UI with a different VNC client. `0` disabled the mapping.
* `DOCKER_USER="hpretl"` username for the Docker Hub repository from which the images are pulled. Usually, no change is required.
* `DOCKER_IMAGE="iic-osic-tools"` Docker Hub image name to pull. Normally no change is required.
* `DOCKER_TAG="latest"` Docker Hub image tag. By default, it pulls the latest version; this might be handy to change if you want to match a specific version set.
* `CONTAINER_USER=$(id -u)` (the current user's ID, `CONTAINER_USER=1000` for `.bat`) The user ID (and also group ID) is especially important on Linux and macOS because those are the IDs used to write files in the `DESIGNS` directory. For debugging/testing, the user and group ID can be set to `0` to gain root access inside the container.
* `CONTAINER_GROUP=$(id -g)` (the current user's group ID, `CONTAINER_GROUP=1000` for `.bat`)
* `CONTAINER_NAME="iic-osic-tools_xvnc_uid_"$(id -u)` (attaches the executing users id to the name on Unix, or only `CONTAINER_NAME="iic-osic-tools_xvnc` for `.bat`) is the name that is assigned to the container for easy identification. It is used to identify if a container exists and is running.

To overwrite the default settings, see [Overwriting Shell Variables](#overwriting-shell-variables)

### Using a Local X-Server

This mode is recommended if the container is run on the local machine. It is significantly faster than VNC (as it renders the graphics locally), is more lightweight (no complete desktop environment is running), and integrates with the desktop (copy-paste, etc.). To start the container run

`./start_x.sh`

or

`.\start_x.bat`

**Attention Windows and macOS users:** The X-server connection is automatically killed if there is a too long idle period in the terminal (when this happens, it looks like a **crash** of the system). A **workaround** is to start a second terminal from the initial terminal that pops up when executing the start scripts `./start_x.sh` or `.\start_x.bat`, and then start `htop` in the initial terminal. In this way, there is an ongoing display activity in the initial terminal, and as a positive side-effect, the usage of the machine can be monitored. We are looking for a better long-term solution.

#### Variables for X11

The following environment variables are used for configuration:

* `DRY_RUN` (unset by default), if set to any value (also 0, false, etc.), makes the start scripts print all executed commands instead of running. Useful for debugging/testing or just creating "template commands" for unique setups.
* `DESIGNS=$HOME/eda/designs` (`DESIGNS=%USERPROFILE%\eda\designs` for `.bat`) sets the directory that holds your design files. This directory is mounted into the container on `/foss/designs`.
* `DOCKER_USER="hpretl"` username for the Docker Hub repository from which the images are pulled. Usually, no change is required.
* `DOCKER_IMAGE="iic-osic-tools"` Docker Hub image name to pull. Normally no change is required.
* `DOCKER_TAG="latest"` Docker Hub image tag. By default, it pulls the latest version; this might be handy to change if you want to match a specific Version set.
* `CONTAINER_USER=$(id -u)` (the current user's ID, `CONTAINER_USER=1000` for `.bat`) The user ID (and also group ID) is especially important on Linux and macOS because those are the IDs used to write files in the DESIGNS directory.
* `CONTAINER_GROUP=$(id -g)` (the current user's group ID, `CONTAINER_GROUP=1000` for `.bat`)
* `CONTAINER_NAME="iic-osic-tools_xserver_uid_"$(id -u)` (attaches the executing users id to the name on Unix, or only `CONTAINER_NAME="iic-osic-tools_xserver` for `.bat`) is the name that is assigned to the container for easy identification. It is used to identify if a container exists and is running.

#### macOS and Windows-specific Variables

For Mac and Windows, the X11 server is accessed through TCP (:0, aka port 6000). To control the server's address, you can set the following variable:

* `DISP=host.docker.internal:0` is the environment variable that is copied into the `DISPLAY` variable of the container. `host.docker.internal` resolves to the host's IP address inside the docker containers, `:0` corresponds to display 0 which corresponds to TCP port 6000.

If the executable `xauth` is in `PATH`, the startup script automatically disables access control for localhost, so the X11 server is open for connections from the container. If not, a warning will be shown, and you have to disable access control by yourself.

#### Linux-specific Variables

For Linux, the local X11 server is accessed through a Unix socket. There are multiple variables to control:

* `XSOCK=/tmp/.X11-unix` is typically the default location for the Unix sockets. The script will probe if it exists and, if yes, mount it into the container.
* `DISP` has the same function as macOS and Windows. It is copied to the container's `DISPLAY` variable. If it is not set, the value of `DISPLAY` from the host is copied.
* `XAUTH` defines the file that holds the cookies for authentication through the socket. If it is unset, the host's `XAUTHORITY` contents are used. If those are unset too, it will use `$HOME/.Xauthority`.

The defaults for these variables are tested on native X11 servers, X2Go sessions, and Wayland. The script copies and modifies the cookie from the`.Xauthority` file into a separate, temporary file. This file is then mounted into the container.

#### Installing X11-Server

Everything should be ready to go on Linux with a desktop environment / UI (this setup has been tested on X11 and XWayland). For Windows and macOS, the installation of an X11 server is typically required. Due to the common protocol, every X11-server should work, although the following are tested:

* For Windows: [VcXsrc](https://sourceforge.net/projects/vcxsrv/)
* For macOS: [XQuartz](https://www.xquartz.org/) **Important:** Please enable *"Allow connections from network clients"* in the XQuartz preferences [CMD+","], tab *"Security"*

For both X-Servers, it is strongly recommended to enable OpenGL:

* The `start_x.sh` script will take care of that on macOS and set it according to configuration values. Only a manual restart of XQuartz is required after the script is run once (observe the output!).
* On Windows with VcXsrv, we recommend using the utility "XLaunch" (installed with VcXsrv):

  * Multiple windows mode
  * Set the Display Number to 0
  * Start no client
  * Tick all `Extra settings`: `Clipboard`, `Primary selection`, `Native opengl` and `Disable access control`

### Overwriting Shell Variables

#### For the Linux/macOS Bash Scripts

There are multiple ways to configure the start scripts using Bash. Two of them are shown here. First, the variables can be set directly for each run of the script; they are not saved in the active session:

`DESIGNS=/my/design/directory DOCKER_USERNAME=another_user ./start_x.sh`

The second variant is to set the variables in the current shell session (not persistent between shell restarts or shared between sessions):

```bash
export DESIGNS=/my/design/directory
export DOCKER_USERNAME=another_user
./start_x.sh
```

As those variables are stored in your current shell session, you only have to set them once. After setting, you can directly run the scripts.

#### For the Windows Batch Scripts

In `CMD` you can't set the variables directly when running the script. So for the .bat scripts, it is like the second variant for Bash scripts:

```batch
SET DESIGNS=\my\design\directory
SET DOCKER_USERNAME=another_user
.\start_x.bat
```

## Details for Developers and Contributors

### Prerequisites

* [Docker](https://docs.docker.com/engine/install/)

### Building the container

The installation slightly differs from the original `foss-asic-tools` installation by efabless.com. For this image, the build is replaced with a single Dockerfile for convenience when doing a multi-architecture build. For a basic single (native)-architecture build, just run

`docker build .`

You can add build parameters accordingly. We strongly recommend using `docker buildx` because of `buildkit` (parallel building) and multi-architecture support. The script `build_all.sh` includes building with `buildx`, on two different machines (for fast amd64 and arm64 builds) and pushes both images to the Docker Hub under the same tag. The script includes multiple environment variables with defaults. If you intend to build this image, we encourage you to use this script as a template.
The predefined settings are for the IIC build-machines, and the image gets pushed with the tags `latest` and `year.month`.

### Detailed container settings

For specific use cases, the containers can be started without the help of the start scripts. Here are a few things to note down:

#### Environment Variables

The container makes use of several environment variables to control the behavior. **WARNING:** those values maybe impact the functionality of the container. Do not change them unless you know what you are doing.

The internal VNC and webserver ports are defined by environment variables (not to be confused with the variables in the start script, those manage the external ports, to which the Docker daemon maps the ports! It works *best* if those are matched.). Those are used in the Dockerfile for the exposed ports and the configuration of the services.

* `VNC_PORT=5901` The default internal VNC port.
* `NO_VNC_PORT=80` The default internal webserver port.

Furthermore, the following variables can be set:

* `HOME=/headless` sets the home directory in the container.
* `TERM=xterm` is the default graphical terminal emulator.
* `STARTUPDIR=/dockerstartup` is the directory in which all container-related scripts are put.
* `NO_VNC_HOME=/dockerstartup/noVNC` is the directory for the noVNC installation.
* `VNC_COL_DEPTH=24` VNC color resolution.
* `VNC_RESOLUTION=1680x1050` VNC display resolution. NOTE: This can also be changed while running in the Desktop environment by going to Settings->Display.
* `VNC_PW=abc123` Default VNC password.
* `VNC_VIEW_ONLY=false` can set the VNC server to view only.
* `DESIGNS=/foss/designs` Default directory, where the designs are placed.
* `TOOLS=/foss/tools` Default tools directory.
* `PDK_ROOT=/foss/pdk` Default PDKs directory.

#### Entrypoint script

The entry point for this container is the [ui_startup.sh](https://github.com/hpretl/iic-osic-tools/blob/main/images/iic-osic-tools/scripts/ui_startup.sh) script. It controls which kind of UI (Xvnc or connecting to local X11 server) is used. The control logic for the automatic mode is simple. If the environment variable `DISPLAY` is set, an already existing X11 server is assumed, and the startup script runs an XFCE4 terminal. If the `DISPLAY` is not set, it starts Xvnc and the noVNC web interface. This behavior can be overwritten with command line arguments.

The following command line arguments are supported:

* `-X, --x11` Force to use local X11 forwarding requires a working combination of `$DISPLAY`, and either port forwards or mounted `XAUTHORITY` and `.X11_unix` socket.
* `-V, --vnc` Force use of VNC server, with noVNC and `websockify`.
* `-w, --wait` Runs the selected UI and waits for them to exit. The script will only return then. This flag is set in the container per default (via `CMD` in the Dockerfile).
* `-s, --skip` Skip the UI startup and execute the assigned command. **WARNING:** This must be the first parameter to the script, or it must be ignored! example: `docker run hpretl/iic-osic-tools --skip bash`
* `-d, --debug` Enables more detailed startup output e.g. `docker run hpretl/iic-osic-tools --debug`

As some examples already show, these parameters can be passed to the container via Docker:

`docker run -it hpretl/iic-osic-tools:latest --wait --vnc`

## Notes

* Each tool has a separate directory in the `images` directory with the build script and additional required files.
* The tool versions (typically the commit hash) have defaulted in the Dockerfile. It can be overwritten via environment variables.
* Only the final image is tagged; the sub-tools are not. It is still possible to build only to a certain stage (stages are defined in the Dockerfile by `FROM base_image as stage_name`).
* The final image is called `iic-osic-tool` by default.

## Todo

n/a
