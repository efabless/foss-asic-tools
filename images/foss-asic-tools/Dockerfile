ARG BASE_IMAGE
FROM ${BASE_IMAGE} as base


## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:80/?password=start

ENV DISPLAY=:1 \
    VNC_PORT=5901 \
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
RUN $STARTUPDIR/scripts/tools.sh

### Install xvnc-server & noVNC - HTML5 based VNC viewer
RUN $STARTUPDIR/scripts/tigervnc.sh
RUN $STARTUPDIR/scripts/no_vnc.sh

### Install firefox
RUN $STARTUPDIR/scripts/firefox.sh

### Install xfce UI
RUN $STARTUPDIR/scripts/xfce_ui.sh
ADD ./addons/xfce/ $HOME/

FROM cugr:latest as cugr
FROM cvc-check:latest as cvc-check
FROM dr-cu:latest as dr-cu
FROM gaw3-xschem:latest as gaw3-xschem
FROM gtkwave:latest as gtkwave
FROM iic-osic:latest as iic-osic
FROM irsim:latest as irsim
FROM iverilog:latest as iverilog
FROM klayout:latest as klayout
FROM magic:latest as magic
FROM netgen:latest as netgen
FROM ngscope:latest as ngscope
FROM ngspice:latest as ngspice
FROM openlane:latest as openlane
FROM open_pdks:latest as pdk
FROM openroad:latest as openroad
FROM opensta:latest as opensta
FROM padring:latest as padring
FROM qflow:latest as qflow
FROM verilator:latest as verilator
FROM xschem:latest as xschem
FROM xyce:latest as xyce
FROM yosys:latest as yosys 


FROM base

COPY --from=pdk        		/foss/pdk/    			/foss/pdk/

COPY --from=cugr		/foss/tools/		/foss/tools/
COPY --from=cvc-check		/foss/tools/		/foss/tools/
COPY --from=dr-cu		/foss/tools/		/foss/tools/
COPY --from=gaw3-xschem		/foss/tools/		/foss/tools/
COPY --from=gtkwave		/foss/tools/		/foss/tools/
COPY --from=iic-osic		/foss/tools/		/foss/tools/
COPY --from=irsim		/foss/tools/		/foss/tools/
COPY --from=iverilog		/foss/tools/		/foss/tools/
COPY --from=klayout		/foss/tools/		/foss/tools/
COPY --from=magic		/foss/tools/		/foss/tools/
COPY --from=netgen		/foss/tools/		/foss/tools/
COPY --from=ngscope		/foss/tools/		/foss/tools/
COPY --from=ngspice		/foss/tools/		/foss/tools/
COPY --from=openlane		/foss/tools/		/foss/tools/
COPY --from=openroad		/foss/tools/		/foss/tools/
COPY --from=opensta		/foss/tools/		/foss/tools/
COPY --from=padring		/foss/tools/		/foss/tools/
COPY --from=qflow		/foss/tools/		/foss/tools/
COPY --from=verilator		/foss/tools/		/foss/tools/
COPY --from=xschem		/foss/tools/		/foss/tools/
COPY --from=xyce		/foss/tools/		/foss/tools/
COPY --from=yosys		/foss/tools/		/foss/tools/

ADD  ./addons/sak 		/foss/tools/sak
COPY ./addons/.klayout/ 	/headless/.klayout/
COPY ./addons/.gaw/ 	    	/headless/.gaw/
COPY ./addons/examples 		/foss/examples
COPY ./addons/.spiceinit 	/headless/.spiceinit
COPY ./addons/spice.rc 		/headless/spice.rc

#FIXME RUN $STARTUPDIR/scripts/add_openlane_to_sources.sh
RUN $STARTUPDIR/scripts/apply_spice_modellib_reducer.sh
RUN $STARTUPDIR/scripts/add_custom_magic_bindkeys.sh

ADD ./scripts/env.sh $HOME/.bashrc
RUN bash $HOME/.bashrc

ADD ./scripts/miscellaneous.sh  $STARTUPDIR/scripts/miscellaneous.sh
RUN bash $STARTUPDIR/scripts/miscellaneous.sh

### configure startup
RUN $STARTUPDIR/scripts/libnss_wrapper.sh
RUN $STARTUPDIR/scripts/set_user_permission.sh $STARTUPDIR $HOME

WORKDIR $DESIGNS

USER 1000

ENTRYPOINT ["/dockerstartup/scripts/vnc_startup.sh"]

CMD ["--wait"]

