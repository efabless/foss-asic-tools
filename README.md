# IIC-OSIC-TOOLS

**This environment is based on the efabless.com FOSS-ASIC-TOOLS https://github.com/efabless/foss-asic-tools**

IIC-OSIC-TOOLS is an all-in-one Docker container for SKY130-based integrated circuit designs for both analog and digital circuit flows. The CPU architectures `x86_64` and `aarch64` are natively supported based on RockyLinux 8.5. This collection of tools is curated by the **Institute for Integrated Circuits (IIC), Johannes Kepler University (JKU)**.
It supports two *modes of operation*:
1. Using a full desktop environment (XFCE) in Xvnc (a VNC server), either directly accessing it with a VNC client of your choice, or the integrated [noVNC](https://novnc.com) server that runs directly in your browser.
2. Using a local X-server and directly showing the application windows on your desktop.

[Watch this 5min video](https://youtu.be/EP3ozAtTQDw) to kickstart your analog project (Draft - more detailed information is coming).

## Installed Tools
Below is a list of the current tools already installed and ready to use (note there are some adaptions in our container vs. efabless):

* [covered](https://github.com/hpretl/verilog-covered) Verilog code coverage
* [cu-gr](https://github.com/ax3ghazy/cu-gr.git) global router (Note: segfaults when using with openlane)
* [cvc](https://github.com/d-m-bailey/cvc) circuit validity checker (ERC)
* [dr-cu](https://github.com/cuhk-eda/dr-cu.git) detail router (Note: segfaults when using with openlane)
* [fault](https://github.com/Cloud-V/Fault) design-for-test (DFT) solution
* [gaw3-xschem](https://github.com/StefanSchippers/xschem-gaw.git) waveform plot tool for xschem
* [ghdl](https://github.com/ghdl/ghdl) VHDL simulator
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
* [xyce](https://github.com/Xyce/Xyce.git) fast parallel SPICE simulator (incl. xdm netlist conversion tool)
* [yosys](https://github.com/YosysHQ/yosys) Verilog synthesis tool (with GHDL plugin for VHDL synthesis)

The tool versions used for `OpenLane` are documented in `tool_metadata.yml`.

## Quick Launch for Designers

Download and install Docker for your operating system:

* [All platforms (Linux)](https://docs.docker.com/engine/install/)
* [Windows](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe)
* [Mac with Intel Chip](https://desktop.docker.com/mac/main/amd64/Docker.dmg)
* [Mac with Apple Chip](https://desktop.docker.com/mac/main/arm64/Docker.dmg)

The following start scripts are intended as helper scripts for local or small-scale (single instance) deployment. If you need to run a bulk of instances, consider starting the containers with a custom start-script.

### Using VNC and noVNC

This mode is recommended for remote operation on a separate Server or if you prefer the convenience of a full desktop environment. Basically, to start it up you can just use (in a Bash/Unix Shell):

    ./start_vnc.sh

On Windows, you can use the equivalent batch-script (If the defaults are fine, it can also be started by double clicking in the explorer):

    .\start_vnc.bat

You can now access the Desktop-Environment through your browser ([http://localhost](http://localhost)). The default password is "abc123".

#### Variables
Both scripts will use default settings, which you can tweak the following by settings shell variables (VARIABLE=default is shown):

 * ```DESIGNS=$HOME/eda/designs``` (```DESIGNS=%USERPROFILE%\eda\designs``` for .bat) sets the directory that holds your design files. This directory is mounted into the container on ```/foss/eda```.
 * ```WEBSERVER_PORT=80``` sets the port on which the Docker daemon will map the webserver port of the container to be reachable from localhost and the outside world. 0 disables the mapping.
 * ```VNC_PORT=5901``` sets the port on which the Docker daemon will map the VNC server port of the container to be reachable from localhost and the outside world. This is only required if you want to access the UI with a different VNC client. 0 disabled the mapping.
 * ```DOCKER_USER="hpretl"``` Username for the Docker Hub repository of which the images is pulled from. Normally no change required.
 * ```DOCKER_IMAGE="iic-osic-tools"``` Docker Hub image name to pull. Normally no change required.
 * ```DOCKER_TAG="latest"``` Docker Hub image tag. By default it pulls the newest version, this might be handy to change if you want to match a specific Version set.

#### Windows specific variables
For the batch script, there are two additional parameters to control the User and Group that is used inside the container. Note: for the shellscript, the Unix Group and User of the user starting the script are automatically used, so the file owner and groups are set right on your host system. For Windows, this is not required.

 * ```CONTAINER_USER=1000```
 * ```CONTAINER_GROUP=1000```

To overwrite the default settings, see [Overwriting Shell Variables](#overwriting-shell-variables)

### Using a local X-server

This mode is recommended, if the container is run in the local machine. It is significantly faster then the VNC (renders locally), is more lightweight (no full DE is running) and integrates with the Desktop (copy paste etc.)

    ./start_x.sh

or

    .\start_x.bat


#### Variables
The following environment variables are used for configuration:
 * ```DESIGNS=$HOME/eda/designs``` (```DESIGNS=%USERPROFILE%\eda\designs``` for .bat) sets the directory that holds your design files. This directory is mounted into the container on ```/foss/eda```.
 * ```DOCKER_USER="hpretl"``` Username for the Docker Hub repository of which the images is pulled from. Normally no change required.
 * ```DOCKER_IMAGE="iic-osic-tools"``` Docker Hub image name to pull. Normally no change required.
 * ```DOCKER_TAG="latest"``` Docker Hub image tag. By default it pulls the newest version, this might be handy to change if you want to match a specific Version set.


#### Mac and Windows specific variables
For Mac and Windows, the X server is accessed through TCP (:0, aka port 6000). To control the server's address, you can set the following variable:

 * ```DISP=host.docker.internal:0``` ist the environment variable, that is copied into the "DISPLAY" variable of the container. ```host.docker.internal``` resolves to the hosts IP adress inside the docker containers, :0 is Display 0 which corresponds to TCP port 6000.

If the executeable ```xauth``` is in PATH, the startup script automatically disabled access control for localhost, so the X server is open for connections from the container. If not, a warning will be shown and you have to disable access control by yourself.

#### Linux specific variables
For Linux, the local X server is accessed through a unix socket. There are multiple variables to control:

 * ```XSOCK=/tmp/.X11-unix``` is typically the default location for the unix sockets. The script will probe if it exists and if yes, mount it into the container.
 * ```DISP``` has the same function as for Mac and Windows. It is copied to the containers "DISPLAY variable. If it is not set, the value of "DISPLAY" from the host is copied.
 * ```XAUTH``` defines the file, that holds the cookies for authentication through the socket. If it is unset, the contents of the hosts "XAUTHORITY" are used. If those are unset too, then it will use $HOME/.Xauthority.

The defaults for this variables are tested on native X servers, X2Go sessions and also wayland. The script copies and modifies the cookie out of the .Xauthority file into a seperate, temporary file. This file is then mounted into the container.

### Overwriting Shell Variables

#### For the Bash Scripts
There are multiple ways to configure the start scripts using Bash. Two of them are shown here. First the variables can be set directly for each run of the script, they are not saved in the active session:

    DESIGNS=/my/design/directory DOCKER_USERNAME=another_user ./start_x.sh

Second variant is to set the Variables in the current shell session (not persistent between shell-restarts or shared between sessions):

    export DESIGNS=/my/design/directory
    export DOCKER_USERNAME=another_user
    ./start_x.sh

As those variables are stored in your current shell session, you only have to set them once. After setting, you can directly run the scripts.

#### For the Windows Batch Scripts
In "CMD" you can't set the variables directly when running the script. So for the .bat scripts, it is like the second variant for Bash scripts:

    SET DESIGNS=\my\design\directory
    SET DOCKER_USERNAME=another_user
    .\start_x.bat

## Details for Developers and Contributors

### Prerequisites

- [Docker](https://docs.docker.com/engine/install/)

### Building the container

The installation slightly differs from the original foss-asic-tools install by efabless. For this image, the build is replaced with a single Dockerfile for convenience when doing a multi-architecture build. For a basic single(native)-architecture build, just run

    docker build .

You can add build parameters accordingly. We strongly recommend using "docker buildx" because of buildkit (parallel building) and multi-architecture support. The script "build_all.sh" includes building with buildx, on two different machines (for fast amd64 and arm64 builds) and pushes both images to the Docker Hub under the same tag. The script includes multiple environment variables with defaults. If you intend to build this image, we encourage to use this script as a template.
The predefined settings are for the IIC build-machines and the image gets pushed with the tags "latest" and "year.month".
    
### Detailed container settings
For specific usecases, the containers can be started without the help of the start-scripts. A few things to note down:

#### Environment Variables
The container makes use of a number of environment variables, to control the behaviour. WARNING: those values maybe impact the functionallity of the container. Do not change them unless you know what you are doing.

The internal VNC and Webserver ports are defined by environment variables (not to be confused with the variables in the start script, those manage the external ports, to which the Docker daemon mappes the ports! It works *best* if those are matched.). Those are used in the Dockerfile for the exposed ports and in the configuration of the services.

 * ```VNC_PORT=5901``` The default internal VNC port.
 * ```NO_VNC_PORT=80``` The default internal webserver port.

Furthermore, the following variables can be set:

 * ```HOME=/headless``` sets the home directory in the container.
 * ```TERM=xterm``` is the default graphical terminal emulator.
 * ```STARTUPDIR=/dockerstartup``` is the directory, in which all container related scripts are put into.
 * ```NO_VNC_HOME=/dockerstartup/noVNC``` is the directory for the noVNC installation.
 * ```VNC_COL_DEPTH=24``` VNC color resolution.
 * ```VNC_RESOLUTION=1680x1050``` VNC display resolution. NOTE: this can also be changed while running in the Desktop environment by going to Settings->Display.
 * ```VNC_PW=abc123``` Default VNC password.
 * ```VNC_VIEW_ONLY=false``` Can be used to set the VNC server to view only.
 * ```DESIGNS=/foss/designs``` Default directory, where the designs are placed in.
 * ```TOOLS=/foss/tools``` Default tools directory.
 * ```PDK_ROOT=/foss/pdk``` Default PDKs directory.

#### Entrypoint script
The entrypoint for this container is the [ui_startup.sh](https://github.com/hpretl/iic-osic-tools/blob/main/images/iic-osic-tools/scripts/ui_startup.sh) script. Basically, it controls, which kind of UI (Xvnc or connecting to local X-server.) is used.
The control logic for the automatic mode is simple. If the environment variable "DISPLAY" is set, an already existing X-server is assumed and the startup script just runs an XFCE4-Terminal. If the DISPLAY is not set, it starts Xvnc and the noVNC webinterface. This behaviour can be overwritten with command line arguments.

The following command line arguments are supported:

 * ```-X, --x11``` Force to use local X11 forwarding, requires a working combination of $DISPLAY, an either port forwards or mounted XAUTHORITY and .X11_unix socket.
 * ```-V, --vnc```       Force use of VNC server, with noVNC and websockify.
 * ```-w, --wait```      Runs the selected UI and waits for them to exit. The script will only return then. This flag is set in the container per default (via CMD in the Dockerfile)
 * ```-s, --skip```      skip the ui startup and just execute the assigned command. WARNING: this must be the first parameter to the script or it is ignored! example: ```docker run hpretl/iic-osic-tools --skip bash```
 * ```-d, --debug```     enables more detailed startup output e.g. ```docker run hpretl/iic-osic-tools --debug```

As some examples already show, this parameters can be passed to the container via Docker:

    docker run -it hpretl/iic-osic-tools:latest --wait --vnc

## Notes

- Each tool has a separate directory in the `images` directory with the build script and additional required files.
- The tool-versions (typically the commit hash) is set to a default in the Dockerfile. It can be overwritten via environment variables.
- Only the final image is tagged, the sub-tools are not. It is still possible to build only to a certain stage (Stages are defined in the Dockerfile by ```FROM base_image as stage_name```)
- The final image is called `iic-osic-tool` by default.

## Todo

- Update tool versions from openlane repository (to have matching versions) by tag.
