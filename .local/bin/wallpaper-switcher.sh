#!/usr/bin/env bash

# Wallpaper directory (shared between Artix and Void)
WALL_DIR="/data/images/wallpapers"
STATE_FILE="$HOME/.current_wallpaper"

# Check if directory exists
if [[ ! -d "$WALL_DIR" ]]; then
    notify-send "Error" "Directory not found: $WALL_DIR"
    exit 1
fi

# Select wallpaper via Rofi with previews
chosen=$(
    find "$WALL_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) |
    sort |
    while IFS= read -r img; do
        name=${img##*/}
        printf "%s\x00icon\x1f%s\n" "$name" "$img"
    done |
    rofi -dmenu -show-icons -p "Wallpaper"
)

# Exit if nothing selected
[[ -z "$chosen" ]] && exit 0

# Resolve full path
wallpaper=$(find "$WALL_DIR" -type f -name "$chosen" | head -n 1)

# Exit if wallpaper not found
if [[ -z "$wallpaper" ]]; then
    notify-send "Error" "File not found: $chosen"
    exit 1
fi

# Set wallpaper with swaybg
pkill swaybg 2>/dev/null
swaybg -i "$wallpaper" -m fill &

# Save state so the system remembers
echo "$wallpaper" > "$STATE_FILE"

# Notify changes
notify-send "Wallpaper Switched" "File selected: $chosen"
