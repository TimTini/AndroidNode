#!/bin/sh

# Cập nhật & cài đặt các gói cần thiết trong Termux
termux-change-repo
pkg update -y && pkg upgrade -y
pkg install -y proot-distro pulseaudio x11-repo
pkg install -y termux-x11-nightly

# Cài đặt Debian
proot-distro install debian

# Chạy lệnh bên trong Debian
proot-distro login debian -- bash -c "
    apt update -y
    apt install -y curl xfce4 xfce4-goodies dbus-x11 tightvncserver autocutsel

    # Cấu hình VNC xstartup
    curl -Lf https://raw.githubusercontent.com/TimTini/AndroidNode/main/xstartup -o ~/.vnc/xstartup
    chmod +x ~/.vnc/xstartup

    # Cài Brave Browser
    curl -fsS https://dl.brave.com/install.sh | bash
"

# Thiết lập lệnh nhanh (tx11 & vnc)
mkdir -p $HOME/bin
curl -Lf https://raw.githubusercontent.com/TimTini/AndroidNode/main/tx11.sh -o $HOME/bin/tx11
curl -Lf https://raw.githubusercontent.com/TimTini/AndroidNode/main/vnc.sh -o $HOME/bin/vnc
chmod +x $HOME/bin/tx11 $HOME/bin/vnc

# Thêm ~/bin vào PATH nếu chưa có
grep -qxF 'export PATH=$HOME/bin:$PATH' $HOME/.bashrc || echo 'export PATH=$HOME/bin:$PATH' >> $HOME/.bashrc
export PATH=$HOME/bin:$PATH
