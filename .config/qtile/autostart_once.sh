#!/bin/bash


# Start picom
picom --config ~/.config/picom/picom.conf &

# Apply wallpaper using wal
feh --bg-scale "$HOME/.local/.Wallpaper/Cozy.jpg"