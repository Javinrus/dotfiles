-- Autostart programs
local autostart = {
  "wayle panel start", -- Status bar
  "swaybg", -- Wallpaper daemon
  "swaync", -- Notification daemon
  "wl-clip-persist --clipboard regular" -- Enable clipboard persistence
  "/usr/lib/xfce-polkit/xfce-polkit", -- Policy manager (prompts permission if app requests)
  "bash -c '[[ -f \"$HOME/.current_wallpaper\" ]] && swaybg -i \"$(cat $HOME/.current_wallpaper)\" -m fill'" -- Restore wallpaper
}

hl.on("hyprland.start", function()
    for i = 1, #autostart do
        hl.exec_cmd(autostart[i])
    end
end)
