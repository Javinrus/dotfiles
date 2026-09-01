-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    -- Clipboard persistence and history
    hl.exec_cmd("wl-clip-persist --clipboard regular")
    hl.exec_cmd("wl-paste --type text --watch cliphist -max-items=10 store")
    hl.exec_cmd("wl-paste --type image --watch cliphist -max-items=3 store")

    -- Auto delete trash 30 days old
    hl.exec_cmd("trash-empty -f 30")

    -- Start shell
    hl.exec_cmd("quickshell")
end)
