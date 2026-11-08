-- https://wiki.hypr.land/configuring/core/rules/
hl.window_rule({
    match = { class = ".*" },
    suppress_event  = "maximize",
})

hl.window_rule({
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

hl.window_rule({
    match  = { class = "nwg-look|qt6ct" },
    float  = true,
    center = true,
    persistent_size = true,
})

-- Best file manager
hl.window_rule({
    match = {
        class = "thunar|Thunar",
        title = 'Rename "*.*"|File Operation Progress|Confirm to replace files|Attention|Open File',
    },

    float = true,
    persistent_size = true
})

hl.window_rule({
    match = {
        class = "thunar|Thunar",
        title = 'Attention|Rename "*.*"|Create Document from .*|New .* ...|Create New Folder',
    },

    stay_focused = true
})

hl.window_rule({
    match = {
        class = "(thunar|Thunar)",
        title = "^(Confirm to replace files)$|Open File",
    },

    center = true
})
