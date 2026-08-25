-- https://wiki.hypr.land/Plugins/Using-Plugins
hl.exec_cmd("hyprpm reload")

-- Prevents a temporary error from plugins not loaded yet
-- This happens because the config is evaluated before plugins are loaded
if hl.plugin.scrolloverview ~= nil then
    hl.config({
        plugin = {
            scrolloverview = {
                gesture_distance = 300,
                scale = 0.7,
                workspace_gap = 30,
                layout = "horizontal",
                wallpaper = 0,
                blur = false,

                shadow = {
                    enabled = false,
                },
            },
        },
    })

    hl.bind("SUPER + SHIFT + W", function()
        hl.plugin.scrolloverview.overview("toggle all")
    end)
end
