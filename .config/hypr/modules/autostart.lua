-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    -- Reload plugins
    hl.exec_cmd("hyprpm reload")

    -- Clipboard persistence
    hl.exec_cmd("wl-clip-persist --clipboard regular")

    -- Automatic trash deletion
    hl.exec_cmd("trash-empty -f 30")

    -- Start desktop shell
    hl.exec_cmd("noctalia")
end)
