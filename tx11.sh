#!/bin/sh
rm -f /tmp/.X*-lock
rm -f /tmp/.X11-unix/X*
termux-x11 :1 -xstartup ~/.vnc/xstartup