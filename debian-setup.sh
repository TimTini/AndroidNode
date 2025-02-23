#!/bin/sh
apt update -y
apt install -y curl xfce4 xfce4-goodies dbus-x11 tightvncserver autocutsel

# Cấu hình VNC xstartup
curl -Lf https://raw.githubusercontent.com/TimTini/AndroidNode/main/xstartup -o ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Cài Brave Browser
curl -fsS https://dl.brave.com/install.sh | bash


# Thiết lập lệnh nhanh (tx11 & vnc)
mkdir -p $HOME/bin
curl -Lf https://raw.githubusercontent.com/TimTini/AndroidNode/main/tx11.sh -o $HOME/bin/tx11
curl -Lf https://raw.githubusercontent.com/TimTini/AndroidNode/main/vnc.sh -o $HOME/bin/vnc
chmod +x $HOME/bin/tx11 $HOME/bin/vnc

# Thêm ~/bin vào PATH nếu chưa có trong .bashrc
grep -qxF 'export PATH=$HOME/bin:$PATH' "$HOME/.bashrc" || echo 'export PATH=$HOME/bin:$PATH' >> "$HOME/.bashrc"

# Thêm ~/bin vào PATH nếu chưa có trong .profile
grep -qxF 'export PATH=$HOME/bin:$PATH' "$HOME/.profile" || echo 'export PATH=$HOME/bin:$PATH' >> "$HOME/.profile"

# Cập nhật PATH ngay lập tức cho phiên hiện tại
export PATH="$HOME/bin:$PATH"

