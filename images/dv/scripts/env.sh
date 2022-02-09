
base_path=/foss/tools
function get_path() {
  tool_name=$1
  bin_path=$(realpath $base_path/$tool_name/*/bin)
  echo $bin_path
}

iverilog_path=$(get_path "iverilog")
riscv32i_path=$(get_path "riscv-gnu-toolchain-rv32i" )
opensta_path=$(get_path "opensta")
cvc_path=$(get_path "cvc")

export PATH=$PATH:${iverilog_path}:${riscv32i_path}:${opensta_path}:${cvc_path}
export GCC_PATH=${riscv32i_path}

