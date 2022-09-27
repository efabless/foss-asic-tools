# shellcheck shell=bash

base_path=/foss/tools

function path_add_tool_bin() {
        tool_name=$1
        for d in "$base_path/$tool_name"/*/ ; do
                if [ -d "${d}bin" ]; then
                        export PATH=$PATH:${d}bin
                fi
        done
}

function path_add_tool() {
        tool_name=$1
        for d in "$base_path/$tool_name"/*/ ; do
                if [ -d "${d}" ]; then
                        export PATH=$PATH:${d}
                fi
        done
}

function path_add_tool_custom() {
        custom_path=$1
        for d in $base_path/$custom_path/ ; do
                if [ -d "${d}" ]; then
                        export PATH=$PATH:${d}
                fi
        done
}

if [ -z ${FOSS_PATH_SET+x} ]; then
        path_add_tool_bin "covered"
#FIXME  path_add_tool_bin "cugr"
        path_add_tool_bin "cvc-check"
#FIXME  path_add_tool_bin "drcu"
        path_add_tool "fault"
        path_add_tool_bin "cvc-check"
        path_add_tool_bin "gaw3-xschem"
        path_add_tool_bin "gds3d"
        path_add_tool_bin "ghdl"
        path_add_tool_bin "gtkwave"

        path_add_tool_custom "iic-osic"

        path_add_tool_bin "irsim"
        path_add_tool_bin "iverilog"
        path_add_tool "klayout"
        path_add_tool_bin "magic"
        path_add_tool_bin "netgen"

        path_add_tool_custom "ngscope/*/usr/local/bin"

        path_add_tool_bin "ngspice"
        path_add_tool "openlane"
        path_add_tool_bin "openroad"
        path_add_tool_bin "opensta"
        path_add_tool_bin "padring"
        path_add_tool_bin "qflow"
        path_add_tool_bin "verilator"
        path_add_tool_bin "xschem"
        path_add_tool_bin "xyce/Parallel"
        path_add_tool_bin "yosys"

        export SAK=$TOOLS/sak/
        export PATH=$TOOLS/bin:$SAK:/usr/local/sbin:$PATH

        echo "Final PATH variable:"
        echo "$PATH"

        export FOSS_PATH_SET=1
fi

LD_LIBRARY_PATH=$(realpath $base_path/klayout/*/ )
export LD_LIBRARY_PATH
export LC_ALL=en_US.utf8 && export LANG=en_US.utf8
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
# this get's rid of a few libGL errors
# https://unix.stackexchange.com/questions/589236/libgl-error-no-matching-fbconfigs-or-visuals-found-glxgears-error-docker-cu
export LIBGL_ALWAYS_INDIRECT=1

#----------------------------------------
# Tool Aliases
#----------------------------------------

alias magic='magic -d XR -rcfile $PDKPATH/libs.tech/magic/$PDK.magicrc'
# shellcheck disable=SC2139
alias mmagic-$PDK='MAGTYPE=mag magic -rcfile $PDKPATH/libs.tech/magic/$PDK.magicrc'
# shellcheck disable=SC2139
alias lmagic-$PDK='MAGTYPE=maglef magic -rcfile $PDKPATH/libs.tech/magic/$PDK.magicrc'

alias k='klayout -c $SAK/klayout/tech/sky130A/sky130A.krc -nn $PDKPATH/libs.tech/klayout/sky130A.lyt -l $PDKPATH/libs.tech/klayout/sky130A.lyp'
alias ke='klayout -e -c $SAK/klayout/tech/sky130A/sky130A.krc -nn $PDKPATH/libs.tech/klayout/sky130A.lyt -l $PDKPATH/libs.tech/klayout/sky130A.lyp'
alias kf='klayout -c $SAK/klayout/tech/sky130A/sky130A.krc -nn $PDKPATH/libs.tech/klayout/sky130A.lyt -l $PDKPATH/libs.tech/klayout/sky130A-fom.lyp'

alias xschem='xschem -b --rcfile $PDKPATH/libs.tech/xschem/xschemrc'
alias xschemtcl='xschem --rcfile $PDKPATH/libs.tech/xschem/xschemrc'

alias tt='cd $TOOLS'
alias dd='cd $DESIGNS'
alias pp='cd $PDK_ROOT'
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
alias term='xfce4-terminal'

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

#----------------------------------------
# Source user configs from $DESIGNS
#----------------------------------------

if [ -f "$DESIGNS/.designinit" ]; then
        # shellcheck source=/dev/null
        source "$DESIGNS/.designinit"
fi

#----------------------------------------
# From libnss_wrapper.sh
#----------------------------------------

# shellcheck disable=SC1091
source "$STARTUPDIR/scripts/generate_container_user"
