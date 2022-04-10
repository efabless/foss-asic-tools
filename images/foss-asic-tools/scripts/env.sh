
base_path=/foss/tools/
function get_path() {
  tool_name=$1
  bin_path=$(realpath $base_path/$tool_name/*/bin)
  echo $bin_path
}

if [ -z ${FOSS_PATH_SET+x} ]; then
	#cugr_path=$(get_path "cugr")
	#export PATH=$PATH:${cugr_path}
	#drcu_path=$(get_path "drcu")
	#export PATH=$PATH:${drcu_path}
	covered_path=$(get_path "covered")
	export PATH=$PATH:${covered_path}
	cvc_check_path=$(get_path "cvc-check")
	export PATH=$PATH:${cvc_check_path}
	fault_path=$(realpath $base_path/fault/*)
	export PATH=$PATH:${fault_path}
	gaw3_xschem_path=$(get_path "gaw3-xschem")
	export PATH=$PATH:${gaw3_xschem_path}
	gtkwave_path=$(get_path "gtkwave")
	export PATH=$PATH:${gtkwave_path}
	iic_osic_path=$(realpath $base_path/iic-osic)
	export PATH=$PATH:${iic_osic_path}
	irsim_path=$(get_path "irsim")
	export PATH=$PATH:${irsim_path}
	iverilog_path=$(get_path "iverilog")
	export PATH=$PATH:${iverilog_path}
	klayout_path=$(realpath $base_path/klayout/*)
	export PATH=$PATH:${klayout_path}
	magic_path=$(get_path "magic")
	export PATH=$PATH:${magic_path}
	netgen_path=$(get_path "netgen")
	export PATH=$PATH:${netgen_path}
	ngscope_path=$(realpath $base_path/ngscope/*/usr/local/bin)
	export PATH=$PATH:${ngscope_path}
	ngspice_path=$(get_path "ngspice")
	export PATH=$PATH:${ngspice_path}
	openlane_path=$(realpath $base_path/openlane/*)
	export PATH=$PATH:${openlane_path}
	openroad_path=$(get_path "openroad")
	export PATH=$PATH:${openroad_path}
	opensta_path=$(get_path "opensta")
	export PATH=$PATH:${opensta_path}
	padring_path=$(get_path "padring")
	export PATH=$PATH:${padring_path}
	qflow_path=$(get_path "qflow")
	export PATH=$PATH:${qflow_path}
	verilator_path=$(get_path "verilator")
	export PATH=$PATH:${verilator_path}
	xschem_path=$(get_path "xschem")
	export PATH=$PATH:${xschem_path}
	xyce_path=$(get_path "xyce/Parallel")
	export PATH=$PATH:${xyce_path}
	yosys_path=$(get_path "yosys")
	export PATH=$PATH:${yosys_path}

	export PATH=$TOOLS/bin:$SAK:/usr/local/sbin:$PATH

	echo "Final PATH variable:"
	echo $PATH

	export FOSS_PATH_SET=1
fi

export LD_LIBRARY_PATH=$(realpath $base_path/klayout/*/ )
export LC_ALL=en_US.utf-8 && export LANG=en_US.utf-8
#FIXME Fix warning when KLayout starts, maybe there is a cleaner solution
export XDG_RUNTIME_DIR=/tmp/runtime-default
export ATALANTA_MAN=/usr/local/share/atalanta

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

