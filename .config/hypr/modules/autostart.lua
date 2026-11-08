-- https://wiki.hypr.land/configuring/core/autostart/
hl.on("hyprland.start", function ()
    -- Delete trash
    hl.exec_cmd("trash-empty -f")

    -- Clipboard persistance
    hl.exec_cmd("wl-clip-persist --clipboard regular")

    -- Data provider service
    hl.exec_cmd("elephant")

    -- Start desktop shell
    hl.exec_cmd("quickshell")
end)
