ARG BASE_IMAGE
FROM ${BASE_IMAGE} as base
ARG REPO_URL
ARG REPO_COMMIT
ARG NAME

ENV PDK_ROOT=/foss/pdk

COPY corners/corners.yml /foss/pdk/corners.yml
COPY corners/make_timing.py /foss/pdk/make_timing.py

ADD scripts/install.sh install.sh
RUN bash install.sh
