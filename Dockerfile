#######################################################################
# Setup base image
#######################################################################
ARG BASE_IMAGE=ubuntu:jammy
FROM ${BASE_IMAGE} as base
ARG CONTAINER_TAG=unknown
ENV IIC_OSIC_TOOLS_VERSION=${CONTAINER_TAG} \
    DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Vienna \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    TOOLS=/foss/tools \
    PDK_ROOT=/foss/pdks \
    DESIGNS=/foss/designs \
    EXAMPLES=/foss/examples
COPY images/base/scripts/dependencies.sh dependencies.sh
RUN bash dependencies.sh

#######################################################################
# Add base packages (install via pip, npm, or gem)
#######################################################################
FROM base as basepkg
COPY images/base/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile magic (part of OpenLane)
#######################################################################
FROM basepkg as magic
ARG MAGIC_REPO_URL="https://github.com/rtimothyedwards/magic"
ARG MAGIC_REPO_COMMIT="0afe4d87d4aacfbbb2659129a1858a22d216a920"
ARG MAGIC_NAME="magic"
COPY images/magic/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile osic-multitool
#######################################################################
FROM magic as osic-multitool
ARG OSIC_MULTITOOL_REPO_URL="https://github.com/iic-jku/osic-multitool.git"
ARG OSIC_MULTITOOL_REPO_COMMIT="09b0997acd0cbf9ce69857c0c095cfcac89e8fe5"
ARG OSIC_MULTITOOL_NAME="osic-multitool"
COPY images/osic-multitool/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Create open_pdks (part of OpenLane)
#######################################################################
FROM osic-multitool as open_pdks
ARG OPEN_PDKS_REPO_URL="https://github.com/RTimothyEdwards/open_pdks"
ARG OPEN_PDKS_REPO_COMMIT="933e5f2b8e42c5ec25b83c6d242455ada6f3e926"
ARG OPEN_PDKS_NAME="open_pdks"
COPY images/open_pdks/scripts/install_volare.sh install_volare.sh
RUN bash install_volare.sh
COPY images/open_pdks/scripts/install_ihp.sh install_ihp.sh
RUN bash install_ihp.sh 

