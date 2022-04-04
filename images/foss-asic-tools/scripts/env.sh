
base_path=/foss/tools/
function get_path() {
  tool_name=$1
  bin_path=$(realpath $base_path/$tool_name/*/bin)
  echo $bin_path
}

magic_path=$(get_path "magic")
gtkwave_path=$(get_path "gtkwave")
iverilog_path=$(get_path "iverilog")
klayout_path=$(realpath $base_path/klayout/* )
netgen_path=$(get_path "netgen")
#riscv32i_path=$(get_path "riscv-gnu-toolchain-rv32i" )
gaw3_path=$(get_path "gaw3-xschem")
ngscope_path=$(realpath $base_path/ngscope/*/usr/local/bin )
ngspice_path=$(get_path "ngspice")
xschem_path=$(get_path "xschem")
xyce_path=$(get_path "xyce/Parallel")
#covered_path=$(get_path "covered")
opensta_path=$(get_path "opensta")
cvc_path=$(get_path "cvc")
openroad_path=$(realpath $base_path/openlane_tools/bin)
osic_path=$(realpath $base_path/iic-osic )

#export PATH=$PATH:${magic_path}:${gtkwave_path}:${iverilog_path}:${klayout_path}:${netgen_path}:${openlane_tools_path}:${riscv32i_path}:${gaw3_path}:${ngscope_path}:${ngspice_path}:${xschem_path}:${xyce_path}:${covered_path}:${opensta_path}:${cvc_path}
export PATH=$PATH:${magic_path}:${gtkwave_path}:${iverilog_path}:${klayout_path}:${netgen_path}:${openlane_tools_path}:${gaw3_path}:${ngscope_path}:${ngspice_path}:${xschem_path}:${xyce_path}:${opensta_path}:${cvc_path}:${openroad_path}:${osic_path}

export LD_LIBRARY_PATH=$(realpath $base_path/klayout/*/ )
export LC_ALL=en_US.utf-8 && export LANG=en_US.utf-8


export PDK_ROOT=/foss/pdk
export TOOLS=/foss/tools
export DESIGNS=/foss/designs
export PDK=sky130A
export PDKPATH=$PDK_ROOT/$PDK
export OPENLANE_ROOT=$TOOLS/openlane

#FIXME this is a WA until better solution is found for OpenLane version check
export MISMATCHES_OK=1

export SAK=$TOOLS/sak/
export EDITOR='gedit'
export PATH=$TOOLS/bin:$SAK:/usr/local/sbin:$PATH

#----------------------------------------
# Tool Aliases
#----------------------------------------

alias magic='magic -d XR -rcfile $PDKPATH/libs.tech/magic/$PDK.magicrc'
alias mmagic-$PDK='MAGTYPE=mag magic -rcfile $PDKPATH/libs.tech/magic/$PDK.magicrc'
alias lmagic-$PDK='MAGTYPE=maglef magic -rcfile $PDKPATH/libs.tech/magic/$PDK.magicrc'

alias k='klayout -c $SAK/klayout/tech/sky130A/sky130A.krc -nn $PDKPATH/libs.tech/klayout/sky130A.lyt -l $PDKPATH/libs.tech/klayout/sky130A.lyp'
alias ke='klayout -e -c $SAK/klayout/tech/sky130A/sky130A.krc -nn $PDKPATH/libs.tech/klayout/sky130A.lyt -l $PDKPATH/libs.tech/klayout/sky130A.lyp'
alias kf='klayout -c $SAK/klayout/tech/sky130A/sky130A.krc -nn $PDKPATH/libs.tech/klayout/sky130A.lyt -l $PDKPATH/libs.tech/klayout/sky130A-fom.lyp'

alias xschem='xschem --rcfile $PDKPATH/libs.tech/xschem/xschemrc'

alias flow='/foss/tools/openlane/flow.tcl'

alias tt='cd /foss/tools'
alias dd='cd /foss/designs'
alias pp='cd /foss/pdk'
alias destroy='sudo \rm -rf'
alias cp='cp -i'
alias egrep='egrep '
alias fgrep='fgrep '
alias grep='grep '
alias l.='ls -d .* '
alias ll='ls -l'
alias la='ls -al '
alias llt='ls -lt'
alias llta='ls -alt'
alias du='du -skh'
alias mv='mv -i'
alias rm='rm -i'
alias vrc='vi ~/.bashrc'
alias dux='du -sh* | sort -h'
alias shs='md5sum'
alias h='history'
alias hh='history | grep'
alias rc='source ~/.bashrc'
alias m='less'

#----------------------------------------
# Git
#----------------------------------------

alias gcl='git clone'
alias gcll='git clone --single-branch --depth=1'
alias ga='git add'
alias gc='git commit -a'
alias gps='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gss='git status'
alias gr='git remote -v'
alias gl='git log'
alias gln='git log --name-status'
alias gsss='git submodule status'

