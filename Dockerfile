#######################################################################
# Setup base image
#######################################################################
ARG BASE_IMAGE=ubuntu:jammy
FROM ${BASE_IMAGE} as base
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Vienna
ADD images/base/scripts/dependencies.sh dependencies.sh
RUN bash dependencies.sh

#######################################################################
# Add base packages (install via pip, npm, or gem)
#######################################################################
FROM base as basepkg
ADD images/base/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile magic (part of OpenLane)
#######################################################################
FROM basepkg as magic
ARG MAGIC_REPO_URL="https://github.com/rtimothyedwards/magic"
ARG MAGIC_REPO_COMMIT="1d8fcca09bdbfad1066b78c3a6ac9742043f7d13"
ARG MAGIC_NAME="magic"
ADD images/magic/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile iic-osic
#######################################################################
FROM magic as iic-osic
ARG IIC_OSIC_REPO_URL="https://github.com/iic-jku/iic-osic.git"
ARG IIC_OSIC_REPO_COMMIT="3fa99fb2e830226ec5763a11ec963fbecc653ec3"
ARG IIC_OSIC_NAME="iic-osic"
ADD images/iic-osic/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Create open_pdks (part of OpenLane)
#######################################################################
FROM iic-osic as open_pdks
ARG OPEN_PDKS_REPO_URL="https://github.com/RTimothyEdwards/open_pdks"
ARG OPEN_PDKS_REPO_COMMIT="0c37b7c76527929abfbdbd214df4bffcd260bf50"
ARG OPEN_PDKS_NAME="open_pdks"
ENV PDK_ROOT=/foss/pdks
ADD images/open_pdks/scripts/install_volare.sh install_volare.sh
RUN bash install_volare.sh
ADD images/open_pdks/scripts/install_ihp.sh install_ihp.sh
RUN bash install_ihp.sh 

