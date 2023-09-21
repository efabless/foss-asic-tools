#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$ALIGN_PDK_SKY130_REPO_COMMIT" | cut -c 1-7)

if [ "$(arch)" == "x86_64" ]; then
    #FIXME compile fail on arm64 needs fixing
    mkdir -p "$TOOLS"
    git clone --filter=blob:none "$ALIGN_PDK_SKY130_REPO_URL" "${TOOLS}/$ALIGN_PDK_SKY130_NAME"
    cd "${TOOLS}/$ALIGN_PDK_SKY130_NAME"
    git checkout "$ALIGN_PDK_SKY130_REPO_COMMIT"
else
    mkdir -p "${TOOLS}/$ALIGN_PDK_SKY130_NAME"
    echo "This CPU architecture is not supported yet!" > "${TOOLS}/$ALIGN_PDK_SKY130_NAME/README.txt"
fi
