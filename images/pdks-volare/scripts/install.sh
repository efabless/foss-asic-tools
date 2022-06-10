#!/bin/bash

source scl_source enable devtoolset-8

export PDK_ROOT=/foss/pdk

export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8

volare enable ${REPO_COMMIT}

