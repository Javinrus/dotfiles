#!/bin/bash

# Wallpaper directory (shared between Artix and Void)
WALL_DIR="/mnt/Data/images/wallpapers/"
STATE_FILE="$HOME/.current_wallpaper"


# Check if directory exists
if [[ ! -d "$WALL_DIR" ]]; then
    notify-send "Error" "Wallpaper directory not found: $WALL_DIR"
    exit 1
fi

# Select wallpaper with previews
chosen=$(
    find "$WALL_DIR" -type f \
)

# ===UNDER CONSTRUCTION===
# Below are references I'm using


chosen=$(
    find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) \
    -exec basename {} \; | sort | while read -r img; do
        printf "%s\x00icon\x1f%s\n" "$img" "$WALL_DIR/$img"
    done | rofi -dmenu -show-icons -p "🎨 Wallpaper"
)

[ -z "$chosen" ] && exit

# Get full path (your grep approach works but this is safer)
full_path="$WALL_DIR/$chosen"

# Apply wallpaper
pkill -x swaybg
swaybg -i "$full_path" -m fill &

# Save for persistence
echo "$full_path" > "$STATE_FILE"

# Optional notification (if you want it)
command -v notify-send >/dev/null && notify-send "Wallpaper" "Set to $chosen" -t 1500







# Find all image files (common formats)
mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.webp" -o \
    -iname "*.bmp" -o \
    -iname "*.gif" \) | sort)

# Check if any wallpapers found
if [ ${#wallpapers[@]} -eq 0 ]; then
    notify-send "Error" "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Create Rofi menu with just filenames (for display)
wallpaper_names=()
for path in "${wallpapers[@]}"; do
    wallpaper_names+=("$(basename "$path")")
done

# Show Rofi dmenu
selected_name=$(printf '%s\n' "${wallpaper_names[@]}" | \
    rofi -dmenu -i -p "󰸉 Wallpaper" \
    -theme-str 'window {width: 600px;}' \
    -theme-str 'listview {lines: 15;}')

# Exit if nothing selected
if [ -z "$selected_name" ]; then
    exit 0
fi

# Find the full path of selected wallpaper
selected_path=""
for path in "${wallpapers[@]}"; do
    if [[ "$(basename "$path")" == "$selected_name" ]]; then
        selected_path="$path"
        break
    fi
done

# Kill existing swaybg instances
pkill swaybg

# Set wallpaper with swaybg
swaybg -i "$selected_path" -m fill &

# Save selection for persistence across reboots
WALLPAPER_CACHE="$HOME/.cache/current_wallpaper"
echo "$selected_path" > "$WALLPAPER_CACHE"

# Notify user
notify-send "Wallpaper Changed" "󰸉 $(basename "$selected_path")" -i "$selected_path"

# Optional: Update Hyprland config to persist on restart
# Uncomment if you want to update hyprland.conf
# sed -i "s|exec-once = swaybg -i .*|exec-once = swaybg -i $selected_path -m fill|" \
#     "$HOME/.config/hypr/hyprland.conf"