#######################################################################
# Compile covered 
#######################################################################
FROM base as covered
ARG COVERED_REPO_URL="https://github.com/hpretl/verilog-covered"
ARG COVERED_REPO_COMMIT="19d30fc942642b14dc24e95331cd4777c8dcbad9"
ARG COVERED_NAME="covered"
COPY images/covered/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile cvc_rv (part of OpenLane)
#######################################################################
FROM base as cvc_rv
ARG CVC_RV_REPO_URL="https://github.com/d-m-bailey/cvc"
ARG CVC_RV_REPO_COMMIT="df85a637e83da870129c93c8793cad282bb8ddd1"
ARG CVC_RV_NAME="cvc_rv"
COPY images/cvc_rv/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile fault
#######################################################################
# FIXME build dependencies clean as stand-alone stages
FROM base as fault
ARG FAULT_REPO_URL="https://github.com/Cloud-V/Fault"
ARG FAULT_REPO_COMMIT="54e8665d638393a2e482b237b4ad2b5c02c7ec9a"
ARG FAULT_NAME="fault"
COPY images/fault/scripts/dependencies.sh dependencies.sh
RUN bash dependencies.sh
COPY images/fault/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile gaw3-xschem
#######################################################################
FROM base as gaw3-xschem
ARG GAW3_XSCHEM_REPO_URL="https://github.com/StefanSchippers/xschem-gaw.git"
ARG GAW3_XSCHEM_REPO_COMMIT="a4bb956afe84a7792115144f370effe2393228c2"
ARG GAW3_XSCHEM_NAME="gaw3-xschem"
COPY images/gaw3-xschem/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile GDS3D
#######################################################################
FROM open_pdks as gds3d
ARG GDS3D_REPO_URL="https://github.com/trilomix/GDS3D.git"
ARG GDS3D_REPO_COMMIT="173da0cc2f3804984b7e77862fbb0c3f4e308a4b"
ARG GDS3D_NAME="gds3d"
COPY images/gds3d/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ghdl
#######################################################################
FROM base as ghdl
ARG GHDL_REPO_URL="https://github.com/ghdl/ghdl.git"
ARG GHDL_REPO_COMMIT="v3.0.0"
ARG GHDL_NAME="ghdl"
COPY images/ghdl/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile gtkwave
#######################################################################
FROM base as gtkwave
ARG GTKWAVE_REPO_URL="https://github.com/gtkwave/gtkwave"
ARG GTKWAVE_REPO_COMMIT="8e0bcdb2e3df3078133e9bdf8d326b455f7c1ca5"
ARG GTKWAVE_NAME="gtkwave"
COPY images/gtkwave/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile irsim
#######################################################################
FROM base as irsim
ARG IRSIM_REPO_URL="https://github.com/rtimothyedwards/irsim"
ARG IRSIM_REPO_COMMIT="16777a6af47119730a3e7e99547c8cbc39b4d124"
ARG IRSIM_NAME="irsim"
COPY images/irsim/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile iverilog
#######################################################################
FROM base as iverilog
ARG IVERILOG_REPO_URL="https://github.com/steveicarus/iverilog.git"
ARG IVERILOG_REPO_COMMIT="09f3ebfc885862093a70452f597bff2745c2220d"
ARG IVERILOG_NAME="iverilog"
COPY images/iverilog/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile klayout (part of OpenLane)
#######################################################################
FROM basepkg as klayout
ARG KLAYOUT_REPO_URL="https://github.com/KLayout/klayout"
ARG KLAYOUT_REPO_COMMIT="44a2aa9ca17c2b1c154f9c410ded063de9ed3e12"
ARG KLAYOUT_NAME="klayout"
COPY images/klayout/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile netgen (part of OpenLane)
#######################################################################
FROM base as netgen
ARG NETGEN_REPO_URL="https://github.com/rtimothyedwards/netgen"
ARG NETGEN_REPO_COMMIT="87d8759a6980d297edcb9be6f8661867e4726f9a"
ARG NETGEN_NAME="netgen"
COPY images/netgen/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ngspice
#######################################################################
FROM base as ngspice
ARG NGSPICE_REPO_URL="https://git.code.sf.net/p/ngspice/ngspice"
ARG NGSPICE_REPO_COMMIT="ngspice-41"
ARG NGSPICE_NAME="ngspice"
COPY images/ngspice/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ngspyce
#######################################################################
FROM basepkg as ngspyce
ARG NGSPYCE_REPO_URL="https://github.com/ignamv/ngspyce"
ARG NGSPYCE_REPO_COMMIT="154a2724080e3bf15827549bba9f315cd11984fe"
ARG NGSPYCE_NAME="ngspyce"
COPY images/ngspyce/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile nvc (VHDL simulator)
#######################################################################
FROM base as nvc
ARG NVC_REPO_URL="https://github.com/nickg/nvc"
ARG NVC_REPO_COMMIT="r1.10.1"
ARG NVC_NAME="nvc"
COPY images/nvc/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile openlane (part of OpenLane)
#######################################################################
FROM basepkg as openlane
ARG OPENLANE_REPO_URL="https://github.com/The-OpenROAD-Project/OpenLane"
ARG OPENLANE_REPO_COMMIT="2023.08.11"
ARG OPENLANE_NAME="openlane"
COPY images/openlane/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile openroad (part of OpenLane)
#######################################################################
FROM base as openroad_app
ARG OPENROAD_APP_REPO_URL="https://github.com/The-OpenROAD-Project/OpenROAD.git"
ARG OPENROAD_APP_REPO_COMMIT="0cfb9a45bfb256c9af1a0500d4c97da0f145f54f"
ARG OPENROAD_APP_NAME="openroad"
COPY images/openroad/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile padring (part of OpenLane)
#######################################################################
FROM base as padring
ARG PADRING_REPO_URL="https://github.com/donn/padring"
ARG PADRING_REPO_COMMIT="b2a64abcc8561d758c0bcb3945117dcb13bd9dca"
ARG PADRING_NAME="padring"
COPY images/padring/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile pyopus
#######################################################################
FROM basepkg as pyopus
ARG PYOPUS_REPO_URL="https://fides.fe.uni-lj.si/pyopus/download"
ARG PYOPUS_REPO_COMMIT="0.11"
ARG PYOPUS_NAME="pyopus"
COPY images/pyopus/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile qflow helper files
#######################################################################
FROM base as qflow
ARG QFLOW_REPO_URL="https://github.com/RTimothyEdwards/qflow.git"
ARG QFLOW_REPO_COMMIT="b0f76bf4b7dddd59badd67f462e50ed8c9be484c"
ARG QFLOW_NAME="qflow"
COPY images/qflow/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile qucs-s
#######################################################################
FROM base as qucs-s
ARG QUCS_REPO_URL="https://github.com/ra3xdh/qucs_s"
ARG QUCS_REPO_COMMIT="1.1.0"
ARG QUCS_NAME="qucs-s"
COPY images/qucs-s/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile riscv-gnu-toolchain-rv32i
#######################################################################
FROM base as riscv-gnu-toolchain-rv32i
ARG RISCV_GNU_TOOLCHAIN_RV32I_REPO_URL="https://github.com/riscv-collab/riscv-gnu-toolchain.git"
ARG RISCV_GNU_TOOLCHAIN_RV32I_REPO_COMMIT="2023.07.07"
ARG RISCV_GNU_TOOLCHAIN_RV32I_NAME="riscv-gnu-toolchain-rv32i"
COPY images/riscv-gnu-toolchain-rv32i/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile slang
#######################################################################
FROM base as slang
ARG SLANG_REPO_URL="https://github.com/MikePopoloski/slang.git"
ARG SLANG_REPO_COMMIT="4decdb5cf1bbae1cd291dcbd7cbf83e963bb83f9"
ARG SLANG_NAME="slang"
COPY images/slang/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile verilator (part of OpenLane)
#######################################################################
FROM base as verilator
ARG VERILATOR_REPO_URL="https://github.com/verilator/verilator"
ARG VERILATOR_REPO_COMMIT="947402bc57625106e1387255772fdb5d850a6c65"
ARG VERILATOR_NAME="verilator"
COPY images/verilator/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile xschem
#######################################################################
FROM base as xschem
ARG XSCHEM_REPO_URL="https://github.com/StefanSchippers/xschem.git"
ARG XSCHEM_REPO_COMMIT="e3b9e67cb886fc1155f3c08624599c4ee02ee74b"
ARG XSCHEM_NAME="xschem"
COPY images/xschem/scripts/install.sh install.sh
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
COPY images/xyce/scripts/install.sh install.sh
RUN bash install.sh

