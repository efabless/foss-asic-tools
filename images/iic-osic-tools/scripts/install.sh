#!/bin/bash

set -e
set -u

echo "Installing misc. packages"
apt-get install -y \
	nano \
        firefox \
        gedit \
        gettext \
        htop \
        hub \
        libnss-wrapper \
        libqt5widgets5 \
        meld \
        net-tools \
        nmap \
        sudo \
        tcl \
        tcl-tclreadline \
        tcllib \
        tigervnc-standalone-server \
        tk \
        vim \
        xfce4 \
        xfce4-terminal \
        xterm \
        xvfb
#       octave \
#       mailcap \

rm /etc/xdg/autostart/polkit*
/bin/dbus-uuidgen > /etc/machine-id

echo "Install noVNC - HTML5 based VNC viewer"

mkdir -p "$NO_VNC_HOME"/utils/websockify
wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.3.0.tar.gz | tar xz --strip 1 -C "$NO_VNC_HOME"

wget -qO- https://github.com/novnc/websockify/archive/refs/tags/v0.10.0.tar.gz | tar xz --strip 1 -C "$NO_VNC_HOME"/utils/websockify

chmod +x -v "$NO_VNC_HOME"/utils/novnc_proxy
## create index.html to forward automatically to `vnc_lite.html`
ln -s "$NO_VNC_HOME"/vnc_lite.html "$NO_VNC_HOME"/index.html