#######################################################################
# Compile covered 
#######################################################################
FROM base as covered
ARG COVERED_REPO_URL="https://github.com/hpretl/verilog-covered"
ARG COVERED_REPO_COMMIT="19d30fc942642b14dc24e95331cd4777c8dcbad9"
ARG COVERED_NAME="covered"
ADD images/covered/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile cvc_rv (part of OpenLane)
#######################################################################
FROM base as cvc_rv
ARG CVC_RV_REPO_URL="https://github.com/d-m-bailey/cvc"
ARG CVC_RV_REPO_COMMIT="df85a637e83da870129c93c8793cad282bb8ddd1"
ARG CVC_RV_NAME="cvc_rv"
ADD images/cvc_rv/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile fault
#######################################################################
# FIXME build dependencies clean as stand-alone stages
FROM base as fault
ARG FAULT_REPO_URL="https://github.com/Cloud-V/Fault"
ARG FAULT_REPO_COMMIT="080f4be01d236af438566ce0b28089531f21a997"
ARG FAULT_NAME="fault"
ADD images/fault/scripts/dependencies.sh dependencies.sh
RUN bash dependencies.sh
ADD images/fault/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile gaw3-xschem
#######################################################################
FROM base as gaw3-xschem
ARG GAW3_XSCHEM_REPO_URL="https://github.com/StefanSchippers/xschem-gaw.git"
ARG GAW3_XSCHEM_REPO_COMMIT="a4bb956afe84a7792115144f370effe2393228c2"
ARG GAW3_XSCHEM_NAME="gaw3-xschem"
ADD images/gaw3-xschem/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile GDS3D
#######################################################################
FROM open_pdks as gds3d
ARG GDS3D_REPO_URL="https://github.com/trilomix/GDS3D.git"
ARG GDS3D_REPO_COMMIT="173da0cc2f3804984b7e77862fbb0c3f4e308a4b"
ARG GDS3D_NAME="gds3d"
ADD images/gds3d/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ghdl
#######################################################################
FROM base as ghdl
ARG GHDL_REPO_URL="https://github.com/ghdl/ghdl.git"
ARG GHDL_REPO_COMMIT="v3.0.0"
ARG GHDL_NAME="ghdl"
ADD images/ghdl/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile gtkwave
#######################################################################
FROM base as gtkwave
ARG GTKWAVE_REPO_URL="https://github.com/gtkwave/gtkwave"
ARG GTKWAVE_REPO_COMMIT="f31b549cfeca6f6c71f029ea0e9f9d46d5663beb"
ARG GTKWAVE_NAME="gtkwave"
ADD images/gtkwave/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile irsim
#######################################################################
FROM base as irsim
ARG IRSIM_REPO_URL="https://github.com/rtimothyedwards/irsim"
ARG IRSIM_REPO_COMMIT="25fe8217663c06a141156c2e9255e243d308794a"
ARG IRSIM_NAME="irsim"
ADD images/irsim/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile iverilog
#######################################################################
FROM base as iverilog
ARG IVERILOG_REPO_URL="https://github.com/steveicarus/iverilog.git"
ARG IVERILOG_REPO_COMMIT="b210eb82645cb99275e9cccad8348e7d18c96b10"
ARG IVERILOG_NAME="iverilog"
ADD images/iverilog/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile klayout (part of OpenLane)
#######################################################################
FROM basepkg as klayout
ARG KLAYOUT_REPO_URL="https://github.com/KLayout/klayout"
ARG KLAYOUT_REPO_COMMIT="44a2aa9ca17c2b1c154f9c410ded063de9ed3e12"
ARG KLAYOUT_NAME="klayout"
ADD images/klayout/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile netgen (part of OpenLane)
#######################################################################
FROM base as netgen
ARG NETGEN_REPO_URL="https://github.com/rtimothyedwards/netgen"
ARG NETGEN_REPO_COMMIT="28a29504390d53cd3748ff2636be112ef299da0b"
ARG NETGEN_NAME="netgen"
ADD images/netgen/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ngspice
#######################################################################
FROM base as ngspice
ARG NGSPICE_REPO_URL="https://git.code.sf.net/p/ngspice/ngspice"
ARG NGSPICE_REPO_COMMIT="ngspice-40"
ARG NGSPICE_NAME="ngspice"
ADD images/ngspice/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ngspyce
#######################################################################
FROM basepkg as ngspyce
ARG NGSPYCE_REPO_URL="https://github.com/ignamv/ngspyce"
ARG NGSPYCE_REPO_COMMIT="154a2724080e3bf15827549bba9f315cd11984fe"
ARG NGSPYCE_NAME="ngspyce"
ADD images/ngspyce/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile nvc (VHDL simulator)
#######################################################################
FROM base as nvc
ARG NVC_REPO_URL="https://github.com/nickg/nvc"
ARG NVC_REPO_COMMIT="r1.9.1"
ARG NVC_NAME="nvc"
ADD images/nvc/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile openlane (part of OpenLane)
#######################################################################
FROM basepkg as openlane
ARG OPENLANE_REPO_URL="https://github.com/The-OpenROAD-Project/OpenLane"
ARG OPENLANE_REPO_COMMIT="2023.04.19"
ARG OPENLANE_NAME="openlane"
ADD images/openlane/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile openroad (part of OpenLane)
#######################################################################
FROM base as openroad_app
ARG OPENROAD_APP_REPO_URL="https://github.com/The-OpenROAD-Project/OpenROAD.git"
ARG OPENROAD_APP_REPO_COMMIT="b3db49ea3301a7e590bf24126d409bd40199b4af"
ARG OPENROAD_APP_NAME="openroad"
ADD images/openroad/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile padring (part of OpenLane)
#######################################################################
FROM base as padring
ARG PADRING_REPO_URL="https://github.com/donn/padring"
ARG PADRING_REPO_COMMIT="b2a64abcc8561d758c0bcb3945117dcb13bd9dca"
ARG PADRING_NAME="padring"
ADD images/padring/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile qflow helper files
#######################################################################
FROM base as qflow
ARG QFLOW_REPO_URL="https://github.com/RTimothyEdwards/qflow.git"
ARG QFLOW_REPO_COMMIT="b0f76bf4b7dddd59badd67f462e50ed8c9be484c"
ARG QFLOW_NAME="qflow"
ADD images/qflow/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile riscv-gnu-toolchain-rv32i
#######################################################################
FROM base as riscv-gnu-toolchain-rv32i
ARG RISCV_GNU_TOOLCHAIN_RV32I_REPO_URL="https://github.com/riscv-collab/riscv-gnu-toolchain.git"
ARG RISCV_GNU_TOOLCHAIN_RV32I_REPO_COMMIT="2023.04.18"
ARG RISCV_GNU_TOOLCHAIN_RV32I_NAME="riscv-gnu-toolchain-rv32i"
ADD images/riscv-gnu-toolchain-rv32i/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile verilator
#######################################################################
FROM base as verilator
ARG VERILATOR_REPO_URL="https://github.com/verilator/verilator"
ARG VERILATOR_REPO_COMMIT="947402bc57625106e1387255772fdb5d850a6c65"
ARG VERILATOR_NAME="verilator"
ADD images/verilator/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile xschem
#######################################################################
FROM base as xschem
ARG XSCHEM_REPO_URL="https://github.com/StefanSchippers/xschem.git"
ARG XSCHEM_REPO_COMMIT="631fedb11b500a2c3b66fdd7820e213bf77487d5"
ARG XSCHEM_NAME="xschem"
ADD images/xschem/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile xyce & xyce-xdm
#######################################################################
# FIXME build trilinos as own image, clean with commit etc.
FROM base as xyce
ARG XYCE_REPO_URL="https://github.com/Xyce/Xyce.git"
ARG XYCE_REPO_COMMIT="Release-7.6.0"
ARG XYCE_NAME="xyce"
COPY images/xyce/scripts/trilinos.reconfigure.sh /trilinos.reconfigure.sh
COPY images/xyce/scripts/xyce.reconfigure.sh /xyce.reconfigure.sh
ADD images/xyce/scripts/install.sh install.sh
RUN bash install.sh

