#!/bin/bash
# every exit != 0 fails the script
set -e

# print out help
help (){
echo "
USAGE:
docker run -d -p 80:80 --user \$(id -u):\$(id -g) hpretl/iic-osic-tools:latest --wait

TAGS (See https://hub.docker.com/r/hpretl/iic-osic-tools/tags):
latest year.month

This script autodetects if \"\$DISPLAY\" is set. If it is set, it uses the given X-Server to display the output, or starts VNC otherwise.

OPTIONS:
-X, --x11       Force to use local X11 forwarding, requires a working combination of \$DISPLAY, either port forwards or mounted XAUTHORITY and .X11_unix socket.
-V, --vnc       Force use of VNC server, with noVNC and websockify.
-w, --wait      Runs the selected UI and waits for them to exit (or until SIGINT or SIGTERM is received). The script will only return then.
-s, --skip      Skips the UI startup and just executes the assigned command. WARNING: this must be the first parameter to the script or it is ignored!
                example: docker run hpretl/iic-osic-tools --skip bash
-d, --debug     enables more detailed startup output
                e.g. 'docker run hpretl/iic-osic-tools --debug bash'
-h, --help      print out this help

For source, information see: https://github.com/hpretl/iic-osic-tools
"
}

# shellcheck disable=SC1091
source "$STARTUPDIR/scripts/generate_container_user.sh"
# shellcheck disable=SC1091
source "$HOME/.bashrc"

# if the first parameter is `skip`:
if [[ $1 =~ -s|--skip ]]; then
    echo -e "\n\n---------------- SKIPPING UI STARTUP ----------------"
    # shellcheck disable=SC2145
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

# correct forwarding of shutdown signal
cleanup () {
    kill -s SIGTERM $!
    exit 0
}

if [ "$start_x" != true ] && [ "$start_vnc" != true ]; then
  if [ -z ${DISPLAY+x} ]; then
        # DISPLAY is not set, so set it and run the startup script.
        start_vnc=true
	export DISPLAY=:1
        echo "Auto-selected VNC"
  else
        start_x=true
        echo "Auto-selected local X11"
  fi

fi

if [ "$start_vnc" = true ]; then
  # resolve_vnc_connection
  VNC_IP=$(hostname -i)

  # change the vnc password
  echo -e "\n------------------ change VNC password  ------------------"
  # first entry is control, second is the view (if only one is valid for both)
  mkdir -p "$HOME/.vnc"
  PASSWD_PATH="$HOME/.vnc/passwd"
  echo "$VNC_PW" | vncpasswd -f > "$PASSWD_PATH"
  chmod 600 "$PASSWD_PATH"

  # start vncserver and noVNC webclient
  echo -e "\n------------------ start noVNC  ----------------------------"

  "$NO_VNC_HOME"/utils/launch.sh --vnc localhost:"$VNC_PORT" --listen "$NO_VNC_PORT" &> "$STARTUPDIR"/logs/no_vnc_startup.log &
  # WAIT for the VNC server, not for novnc proxy
  # PID_SUB=$!

  echo -e "start vncserver with param: VNC_COL_DEPTH=$VNC_COL_DEPTH, VNC_RESOLUTION=$VNC_RESOLUTION\n..."

  # workaround, lock files are not removed if the container is re-run otherwise which makes vncserver unaccessible
  rm -rf /tmp/.X1-lock
  rm -rf /tmp/.X11-unix/X1
  
  vncserver $DISPLAY -depth "$VNC_COL_DEPTH" -geometry "$VNC_RESOLUTION" -noxstartup &> "$STARTUPDIR"/logs/vnc_startup.log
  PID_SUB=$!

  echo -e "start window manager\n..."
  "$STARTUPDIR"/scripts/wm_startup.sh &> "$STARTUPDIR"/logs/wm_startup.log

  # log connect options
  echo -e "\n\n------------------ VNC environment started ------------------"
  echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
  echo -e "\nnoVNC HTML client started:\n\t=> connect via http://localhost/?password=$VNC_PW\n"


  if [[ $DEBUG == true ]] || [[ $1 =~ -t|--tail-log ]]; then
          echo -e "\n------------------ $HOME/.vnc/*$DISPLAY.log ------------------"
          # if the option `-t` or `--tail-log` block the execution and tail the VNC log
          tail -f "$STARTUPDIR"/logs/*.log "$HOME"/.vnc/*$DISPLAY.log
  fi
fi

if [ "$start_x" = true ]; then
  xfce4-terminal &
  PID_SUB=$!
  # add an empty newline so one can see that this script is done.
  echo
fi

if [ "$par_wait" = true ]; then
  trap cleanup SIGINT SIGTERM
  wait $PID_SUB
fi
