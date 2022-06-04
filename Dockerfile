#######################################################################
# Setup base image
#######################################################################
ARG BASE_IMAGE=rockylinux:8
FROM ${BASE_IMAGE} as base

ADD images/base/scripts/dependencies.sh dependencies.sh
RUN bash dependencies.sh

#######################################################################
# Compile magic (part of OpenLane)
#######################################################################
FROM base as magic
ARG MAGIC_REPO_URL="https://github.com/rtimothyedwards/magic"
ARG MAGIC_REPO_COMMIT="a205a0e9419f973346740171618956afe08b2d74"
ARG MAGIC_NAME="magic"

ADD images/magic/scripts/install.sh install.sh
ADD images/magic/magic-cheatsheet.txt magic-cheatsheet.txt
RUN bash install.sh

#######################################################################
# create skywater-pdk (part of OpenLane)
#######################################################################
FROM magic as skywater-pdk
ARG SKYWATER_PDK_REPO_URL="https://github.com/google/skywater-pdk.git"
ARG SKYWATER_PDK_REPO_COMMIT="f70d8ca46961ff92719d8870a18a076370b85f6c"
ARG SKYWATER_PDK_NAME="skywater-pdk"

ENV PDK_ROOT=/foss/pdk

COPY images/skywater-pdk/corners/corners.yml /foss/pdk/corners.yml
COPY images/skywater-pdk/corners/make_timing.py /foss/pdk/make_timing.py

ADD images/skywater-pdk/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Create open_pdks (part of OpenLane)
#######################################################################
FROM skywater-pdk as open_pdks
ARG OPEN_PDKS_REPO_URL="https://github.com/efabless/open_pdks"
ARG OPEN_PDKS_REPO_COMMIT="41c0908b47130d5675ff8484255b43f66463a7d6"
ARG OPEN_PDKS_NAME="open_pdks"

ADD images/open_pdks/scripts/install.sh install.sh
RUN bash install.sh

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
# Compile liblef and libdef
#######################################################################
#FIXME removed CUGR and DRCU, will be deleted in next release
#FROM base as libdef_liblef

#ADD images/libdef_liblef/scripts/install.sh install.sh
#RUN bash install.sh

#######################################################################
# Compile cugr (part of OpenLane)
#######################################################################
#FIXME removed CUGR and DRCU, will be deleted in next release
#FROM libdef_liblef as cugr
#ARG CUGR_REPO_URL="https://github.com/MrHighVoltage/cu-gr.git"
#ARG CUGR_REPO_COMMIT="76e8363477792e8efda48da43fb8e0a8765f0160"
#ARG CUGR_NAME="cugr"

#ADD images/cugr/scripts/install.sh install.sh
#RUN bash install.sh

#######################################################################
# Compile cvc-check (part of OpenLane)
#######################################################################
FROM base as cvc-check

ARG CVC_CHECK_REPO_URL="https://github.com/d-m-bailey/cvc"
ARG CVC_CHECK_REPO_COMMIT="d172016a791af3089b28070d80ad92bdfef9c585"
ARG CVC_CHECK_NAME="cvc-check"

ADD images/cvc-check/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile drcu (part of OpenLane)
#######################################################################
#FIXME removed CUGR and DRCU, will be deleted in next release
#FROM libdef_liblef as drcu
#ARG DRCU_REPO_URL="https://github.com/MrHighVoltage/dr-cu.git"
#ARG DRCU_REPO_COMMIT="5a08ed8d0677ad23f07d17feb78a8a6f5a5b37e9"
#ARG DRCU_NAME="drcu"

#ADD images/drcu/scripts/install.sh install.sh
#RUN bash install.sh

#######################################################################
# Compile fault
#######################################################################
# FIXME build dependencies clean as stand-alone stages
FROM base as fault
ARG FAULT_REPO_URL="https://github.com/Cloud-V/Fault"
ARG FAULT_REPO_COMMIT="5e1545ee361c3f71ba07675c2489fd4b192b7c4e"
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
ARG GAW3_XSCHEM_REPO_COMMIT="98bfc8636f8642ae60e89fde009f83abe3cee9f1"
ARG GAW3_XSCHEM_NAME="gaw3-xschem"

ADD images/gaw3-xschem/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile GDS3D
#######################################################################
FROM base as gds3d
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
ARG GHDL_REPO_COMMIT="v2.0.0"
ARG GHDL_NAME="ghdl"

ADD images/ghdl/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile gtkwave
#######################################################################
FROM base as gtkwave
ARG GTKWAVE_REPO_URL="https://github.com/gtkwave/gtkwave"
ARG GTKWAVE_REPO_COMMIT="48c6409ed001f28eae9dc5fe87bb0b6b1a7c1217"
ARG GTKWAVE_NAME="gtkwave"

ADD images/gtkwave/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile iic-osic
#######################################################################
FROM base as iic-osic
ARG IIC_OSIC_REPO_URL="https://github.com/hpretl/iic-osic.git"
ARG IIC_OSIC_REPO_COMMIT="a98da34600c0f6ed74a6e29133db770d81bf2760"
ARG IIC_OSIC_NAME="iic-osic"

