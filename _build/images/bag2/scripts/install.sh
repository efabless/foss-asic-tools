#! /bin/bash

set -e

# shorten real git commit hashes, but don't mess with tag or branch names
REPO_COMMIT_SHORT=$(git rev-parse --quiet --short "$BAG2_REPO_COMMIT" || echo "$BAG2_REPO_COMMIT")

BAG2_INSTALL_DIR="$TOOLS/$BAG2_NAME/$REPO_COMMIT_SHORT"

mkdir -p "$TOOLS"
git clone --filter=blob:none "$BAG2_REPO_URL" "$BAG2_INSTALL_DIR"
cd "$BAG2_INSTALL_DIR" || exit 1
git checkout "$BAG2_REPO_COMMIT"

./init_submodules.sh
./pip3userinstall.sh
