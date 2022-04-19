#!/bin/bash

set -e
set -u

echo "Installing misc. packages"
yum -y install epel-release
yum install -y \
	python3-pyyaml \
        python3-click \
        libQt5Widgets.so* \
        libtclreadline-2.1.0.* \
        firefox \
        nss_wrapper \
        gettext \
        tigervnc-server \
	bzip2 \
        gedit \
        git \
        gvim \
        htop \
        mailcap \
        meld \
	nano \
        net-tools \
        nmap \
        octave \
        sudo \
        tcl \
        tcllib \
        tk \
        vim \
        wget \
        xorg-x11-server-Xvfb \
        xterm

#FIXME package: hub


echo "Install Xfce4 UI components and disable xfce-polkit" 
yum --enablerepo=epel -y -x gnome-keyring --skip-broken groupinstall "Xfce"
yum -y groups install "Fonts"
yum erase -y *power*
rm /etc/xdg/autostart/xfce-polkit*
/bin/dbus-uuidgen > /etc/machine-id

echo "Cleaning yum cache"
yum clean all

echo "Installing PIP packages"
pip3 install panda

echo "Install noVNC - HTML5 based VNC viewer"

mkdir -p $NO_VNC_HOME/utils/websockify
wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.3.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME

wget -qO- https://github.com/novnc/websockify/archive/refs/tags/v0.10.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify

chmod +x -v $NO_VNC_HOME/utils/novnc_proxy
## create index.html to forward automatically to `vnc_lite.html`
ln -s $NO_VNC_HOME/vnc_lite.html $NO_VNC_HOME/index.html
