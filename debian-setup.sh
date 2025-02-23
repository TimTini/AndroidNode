#!/bin/sh
apt update -y
apt install -y curl xfce4 xfce4-goodies dbus-x11 tightvncserver autocutsel

# Cấu hình VNC xstartup
curl -Lf https://raw.githubusercontent.com/TimTini/AndroidNode/main/xstartup -o ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Cài Brave Browser
curl -fsS https://dl.brave.com/install.sh | bash


# Tạo script chạy Brave với --no-sandbox
mkdir -p "$HOME/bin"
echo '#!/bin/sh' > "$HOME/bin/brave-no-sandbox"
echo 'brave-browser --no-sandbox "$@"' >> "$HOME/bin/brave-no-sandbox"
chmod +x "$HOME/bin/brave-no-sandbox"

# Tạo file desktop entry cho Application Finder
mkdir -p "$HOME/.local/share/applications"
cat > "$HOME/.local/share/applications/brave-no-sandbox.desktop" <<EOF
[Desktop Entry]
Version=1.0
Name=Brave (No Sandbox)
Comment=Launch Brave Browser with --no-sandbox
Exec=$HOME/bin/brave-no-sandbox %U
Icon=brave-browser
Terminal=false
Type=Application
Categories=Network;WebBrowser;
StartupWMClass=brave-browser
EOF

# Cập nhật Application Finder
update-desktop-database ~/.local/share/applications/


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

