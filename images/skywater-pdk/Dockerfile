ARG BASE_IMAGE
FROM ${BASE_IMAGE} as base
ARG REPO_URL
ARG REPO_COMMIT
ARG NAME

COPY corners/corners.yml /foss/pdks/corners.yml
COPY corners/make_timing.py /foss/pdks/make_timing.py

ADD scripts/dependencies.sh dependencies.sh
RUN bash dependencies.sh

ADD scripts/install.sh install.sh
RUN bash install.sh
