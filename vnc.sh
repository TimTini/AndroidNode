#!/bin/sh

# Kiểm tra nếu có tiến trình X11 hoặc VNC đang chạy
if pgrep -f "Xtightvnc|Xvnc|Xorg|x11vnc|Xwayland" > /dev/null; then
    echo "Đang dừng các tiến trình X11/VNC..."
    pkill -f "Xtightvnc|Xvnc|Xorg|x11vnc|Xwayland"
    sleep 2  # Chỉ đợi nếu có tiến trình cần dừng
fi

# Xóa file lock của X11
rm -f /tmp/.X*-lock
rm -f /tmp/.X11-unix/X*

# Khởi động VNC server
vncserver :1
