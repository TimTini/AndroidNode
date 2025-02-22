#!/bin/sh
termux-change-repo
pkg update -y
pkg upgrade -y
pkg install proot-distro pulseaudio x11-repo termux-x11-nightly -y
proot-distro install debian
proot-distro login debian

apt update
apt install xfce4 xfce4-goodies dbus-x11 -y
apt install tightvncserver autocutsel -y

mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
mv xstartup ~/.vnc/xstartup

apt update && apt install curl -y
curl -fsS https://dl.brave.com/install.sh | bash

# Tạo thư mục ~/bin nếu chưa có
mkdir -p $HOME/bin

# Tạo symbolic links trong ~/bin thay vì /usr/local/bin
ln -sf $HOME/AndroidNode/tx11.sh $HOME/bin/tx11
ln -sf $HOME/AndroidNode/vnc.sh $HOME/bin/vnc

# Thêm ~/bin vào PATH nếu chưa có
if ! grep -q 'export PATH=$HOME/bin:$PATH' $HOME/.bashrc; then
  echo 'export PATH=$HOME/bin:$PATH' >> $HOME/.bashrc
fi

# Áp dụng thay đổi ngay lập tức
export PATH=$HOME/bin:$PATH
