#!/bin/bash

# @brief: Start a VNC server and a noVNC server

DISPLAY=':2'
VNC_SCREEN_SIZE='1920x1080'
VNC_COLOR_DEPTH='24'
VNC_SCREEN_DPI='96'
VNC_PORT='5902'
NOVNC_PORT='6902'

vncserver $DISPLAY -geometry $VNC_SCREEN_SIZE -depth $VNC_COLOR_DEPTH -dpi $VNC_SCREEN_DPI
websockify --daemon --web=/usr/share/novnc/ $NOVNC_PORT localhost:$VNC_PORT

echo "=== VNC server started on $DISPLAY with port $VNC_PORT"
echo "=== noVNC server started on port $NOVNC_PORT"
echo "=== Remember to forward the ports to your host machine."
