ARG BASE_IMAGE
FROM ${BASE_IMAGE} as base
ARG REPO_URL
ARG REPO_COMMIT
ARG NAME

ADD scripts/dependencies.sh dependencies.sh
RUN bash dependencies.sh

ADD scripts/install.sh install.sh
RUN bash install.sh
