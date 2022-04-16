ARG NAME
ARG BASE_IMAGE
ARG YOSYS_IMAGE
ARG GHDL_IMAGE
 
FROM ${BASE_IMAGE} as builder
FROM ${YOSYS_IMAGE} as yosys
FROM ${GHDL_IMAGE} as ghdl

COPY --from=yosys	/foss/tools/	/foss/tools/
COPY --from=ghdl	/foss/tools/	/foss/tools/

ARG REPO_URL
ARG REPO_COMMIT
ARG NAME

ADD scripts/install.sh install.sh
RUN bash install.sh
