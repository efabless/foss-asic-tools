#!/bin/bash
### every exit != 0 fails the script
set -e

## print out help
help (){
echo "
USAGE:
docker run -it -p 80:80 --user \$(id -u):\$(id -g) foss-asic-tools:alpha bash

TAGS:
latest  alpha

This script autodetects if "\$DISPLAY" is set. If it is set, it uses the given X-Server to display the output, or starts VNC otherwise.

OPTIONS:
-X, --x11       Force to use local X11 forwarding, requires a working combination of $DISPLAY, an either port forwards or mounted XAUTHORITY and .X11_unix socket.
-V, --vnc       Force use of VNC server, with noVNC and websockify.
-w, --wait      (default) keeps the UI and the vncserver up until SIGINT or SIGTERM will received
-s, --skip      skip the ui startup and just execute the assigned command. WARNING: this must be the first parameter to the script or it is ignored!
                example: docker run foss-asic-tools --skip bash
-d, --debug     enables more detailed startup output
                e.g. 'docker run foss-asic-tools --debug bash'
-h, --help      print out this help

Fore source information see: https://github.com/hpretl/foss-asic-tools
"
}

# should also source $STARTUPDIR/generate_container_user
source $HOME/.bashrc


# if the first parameter is skip,
if [[ $1 =~ -s|--skip ]]; then
    echo -e "\n\n---------------- SKIPPING UI STARTUP ----------------"
    echo "Executing command: '${@:2}'"
    exec "${@:2}"
    exit $?
fi

while :
do
        case "$1" in
                -X | --x11 )
                        start_x=true
                        shift 1
                        ;;
                -V | --vnc )
                        start_vnc=true
                        shift 1
                        ;;
                -w | --wait )
                        par_wait=true
                        shift 1
                        ;;
                -d | --debug )
                        export DEBUG=true
                        shift 1
                        ;;
                -h | --help )
                        help
                        exit 0
                        ;;
                -- | "")
                        break
                        ;;
                *)
                        echo "Unexpected option \"$1\""
                        help
                        exit 1
                        ;;
        esac
done

## correct forwarding of shutdown signal
cleanup () {
    kill -s SIGTERM $!
    exit 0
}

if [ "$start_x" != true ] && [ "$start_vnc" != true ]; then
  if [ -z ${DISPLAY+x} ]; then
        # DISPLAY not set, so set it and run the startup script.
        start_vnc=true
	export DISPLAY=:1
        echo "Auto-selected VNC"
  else
        start_x=true
        echo "Auto-selected local X11"
  fi

fi

if [ "$start_vnc" = true ]; then
  ## resolve_vnc_connection
  VNC_IP=$(hostname -i)

  ## change vnc password
  echo -e "\n------------------ change VNC password  ------------------"
  # first entry is control, second is view (if only one is valid for both)
  mkdir -p "$HOME/.vnc"
  PASSWD_PATH="$HOME/.vnc/passwd"
  echo "$VNC_PW" | vncpasswd -f > $PASSWD_PATH
  chmod 600 $PASSWD_PATH

  ## start vncserver and noVNC webclient
  echo -e "\n------------------ start noVNC  ----------------------------"

  $NO_VNC_HOME/utils/novnc_proxy --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &> $STARTUPDIR/logs/no_vnc_startup.log &
  #WAIT for VNC server, not for novnc proxy
  #PID_SUB=$!

  echo -e "start vncserver with param: VNC_COL_DEPTH=$VNC_COL_DEPTH, VNC_RESOLUTION=$VNC_RESOLUTION\n..."

  vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION &> $STARTUPDIR/logs/vnc_startup.log
  PID_SUB=$!

  echo -e "start window manager\n..."
  $STARTUPDIR/scripts/wm_startup.sh &> $STARTUPDIR/logs/wm_startup.log

  ## log connect options
  echo -e "\n\n------------------ VNC environment started ------------------"
  echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
  echo -e "\nnoVNC HTML client started:\n\t=> connect via http://localhost/?password=$VNC_PW\n"


  if [[ $DEBUG == true ]] || [[ $1 =~ -t|--tail-log ]]; then
          echo -e "\n------------------ $HOME/.vnc/*$DISPLAY.log ------------------"
          # if option `-t` or `--tail-log` block the execution and tail the VNC log
          tail -f $STARTUPDIR/logs/*.log $HOME/.vnc/*$DISPLAY.log
  fi
fi

if [ "$start_x" = true ]; then
  xfce4-terminal &
  # add empty newline so one can see that this script is done.
  echo
  PID_SUB=$!
fi

if [ "$par_wait" = true ]; then
  trap cleanup SIGINT SIGTERM
  wait $PID_SUB
fi
