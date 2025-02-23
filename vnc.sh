#!/bin/sh

# Kiểm tra nếu có tiến trình X11 hoặc VNC đang chạy
if pgrep -f "Xtightvnc|Xvnc|Xorg|x11vnc|Xwayland" > /dev/null; then
    echo "Stopping All X11 and VNC servers..."
    pkill -f "Xtightvnc|Xvnc|Xorg|x11vnc|Xwayland"
    sleep 2  # Chỉ đợi nếu có tiến trình cần dừng
fi

# Xóa file lock của X11
rm -f /tmp/.X*-lock
rm -f /tmp/.X11-unix/X*

# Khởi động VNC server
vncserver :1
