# REPO_COMMIT refers to an openlane tag
ARG REPO_COMMIT
ARG BASE_IMAGE
FROM efabless/openlane:${REPO_COMMIT} as openlane

ARG BASE_IMAGE
FROM ${BASE_IMAGE} as builder

ARG REPO_COMMIT
ARG REPO_URL
ARG NAME

#RUN mkdir -p /foss/tools/${NAME}_tools/${REPO_COMMIT}
#RUN mkdir -p /foss/tools/${NAME}/${REPO_COMMIT}
#COPY --from=openlane /build /foss/tools/${NAME}_tools/${REPO_COMMIT}
#RUN git clone ${REPO_URL} --branch=${REPO_COMMIT} #/foss/tools/${NAME}/${REPO_COMMIT}RUN mkdir -p 

RUN mkdir -p /foss/tools/${NAME}_tools/ 
RUN mkdir -p /foss/tools/${NAME}/ 
COPY --from=openlane /build /foss/tools/${NAME}_tools/ 
RUN git clone ${REPO_URL} --branch=${REPO_COMMIT} /foss/tools/${NAME}/
