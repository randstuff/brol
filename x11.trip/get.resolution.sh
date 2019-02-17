#!/bin/sh 

# shitty way 
xrandr | grep " connected "

# way 2
xdpyinfo | awk '/dimensions/{print $2}'
# way 3
xdpyinfo  | grep -oP 'dimensions:\s+\K\S+'

