-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    -- Ignore maximize requests from all apps
    name  = "Suppress maximize events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
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

hl.window_rule({
    name = "Float by title",
    match = { 
        title = ""
    },

    float = true,
    center = true,
    persistent_size = true,
})

hl.window_rule({
    name = "Float by class",
    match = { 
        class = "nwg-look|qt6ct"
    },

    float = true,
    center = true,
    persistent_size = true,
})

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
    name = "Thunar move right bottom",
    match = {
        title = "^(File Operation Progress)$",
        class = "(thunar|Thunar)",
    },
    
    focus_on_activate = false,
    move = "1460 970"
})

hl.window_rule({
    name = "Thunar menu force center",
    match = {
        title = "^(Confirm to replace files)$",
        class = "(thunar|Thunar)"
    },
    
    center = true
})

hl.window_rule({
    name = "Zen/firefox Picture in Picture",
    match = {
        title = "Picture-in-Picture",
        class = "^(zen)(.*)$",
    },

    size = "300 200",
    move = "1600 50",
    border_size = 2,
    pin = true,
    float = true,
    no_initial_focus = true,
    focus_on_activate = true,
    keep_aspect_ratio = true,
})
