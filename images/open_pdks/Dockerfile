ARG BASE_IMAGE
ARG MAGIC_IMAGE
ARG SKYWATER_IMAGE

FROM ${MAGIC_IMAGE} as magic
FROM ${SKYWATER_IMAGE} as sw
FROM ${BASE_IMAGE} as builder
COPY --from=magic 	/foss/tools/ 	/foss/tools/
COPY --from=sw 		$PDK_ROOT	$PDK_ROOT

ARG REPO_URL
ARG REPO_COMMIT
ARG NAME

ADD scripts/install.sh install.sh
RUN bash install.sh
