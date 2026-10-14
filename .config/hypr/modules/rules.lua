-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
hl.window_rule({
    name  = "Suppress maximize events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "Fix XWayland drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- hl.window_rule({
--     name = "Float by title",
--     match = { 
--         title = ""
--     },
--
--     float = true,
--     center = true,
--     persistent_size = true,
-- })

hl.window_rule({
    name = "Float by class",
    match = { 
        class = "nwg-look|qt6ct"
    },

    float = true,
    center = true,
    persistent_size = true,
})

-- Best file manager
hl.window_rule({
    name = "Thunar dialogs",
    match = {
        class = "thunar|Thunar",
        title = 'Rename "*.*"|File Operation Progress|Confirm to replace files|Attention'
    },

    float = true,
    persistent_size = true
})

hl.window_rule({
    name = "Thunar stay focused",
    match = {
        class = "thunar|Thunar",
        title = 'Attention|Rename "*.*"|Create Document from .*|New .* ...|Create New Folder'
    },

    stay_focused = true
})

hl.window_rule({
    name = "Thunar menu force center",
    match = {
        class = "(thunar|Thunar)",
        title = "^(Confirm to replace files)$",
    },

    center = true
})