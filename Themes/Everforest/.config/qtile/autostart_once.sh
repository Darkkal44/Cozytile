#!/bin/bash
xrandr --output eDP --scale 1.405x1.40625
# Apply wallpaper using wal
wal -b 232A2E -i ~/Wallpaper/fog_forest_2.png &&

# Start picom
picom --config ~/.config/picom/picom.conf &


