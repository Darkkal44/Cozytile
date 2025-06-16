#!/bin/bash
# Apply wallpaper using wal
wal -i ~/Wallpaper/a_road_going_through_a_desert.jpeg && wal --theme ~/.cache/wal/e-ink.json

# Start picom
picom --config ~/.config/picom/picom.conf &