FROM xyce as xyce-xdm
ARG XYCE_XDM_REPO_URL="https://github.com/Xyce/XDM"
ARG XYCE_XDM_REPO_COMMIT="Release-2.6.0"
ARG XYCE_XDM_NAME="xyce-xdm"
ADD images/xyce-xdm/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile yosys (part of OpenLane) & yosys-ghdl-plugin
#######################################################################
FROM base as yosys
ARG YOSYS_REPO_URL="https://github.com/YosysHQ/yosys"
ARG YOSYS_REPO_COMMIT="101075611fc5698739180017bf96b1abf140c8e7"
ARG YOSYS_NAME="yosys"
ADD images/yosys/scripts/install.sh install.sh
RUN bash install.sh

FROM base as ghdl-yosys-plugin
ARG GHDL_YOSYS_PLUGIN_REPO_URL="https://github.com/ghdl/ghdl-yosys-plugin.git"
ARG GHDL_YOSYS_PLUGIN_REPO_COMMIT="5b64ccfdeee6c75f70487c1ea153ec3e1fb26cd1"
ARG GHDL_YOSYS_PLUGIN_NAME="ghdl-yosys-plugin"
COPY --from=yosys	/foss/tools/	/foss/tools/
COPY --from=ghdl	/foss/tools/	/foss/tools/
ADD images/ghdl-yosys-plugin/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Final output container
#######################################################################
FROM basepkg as iic-osic-tools

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:80/?password=start

ENV VNC_PORT=5901 \
    NO_VNC_PORT=80 \
    JUPYTER_PORT=8888
EXPOSE $VNC_PORT $NO_VNC_PORT $JUPYTER_PORT

### Environment config
ENV HOME=/headless \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    NO_VNC_HOME=/usr/share/novnc \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1680x1050 \
    VNC_PW=abc123 \
    VNC_VIEW_ONLY=false \
    DESIGNS=/foss/designs \
    TOOLS=/foss/tools \
    PDK_ROOT=/foss/pdks

