#!/bin/sh

# Cập nhật & cài đặt các gói cần thiết trong Termux
termux-change-repo
pkg update -y && pkg upgrade -y
pkg install -y proot-distro pulseaudio x11-repo
pkg install -y termux-x11-nightly

# Cài đặt Debian
if proot-distro list | grep -q debian; then
    echo "Debian installed."
else
    proot-distro install debian
fi


# Tải script cài đặt Debian từ GitHub
curl -Lf --progress-bar -o "$HOME/debian-setup.sh" "https://raw.githubusercontent.com/TimTini/AndroidNode/main/debian-setup.sh?$(date +%s)"
chmod +x $HOME/debian-setup.sh

# Copy file vào thư mục Debian
proot-distro login debian -- cp "$HOME/debian-setup.sh" "/root/debian-setup.sh"

# Chạy lệnh bên trong Debian
proot-distro login debian -- /bin/sh /root/debian-setup.sh

proot-distro login debian