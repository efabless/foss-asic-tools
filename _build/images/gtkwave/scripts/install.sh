#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$GTKWAVE_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${GTKWAVE_REPO_URL}" "${GTKWAVE_NAME}"
cd "${GTKWAVE_NAME}"
git checkout "${GTKWAVE_REPO_COMMIT}"


# Remove the parameter that declares a missing include directory as an error because the build fails otherwise.

patch -p1 << EOF
diff --git a/meson.build b/meson.build
index c99f728..931d461 100644
--- a/meson.build
+++ b/meson.build
@@ -160,7 +160,6 @@ test_warning_args = [
     '-Werror=main',
     '-Werror=misleading-indentation',
     '-Werror=missing-braces',
-    '-Werror=missing-include-dirs',
     '-Werror=nonnull',
     '-Werror=overflow',
     '-Werror=parenthesis',
EOF

meson setup build --prefix="${TOOLS}/${GTKWAVE_NAME}/${REPO_COMMIT_SHORT}"
meson compile -C build
meson install -C build
