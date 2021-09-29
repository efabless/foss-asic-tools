ARG BASE_IMAGE
ARG MAGIC_IMAGE
ARG SKYWATER_IMAGE


FROM ${MAGIC_IMAGE} as magic
FROM ${SKYWATER_IMAGE} as sw
FROM ${BASE_IMAGE} as builder
COPY --from=magic 	/foss/tools/ 	/foss/tools/
COPY --from=sw 		/foss/pdks/ 	/foss/pdks/

ARG REPO_URL
ARG REPO_COMMIT
ARG NAME

ADD scripts/dependencies.sh dependencies.sh
RUN bash dependencies.sh

ADD scripts/install.sh install.sh
RUN bash install.sh