FROM xyce as xyce-xdm
ARG XYCE_XDM_REPO_URL="https://github.com/Xyce/XDM"
ARG XYCE_XDM_REPO_COMMIT="Release-2.6.0"
ARG XYCE_XDM_NAME="xyce-xdm"
COPY images/xyce-xdm/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile yosys (part of OpenLane) & yosys-ghdl-plugin
#######################################################################
FROM base as yosys
ARG YOSYS_REPO_URL="https://github.com/YosysHQ/yosys"
ARG YOSYS_REPO_COMMIT="14d50a176d59a5eac95a57a01f9e933297251d5b"
ARG YOSYS_NAME="yosys"
COPY images/yosys/scripts/install.sh install.sh
RUN bash install.sh

FROM base as ghdl-yosys-plugin
ARG GHDL_YOSYS_PLUGIN_REPO_URL="https://github.com/ghdl/ghdl-yosys-plugin.git"
ARG GHDL_YOSYS_PLUGIN_REPO_COMMIT="5b64ccfdeee6c75f70487c1ea153ec3e1fb26cd1"
ARG GHDL_YOSYS_PLUGIN_NAME="ghdl-yosys-plugin"
COPY --from=yosys	${TOOLS}    ${TOOLS}
COPY --from=ghdl	${TOOLS}    ${TOOLS}
COPY images/ghdl-yosys-plugin/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ALIGN-analoglayout
#######################################################################
FROM basepkg as align
ARG ALIGN_REPO_URL="https://github.com/ALIGN-analoglayout/ALIGN-public.git"
ARG ALIGN_REPO_COMMIT="d3954af5ba4deab3c7daec4a0e5fd866d65ef75c"
ARG ALIGN_NAME="align"
COPY images/align/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile ALIGN-analoglayout-sky130
#######################################################################
FROM base as align-pdk-sky130
# FIXME using a forked PDK since a few changes needed
ARG ALIGN_PDK_SKY130_REPO_URL="https://github.com/iic-jku/ALIGN-pdk-sky130.git"
ARG ALIGN_PDK_SKY130_REPO_COMMIT="856e568f809c54580e82e077e93aff98c509b451"
ARG ALIGN_PDK_SKY130_NAME="align-pdk-sky130"
COPY images/align-pdk-sky130/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Compile different components for the rftoolkit
#######################################################################
FROM base as rftoolkit
ARG RFTK_NAME="rftoolkit"
ARG RFTK_FASTHENRY_REPO_URL="https://github.com/ediloren/FastHenry2"
ARG RFTK_FASTHENRY_REPO_COMMIT="363e43ed57ad3b9affa11cba5a86624fad0edaa9"
ARG RFTK_FASTERCAP_REPO_URL="https://github.com/ediloren/FasterCap.git"
ARG RFTK_FASTERCAP_REPO_COMMIT="b42179a8fdd25ab42fe45527282b4a738d7e7f87"
COPY images/rftoolkit/scripts/install.sh install.sh
RUN bash install.sh

#######################################################################
# Final output container
#######################################################################
FROM basepkg as iic-osic-tools

# Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:80/?password=start
ENV VNC_PORT=5901 \
    NO_VNC_PORT=80 \
    JUPYTER_PORT=8888