ADD images/iic-osic/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile irsim
#######################################################################
FROM base as irsim
ARG IRSIM_REPO_URL="https://github.com/rtimothyedwards/irsim"
ARG IRSIM_REPO_COMMIT="3813495e55a21a024e62e21bd6993fac068a61b9"
ARG IRSIM_NAME="irsim"

ADD images/irsim/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile iverilog
#######################################################################
FROM base as iverilog
ARG IVERILOG_REPO_URL="https://github.com/steveicarus/iverilog.git"
ARG IVERILOG_REPO_COMMIT="e8bc3bf8ddf3aee6c64047560e2fd2453ec56732"
ARG IVERILOG_NAME="iverilog"

ADD images/iverilog/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile klayout (part of OpenLane)
#######################################################################
FROM base as klayout
ARG KLAYOUT_REPO_URL="https://github.com/KLayout/klayout"
ARG KLAYOUT_REPO_COMMIT="428d0fe8c941faece4eceebc54170cc04d916c03"
ARG KLAYOUT_NAME="klayout"

ADD images/klayout/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile netgen (part of OpenLane)
#######################################################################
FROM base as netgen
ARG NETGEN_REPO_URL="https://github.com/rtimothyedwards/netgen"
ARG NETGEN_REPO_COMMIT="bfb01e032f668c09ff43e889f35d611ef0e4a317"
ARG NETGEN_NAME="netgen"

ADD images/netgen/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ngscope
#######################################################################
FROM base as ngscope
ARG NGSCOPE_REPO_URL="n/a"
ARG NGSCOPE_REPO_COMMIT="0.9.5"
ARG NGSCOPE_NAME="ngscope"

ADD images/ngscope/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ngspice
#######################################################################
FROM base as ngspice
ARG NGSPICE_REPO_URL="https://git.code.sf.net/p/ngspice/ngspice"
ARG NGSPICE_REPO_COMMIT="ngspice-37"
ARG NGSPICE_NAME="ngspice"

ADD images/ngspice/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile openlane (part of OpenLane)
#######################################################################
FROM base as openlane
ARG OPENLANE_REPO_URL="https://github.com/The-OpenROAD-Project/OpenLane"
ARG OPENLANE_REPO_COMMIT="2022.05.18_02.12.32"
ARG OPENLANE_NAME="openlane"

ADD images/openlane/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile openroad (part of OpenLane)
#######################################################################
FROM base as openroad
ARG OPENROAD_REPO_URL="https://github.com/The-OpenROAD-Project/OpenROAD.git"
ARG OPENROAD_REPO_COMMIT="79a46b62da64bbebc18f06b20c42211046de719a"
ARG OPENROAD_NAME="openroad"

ADD images/openroad/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile opensta (part of OpenLane)
#######################################################################
FROM base as opensta
ARG OPENSTA_REPO_URL="https://github.com/The-OpenROAD-Project/OpenSTA"
ARG OPENSTA_REPO_COMMIT="489ffac144d5661b963105f89cb9097e1fd2f8cf"
ARG OPENSTA_NAME="opensta"

ADD images/opensta/scripts/install.sh install.sh
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
# Compile qflow (part of OpenLane)
#######################################################################
FROM base as qflow
ARG QFLOW_REPO_URL="https://github.com/RTimothyEdwards/qflow.git"
ARG QFLOW_REPO_COMMIT="a550469b63e910ede6e3022e2886bca96462c540"
ARG QFLOW_NAME="qflow"

ADD images/qflow/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile riscv-gnu-toolchain-rv32i
#######################################################################
FROM base as riscv-gnu-toolchain-rv32i
ARG RV_TOOLCHAIN_REPO_URL="https://github.com/riscv-collab/riscv-gnu-toolchain.git"
ARG RV_TOOLCHAIN_REPO_COMMIT="1342cd731cf072ca610d7a5a4c54d2153b6bad63"
ARG RV_TOOLCHAIN_NAME="riscv-gnu-toolchain-rv32i"

ADD images/riscv-gnu-toolchain-rv32i/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile verilator
#######################################################################
FROM base as verilator
ARG VERILATOR_REPO_URL="https://github.com/verilator/verilator"
ARG VERILATOR_REPO_COMMIT="v4.222"
ARG VERILATOR_NAME="verilator"

ADD images/verilator/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile xschem
#######################################################################
FROM base as xschem
ARG XSCHEM_REPO_URL="https://github.com/StefanSchippers/xschem.git"
ARG XSCHEM_REPO_COMMIT="2f3d6e0c884a9748721000188553153893ec493c"
ARG XSCHEM_NAME="xschem"

ADD images/xschem/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile xyce & xyce-xdm
#######################################################################
#FIXME build trilinos as own image, clean with commit etc.
FROM base as xyce
ARG XYCE_REPO_URL="https://github.com/Xyce/Xyce.git"
ARG XYCE_REPO_COMMIT="Release-7.5.0"
ARG XYCE_NAME="xyce"

