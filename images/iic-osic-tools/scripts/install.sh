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
        novnc \
        sudo \
        tcl \
        tcl-tclreadline \
        tcllib \
        tigervnc-standalone-server \
        tk \
        vim \
        vim-gtk3 \
        websockify \
        xfce4 \
        xfce4-terminal \
        xterm \
        xvfb
#       octave \
#       mailcap \

# Remove light-locker, otherwise VNC session locks up
apt purge -y light-locker
apt autoremove -y

#FIXME rm /etc/xdg/autostart/polkit*
/bin/dbus-uuidgen > /etc/machine-id

## create index.html to forward automatically to `vnc_lite.html`
ln -s "$NO_VNC_HOME"/vnc_lite.html "$NO_VNC_HOME"/index.html
