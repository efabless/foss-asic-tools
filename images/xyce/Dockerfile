ARG BASE_IMAGE
FROM ${BASE_IMAGE} as builder

ARG REPO_URL
ARG REPO_COMMIT
ARG NAME


ADD scripts/dependencies.sh dependencies.sh
RUN bash dependencies.sh

COPY scripts/trilinos.reconfigure.sh /trilinos.reconfigure.sh
COPY scripts/xyce.reconfigure.sh /xyce.reconfigure.sh
ADD scripts/install.sh install.sh
RUN bash install.sh
