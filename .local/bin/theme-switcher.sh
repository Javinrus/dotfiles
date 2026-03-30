#!/bin/bash

THEME_DIR="$HOME/.config/themes"
KITTY_ACTIVE="$HOME/.config/kitty/themes/current-theme.conf"

themes=$(find "$THEME_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)

chosen=$(printf "%s\n" "$themes" | rofi -dmenu -p "Kitty Theme")

[ -z "$chosen" ] && exit 0

cp "$THEME_DIR/$chosen/kitty.conf" "$KITTY_ACTIVE"

kitty @ set-colors -a "$KITTY_ACTIVE"
