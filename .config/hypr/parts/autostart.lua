-- List the programs here
local autostart = {
  "wayle panel start", -- Status bar
  "awww-daemon", -- Wallpaper daemon
  "mako", -- Notification daemon
  "wl-clip-persist --clipboard regular", -- Enable clipboard persistence
  "/usr/lib/xfce-polkit/xfce-polkit", -- Policy manager
  "elephant", -- Data provider service, if you're on non-systemd distros you must manually start it
  "walker --gapplication-service", -- MultiPurpose launcher
  ""
  "bash -c '[[ -f \"$HOME/.current_wallpaper\" ]] && swaybg -i \"$(cat $HOME/.current_wallpaper)\" -m fill'" -- Restore wallpaper
}

-- Then autostart the listed programs
hl.on("hyprland.start", function()
    for i = 1, #autostart do
        hl.exec_cmd(autostart[i])
    end
end)
