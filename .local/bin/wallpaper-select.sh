#!/usr/bin/env bash

# Wallpaper directory and file to remember selected wallpaper path
WALL_DIR="/data/images/wallpapers"
STATE_FILE="$HOME/.current_wallpaper"

# Check if directory exists
[[ ! -d "$WALL_DIR" ]] && {
    notify-send "Error" "Directory not found: $WALL_DIR"
    exit 1
}

# Load wallpapers into an array
mapfile -t wallpapers < <(
    find "$WALL_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | sort
)

# Check if wallpapers exist
[[ ${#wallpapers[@]} -eq 0 ]] && {
    notify-send "Error" "No wallpapers found in $WALL_DIR"
    exit 1
}

# Show wallpaper list in Rofi with previews
chosen_index=$(
    for i in "${!wallpapers[@]}"; do
        name=$(basename "${wallpapers[$i]}")
        printf "%s\x00icon\x1f%s\n" "$name" "${wallpapers[$i]}"
    done | rofi -dmenu -show-icons -p "Wallpaper" -format 'i'
)

# Exit if nothing selected
[[ -z "$chosen_index" ]] && exit 0

# Resolve selected index to full path
wallpaper="${wallpapers[$chosen_index]}"

# Set wallpaper with swaybg
pkill swaybg 2>/dev/null
swaybg -i "$wallpaper" -m fill &

# Persist selected wallpaper path
printf '%s\n' "$wallpaper" > "$STATE_FILE"

# Notify changes
notify-send "Wallpaper Changed" "File selected: $(basename "$wallpaper")"
