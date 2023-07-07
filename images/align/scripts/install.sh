#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$ALIGN_REPO_COMMIT" | cut -c 1-7)

if [ "$(arch)" == "x86_64" ]; then
    #FIXME compile fail on arm64 needs fixing
    mkdir -p "$TOOLS"
    git clone --filter=blob:none "$ALIGN_REPO_URL" "${TOOLS}/$ALIGN_NAME/$REPO_COMMIT_SHORT"
    cd "${TOOLS}/$ALIGN_NAME/$REPO_COMMIT_SHORT" || exit 1
    git checkout "$ALIGN_REPO_COMMIT"

    #python3 setup.py install
    pip3 install . --prefix="${TOOLS}/$ALIGN_NAME/$REPO_COMMIT_SHORT" --no-cache-dir
else
    mkdir -p "${TOOLS}/$ALIGN_NAME"
    echo "This CPU architecture is not supported yet!" > "${TOOLS}/$ALIGN_NAME/README.txt"
fi