### FIXME workaround for OpenMPI throwing errors when run inside a container without Capability "SYS_PTRACE".
ENV OMPI_MCA_btl_vader_single_copy_mechanism=none

### Copy all required scripts into the container and allow them to be executed by any user.
ADD images/iic-osic-tools/scripts/ $STARTUPDIR/scripts
RUN find $STARTUPDIR/scripts -name '*.sh' -exec chmod a+x {} +

## Install all apt and pip packages, as well as novnc from sources
RUN $STARTUPDIR/scripts/install.sh

### Copy xfce UI configuration
ADD images/iic-osic-tools/addons/xfce/ $HOME/

COPY --from=open_pdks                    /foss/pdks/             /foss/pdks/
COPY --from=covered                      /foss/tools/            /foss/tools/
COPY --from=cvc_rv                       /foss/tools/            /foss/tools/
COPY --from=fault                        /foss/tools/            /foss/tools/
COPY --from=fault                        /opt/swift/usr/lib/     /opt/swift/usr/lib/
COPY --from=gaw3-xschem                  /foss/tools/            /foss/tools/
COPY --from=gds3d                        /foss/tools/            /foss/tools/
COPY --from=gds3d                        /foss/pdks/             /foss/pdks/
COPY --from=ghdl                         /foss/tools/            /foss/tools/
COPY --from=gtkwave                      /foss/tools/            /foss/tools/
COPY --from=iic-osic                     /foss/tools/            /foss/tools/
COPY --from=irsim                        /foss/tools/            /foss/tools/
COPY --from=iverilog                     /foss/tools/            /foss/tools/
COPY --from=klayout                      /foss/tools/            /foss/tools/
COPY --from=magic                        /foss/tools/            /foss/tools/
COPY --from=netgen                       /foss/tools/            /foss/tools/
COPY --from=nvc                          /foss/tools/            /foss/tools/    
COPY --from=ngspice                      /foss/tools/            /foss/tools/
COPY --from=ngspyce                      /foss/tools/            /foss/tools/
COPY --from=openlane                     /foss/tools/            /foss/tools/
COPY --from=openroad_app                 /foss/tools/            /foss/tools/
COPY --from=padring                      /foss/tools/            /foss/tools/
COPY --from=qflow                        /foss/tools/            /foss/tools/
COPY --from=riscv-gnu-toolchain-rv32i    /foss/tools/            /foss/tools/
COPY --from=verilator                    /foss/tools/            /foss/tools/
COPY --from=xschem                       /foss/tools/            /foss/tools/
COPY --from=xyce                         /foss/tools/            /foss/tools/
COPY --from=xyce-xdm                     /foss/tools/            /foss/tools/
COPY --from=yosys                        /foss/tools/            /foss/tools/
COPY --from=ghdl-yosys-plugin            /foss/tools_add/        /foss/tools/

ADD  images/iic-osic-tools/addons/sak			/foss/tools/sak
COPY images/iic-osic-tools/addons/.klayout/		/headless/.klayout/
COPY images/iic-osic-tools/addons/.gaw/			/headless/.gaw/
COPY images/iic-osic-tools/addons/examples		/foss/examples
COPY images/iic-osic-tools/addons/.spiceinit	/headless/.spiceinit
COPY images/iic-osic-tools/addons/.Xclients		/headless/.Xclients
COPY images/iic-osic-tools/addons/.jupyter		/headless/.jupyter
COPY tool_metadata.yml                          /

# Install examples
RUN git clone https://github.com/iic-jku/SKY130_SAR-ADC1        /foss/examples/SKY130_SAR-ADC1 && \
    git clone https://github.com/iic-jku/SKY130_PLL1.git        /foss/examples/SKY130_PLL1 && \
    git clone https://github.com/mabrains/Analog_blocks.git     /foss/examples/SKY130_ANALOG-BLOCKS

# Finalize setup/install
RUN $STARTUPDIR/scripts/post_install.sh

WORKDIR $DESIGNS
USER 1000:1000
ENTRYPOINT ["/dockerstartup/scripts/ui_startup.sh"]
CMD ["--wait"]
