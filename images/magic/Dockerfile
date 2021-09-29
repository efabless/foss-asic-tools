ARG BASE_IMAGE
FROM ${BASE_IMAGE} as builder

ARG REPO_URL
ARG REPO_COMMIT
ARG NAME

ADD scripts/install.sh install.sh
RUN bash install.sh

