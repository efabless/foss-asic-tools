ARG BASE_IMAGE
FROM ${BASE_IMAGE} as base

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

ADD ./scripts/ $STARTUPDIR/scripts
RUN find $STARTUPDIR/scripts -name '*.sh' -exec chmod a+x {} +

## Install all YUM and PIP packages, aswell as novnc from sources
RUN $STARTUPDIR/scripts/install.sh

### Copy xfce UI configuration
ADD ./addons/xfce/ $HOME/

FROM base

COPY --from=open_pdks:latest			/foss/pdk/		/foss/pdk/

COPY --from=covered:latest			/foss/tools/		/foss/tools/
COPY --from=cugr:latest				/foss/tools/		/foss/tools/
COPY --from=cvc-check:latest			/foss/tools/		/foss/tools/
COPY --from=drcu:latest				/foss/tools/		/foss/tools/
COPY --from=fault:latest			/foss/tools/		/foss/tools/
COPY --from=fault:latest			/usr/lib/swift/linux/	/usr/lib/swift/linux/
COPY --from=gaw3-xschem:latest			/foss/tools/		/foss/tools/
COPY --from=ghdl:latest				/foss/tools/		/foss/tools/
COPY --from=gtkwave:latest			/foss/tools/		/foss/tools/
COPY --from=iic-osic:latest			/foss/tools/		/foss/tools/
COPY --from=irsim:latest			/foss/tools/		/foss/tools/
COPY --from=iverilog:latest			/foss/tools/		/foss/tools/
COPY --from=klayout:latest			/foss/tools/		/foss/tools/
COPY --from=magic:latest			/foss/tools/		/foss/tools/
COPY --from=netgen:latest			/foss/tools/		/foss/tools/
COPY --from=ngscope:latest			/foss/tools/		/foss/tools/
COPY --from=ngspice:latest			/foss/tools/		/foss/tools/
COPY --from=openlane:latest			/foss/tools/		/foss/tools/
COPY --from=openroad:latest			/foss/tools/		/foss/tools/
COPY --from=opensta:latest			/foss/tools/		/foss/tools/
COPY --from=padring:latest			/foss/tools/		/foss/tools/
COPY --from=qflow:latest			/foss/tools/		/foss/tools/
COPY --from=riscv-gnu-toolchain-rv32i:latest	/foss/tools/		/foss/tools/
COPY --from=verilator:latest			/foss/tools/		/foss/tools/
COPY --from=xschem:latest			/foss/tools/		/foss/tools/
COPY --from=xyce:latest				/foss/tools/		/foss/tools/
COPY --from=xyce-xdm:latest			/foss/tools/		/foss/tools/
COPY --from=yosys:latest			/foss/tools/		/foss/tools/
COPY --from=ghdl-yosys-plugin:latest		/foss/tools_add/	/foss/tools/	

ADD  ./addons/sak 		/foss/tools/sak
COPY ./addons/.klayout/ 	/headless/.klayout/
COPY ./addons/.gaw/ 	    	/headless/.gaw/
COPY ./addons/examples 		/foss/examples
COPY ./addons/.spiceinit 	/headless/.spiceinit
COPY ./addons/spice.rc 		/headless/spice.rc
COPY ./addons/.Xclients		/headless/.Xclients

# Copy bashrc into place
ADD ./scripts/env.sh $HOME/.bashrc

# Finalize setup/install
RUN $STARTUPDIR/scripts/post_install.sh

### configure startup
RUN $STARTUPDIR/scripts/set_user_permission.sh $STARTUPDIR $HOME

WORKDIR $DESIGNS

USER 1000

ENTRYPOINT ["/dockerstartup/scripts/ui_startup.sh"]

CMD ["--wait"]