EXPOSE $VNC_PORT $NO_VNC_PORT $JUPYTER_PORT

# Environment config
ENV HOME=/headless \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    NO_VNC_HOME=/usr/share/novnc \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1680x1050 \
    VNC_PW=abc123 \
    VNC_VIEW_ONLY=false
# FIXME workaround for OpenMPI throwing errors when run inside a container without Capability "SYS_PTRACE".
ENV OMPI_MCA_btl_vader_single_copy_mechanism=none

# Copy all layers into the final container
COPY --from=open_pdks                    ${PDK_ROOT}/           ${PDK_ROOT}/
COPY --from=covered                      ${TOOLS}/              ${TOOLS}/
COPY --from=cvc_rv                       ${TOOLS}/              ${TOOLS}/
COPY --from=fault                        ${TOOLS}/              ${TOOLS}/
COPY --from=fault                        /opt/swift/usr/lib/    /opt/swift/usr/lib/
COPY --from=gaw3-xschem                  ${TOOLS}/              ${TOOLS}/
COPY --from=gds3d                        ${TOOLS}/              ${TOOLS}/
COPY --from=gds3d                        ${PDK_ROOT}/           ${PDK_ROOT}/
COPY --from=ghdl                         ${TOOLS}/              ${TOOLS}/
COPY --from=gtkwave                      ${TOOLS}/              ${TOOLS}/
COPY --from=irsim                        ${TOOLS}/              ${TOOLS}/
COPY --from=iverilog                     ${TOOLS}/              ${TOOLS}/
COPY --from=klayout                      ${TOOLS}/              ${TOOLS}/
COPY --from=magic                        ${TOOLS}/              ${TOOLS}/
COPY --from=netgen                       ${TOOLS}/              ${TOOLS}/
COPY --from=nvc                          ${TOOLS}/              ${TOOLS}/
COPY --from=ngspice                      ${TOOLS}/              ${TOOLS}/
COPY --from=ngspyce                      ${TOOLS}/              ${TOOLS}/
COPY --from=openlane                     ${TOOLS}/              ${TOOLS}/
COPY --from=openroad_app                 ${TOOLS}/              ${TOOLS}/
COPY --from=osic-multitool               ${TOOLS}/              ${TOOLS}/
COPY --from=padring                      ${TOOLS}/              ${TOOLS}/
COPY --from=pyopus                       ${TOOLS}/              ${TOOLS}/
COPY --from=qflow                        ${TOOLS}/              ${TOOLS}/
COPY --from=qucs-s                       ${TOOLS}/              ${TOOLS}/
COPY --from=rftoolkit                    ${TOOLS}/              ${TOOLS}/
COPY --from=riscv-gnu-toolchain-rv32i    ${TOOLS}/              ${TOOLS}/
COPY --from=slang                        ${TOOLS}/              ${TOOLS}/
COPY --from=verilator                    ${TOOLS}/              ${TOOLS}/
COPY --from=xschem                       ${TOOLS}/              ${TOOLS}/
COPY --from=xyce                         ${TOOLS}/              ${TOOLS}/
COPY --from=xyce-xdm                     ${TOOLS}/              ${TOOLS}/
COPY --from=yosys                        ${TOOLS}/              ${TOOLS}/
COPY --from=ghdl-yosys-plugin            ${TOOLS}_add/          ${TOOLS}/
COPY --from=align                        ${TOOLS}/              ${TOOLS}/
COPY --from=align-pdk-sky130             ${TOOLS}/              ${TOOLS}/

# Add design scripts and examples
ADD images/align-utils ${TOOLS}/align-utils

# Copy skeleton and tool version file for OpenLane
COPY images/iic-osic-tools/skel /
COPY tool_metadata.yml /

# Allow scripts to be executed by any user
RUN find $STARTUPDIR/scripts -name '*.sh' -exec chmod a+x {} +

# Install all APT and PIP packages, as well as noVNC from sources
RUN $STARTUPDIR/scripts/install.sh

# Install examples
RUN git clone --depth=1 https://github.com/iic-jku/SKY130_SAR-ADC1 ${EXAMPLES}/SKY130_SAR-ADC1 && \
    git clone --depth=1 https://github.com/iic-jku/SKY130_PLL1.git ${EXAMPLES}/SKY130_PLL1 && \
    git clone --depth=1 https://github.com/mabrains/Analog_blocks.git ${EXAMPLES}/SKY130_ANALOG-BLOCKS

# Finalize setup/install
RUN $STARTUPDIR/scripts/post_install.sh

WORKDIR ${DESIGNS}
USER 1000:1000
ENTRYPOINT ["/dockerstartup/scripts/ui_startup.sh"]
CMD ["--wait"]
