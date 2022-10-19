#!/bin/bash

set -e
set -u

REPO_COMMIT_SHORT=$(echo "$CVC_REPO_COMMIT" | cut -c 1-7)

git clone "${CVC_REPO_URL}" "${CVC_NAME}"
cd "${CVC_NAME}"
git checkout "${CVC_REPO_COMMIT}"
#FIXME this patch is needed since CVC is old. can remove when OL uses newer version
git apply ../cvc_fix.patch
autoreconf -vif
./configure --disable-nls --prefix=/foss/tools/"${CVC_NAME}"/"${REPO_COMMIT_SHORT}"
make -j"$(nproc)"
make install
