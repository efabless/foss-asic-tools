
base_path=/foss/tools/
function get_path() {
  tool_name=$1
  bin_path=$(realpath $base_path/$tool_name/*/bin)
  echo $bin_path
}

if [ -z ${FOSS_PATH_SET+x} ]; then
        covered_path=$(get_path "covered")
        if [ -n "$covered_path" ]; then
                export PATH=$PATH:${covered_path}
        fi
        cugr_path=$(get_path "cugr")
        if [ -n "$cugr_path" ]; then
                export PATH=$PATH:${cugr_path}
        fi
        cvc_check_path=$(get_path "cvc-check")
        if [ -n "$cvc_check_path" ]; then
                export PATH=$PATH:${cvc_check_path}
        fi
        drcu_path=$(get_path "drcu")
        if [ -n "$drcu_path" ]; then
                export PATH=$PATH:${drcu_path}
        fi
        fault_path=$(realpath $base_path/fault/*)
        if [ -n "$fault_path" ]; then
                export PATH=$PATH:${fault_path}
        fi
        gaw3_xschem_path=$(get_path "gaw3-xschem")
        if [ -n "$gaw3_xschem_path" ]; then
                export PATH=$PATH:${gaw3_xschem_path}
        fi
        ghdl_path=$(get_path "ghdl")
        if [ -n "$ghdl_path" ]; then
                export PATH=$PATH:${ghdl_path}
        fi
        gtkwave_path=$(get_path "gtkwave")
        if [ -n "$gtkwave_path" ]; then
                export PATH=$PATH:${gtkwave_path}
        fi
        iic_osic_path=$(realpath $base_path/iic-osic)
        if [ -n "$iic_osic_path" ]; then
                export PATH=$PATH:${iic_osic_path}
        fi
        irsim_path=$(get_path "irsim")
        if [ -n "$irsim_path" ]; then
                export PATH=$PATH:${irsim_path}
        fi
        iverilog_path=$(get_path "iverilog")
        if [ -n "$iverilog_path" ]; then
                export PATH=$PATH:${iverilog_path}
        fi
        klayout_path=$(realpath $base_path/klayout/*)
        if [ -n "$klayout_path" ]; then
                export PATH=$PATH:${klayout_path}
        fi
        magic_path=$(get_path "magic")
        if [ -n "$magic_path" ]; then
                export PATH=$PATH:${magic_path}
        fi
	netgen_path=$(get_path "netgen")
	if [ -n "$netgen_path" ]; then
                export PATH=$PATH:${netgen_path}
        fi
        ngscope_path=$(realpath $base_path/ngscope/*/usr/local/bin)
        if [ -n "$ngscope_path" ]; then
                export PATH=$PATH:${ngscope_path}
        fi
        ngspice_path=$(get_path "ngspice")
        if [ -n "$ngspice_path" ]; then
                export PATH=$PATH:${ngspice_path}
        fi
        openlane_path=$(realpath $base_path/openlane/*)
        if [ -n "$openlane_path" ]; then
                export PATH=$PATH:${openlane_path}
        fi
        openroad_path=$(get_path "openroad")
        if [ -n "$openroad_path" ]; then
                export PATH=$PATH:${openroad_path}
        fi
        opensta_path=$(get_path "opensta")
        if [ -n "$opensta_path" ]; then
                export PATH=$PATH:${opensta_path}
        fi
        padring_path=$(get_path "padring")
        if [ -n "$padring_path" ]; then
                export PATH=$PATH:${padring_path}
        fi
        qflow_path=$(get_path "qflow")
        if [ -n "$qflow_path" ]; then
                export PATH=$PATH:${qflow_path}
        fi
        verilator_path=$(get_path "verilator")
        if [ -n "$verilator_path" ]; then
                export PATH=$PATH:${verilator_path}
        fi
        xschem_path=$(get_path "xschem")
        if [ -n "$xschem_path" ]; then
                export PATH=$PATH:${xschem_path}
        fi
        xyce_path=$(get_path "xyce/Parallel")
        if [ -n "$xyce_path" ]; then
                export PATH=$PATH:${xyce_path}
        fi
        yosys_path=$(get_path "yosys")
        if [ -n "$yosys_path" ]; then
                export PATH=$PATH:${yosys_path}
        fi


	export SAK=$TOOLS/sak/
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
export STD_CELL_LIBRARY=sky130_fd_sc_hd
export OPENLANE_ROOT=$TOOLS/openlane

export EDITOR='gedit'

#FIXME this is a WA until better solution is found for OpenLane version check
export MISMATCHES_OK=1

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

# From libnss_wrapper.sh
source $STARTUPDIR/scripts/generate_container_user
