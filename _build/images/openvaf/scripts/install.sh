#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$OPENVAF_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${OPENVAF_REPO_URL}" "${OPENVAF_NAME}"
cd "${OPENVAF_NAME}"
git checkout "${OPENVAF_REPO_COMMIT}"

# LLVM compile (needs LLVM<15)
#./configure  --with-llvm-config --prefix="${TOOLS}/${OPENVAF_NAME}/${REPO_COMMIT_SHORT}"
#make -j"$(nproc)"
#make install

export LLVM_CONFIG=/usr/bin/llvm-config-15

[ ! -f /usr/bin/clang ] && ln -s /usr/bin/clang-15 /usr/bin/clang
[ ! -f /usr/bin/clang-cl ] && ln -s /usr/bin/clang-cl-15 /usr/bin/clang-cl
[ ! -f /usr/bin/llvm-lib ] && ln -s /usr/bin/llvm-lib-15 /usr/bin/llvm-lib
[ ! -f /usr/bin/lld ] && ln -s /usr/bin/lld-15 /usr/bin/lld
[ ! -f /usr/bin/ld.lld ] && ln -s /usr/bin/ld.lld-15 /usr/bin/ld.lld


patch -p1 << EOF
diff --git a/openvaf/target/build.rs b/openvaf/target/build.rs
index 13db6e5..dada68e 100644
--- a/openvaf/target/build.rs
+++ b/openvaf/target/build.rs
@@ -36,7 +36,7 @@ fn gen_msvcrt_importlib(sh: &Shell, arch: &str, target: &str, check: bool) {
     let ucrt_obj = out_dir.join(format!("ucrt_{arch}.obj"));
     cmd!(
         sh,
-        "clang-cl /c /Zl /GS- /clang:--target={target}-pc-windows-msvc /clang:-o{ucrt_obj} {ucrt_src}"
+        "clang -c -fno-autolink -fno-stack-protector --target={target}-pc-windows-msvc -o{ucrt_obj} {ucrt_src}"
     )
     .run()
     .expect("ucrt compilation succeeds");
EOF

cargo build --release --bin openvaf

mkdir -p  /${TOOLS}/${OPENVAF_NAME}/${REPO_COMMIT_SHORT}/bin
cp target/release/openvaf /${TOOLS}/${OPENVAF_NAME}/${REPO_COMMIT_SHORT}/bin