COPY images/xyce/scripts/trilinos.reconfigure.sh /trilinos.reconfigure.sh
COPY images/xyce/scripts/xyce.reconfigure.sh /xyce.reconfigure.sh
ADD images/xyce/scripts/install.sh install.sh
RUN bash install.sh

FROM xyce as xyce-xdm
ARG XYCE_XDM_REPO_URL="https://github.com/Xyce/XDM"
ARG XYCE_XDM_REPO_COMMIT="Release-2.4.0"
ARG XYCE_XDM_NAME="xyce-xdm"

ADD images/xyce-xdm/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile yosys (part of OpenLane) & yosys-ghdl-plugin
#######################################################################
FROM base as yosys
ARG YOSYS_REPO_URL="https://github.com/YosysHQ/yosys"
ARG YOSYS_REPO_COMMIT="cfe940a98b08f1a5d08fb44427db155ba1f18b62"
ARG YOSYS_NAME="yosys"

ADD images/yosys/scripts/install.sh install.sh
RUN bash install.sh

FROM base as ghdl-yosys-plugin
ARG GHDL_YOSYS_REPO_URL="https://github.com/ghdl/ghdl-yosys-plugin.git"
ARG GHDL_YOSYS_REPO_COMMIT="c9b05e481423c55ffcbb856fd5296701f670808c"
ARG GHDL_YOSYS_NAME="ghdl-yosys-plugin"

COPY --from=yosys	/foss/tools/	/foss/tools/
COPY --from=ghdl	/foss/tools/	/foss/tools/

ADD images/ghdl-yosys-plugin/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Final output container
#######################################################################
FROM base as iic-osic-tools

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:80/?password=start

ENV VNC_PORT=5901 \
    NO_VNC_PORT=80
EXPOSE $VNC_PORT $NO_VNC_PORT

### Environment config
ENV HOME=/headless \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    NO_VNC_HOME=/dockerstartup/noVNC \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1680x1050 \
    VNC_PW=abc123 \
    VNC_VIEW_ONLY=false \
    DESIGNS=/foss/designs \
    TOOLS=/foss/tools \
    PDK_ROOT=/foss/pdk

ADD images/iic-osic-tools/scripts/ $STARTUPDIR/scripts
RUN find $STARTUPDIR/scripts -name '*.sh' -exec chmod a+x {} +

## Install all YUM and PIP packages, aswell as novnc from sources
RUN $STARTUPDIR/scripts/install.sh

### Copy xfce UI configuration
ADD images/iic-osic-tools/addons/xfce/ $HOME/

COPY --from=open_pdks                    /foss/pdk/              /foss/pdk/

COPY --from=covered                      /foss/tools/            /foss/tools/
#COPY --from=cugr                         /foss/tools/            /foss/tools/
COPY --from=cvc-check                    /foss/tools/            /foss/tools/
#COPY --from=drcu                         /foss/tools/            /foss/tools/
COPY --from=fault                        /foss/tools/            /foss/tools/
COPY --from=fault                        /usr/lib/swift/linux/   /usr/lib/swift/linux/
COPY --from=gaw3-xschem                  /foss/tools/            /foss/tools/
COPY --from=gds3d                        /foss/tools/            /foss/tools/
COPY --from=gds3d                        /foss/pdk/              /foss/pdk/
COPY --from=ghdl                         /foss/tools/            /foss/tools/
COPY --from=gtkwave                      /foss/tools/            /foss/tools/
COPY --from=iic-osic                     /foss/tools/            /foss/tools/
COPY --from=irsim                        /foss/tools/            /foss/tools/
COPY --from=iverilog                     /foss/tools/            /foss/tools/
COPY --from=klayout                      /foss/tools/            /foss/tools/
COPY --from=magic                        /foss/tools/            /foss/tools/
COPY --from=netgen                       /foss/tools/            /foss/tools/
COPY --from=ngscope                      /foss/tools/            /foss/tools/
COPY --from=ngspice                      /foss/tools/            /foss/tools/
COPY --from=openlane                     /foss/tools/            /foss/tools/
COPY --from=openroad                     /foss/tools/            /foss/tools/
COPY --from=opensta                      /foss/tools/            /foss/tools/
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
COPY images/iic-osic-tools/addons/spice.rc		/headless/spice.rc
COPY images/iic-osic-tools/addons/.Xclients		/headless/.Xclients

# Copy bashrc into place
ADD images/iic-osic-tools/scripts/env.sh $HOME/.bashrc

# Finalize setup/install
RUN $STARTUPDIR/scripts/post_install.sh

### configure startup
RUN $STARTUPDIR/scripts/set_user_permission.sh $STARTUPDIR $HOME

WORKDIR $DESIGNS

USER 1000

ENTRYPOINT ["/dockerstartup/scripts/ui_startup.sh"]

CMD ["--wait"]
