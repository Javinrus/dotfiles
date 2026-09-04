hl.window_rule({
    name = "Thunar dialogs",
    match = {
        class = "thunar|Thunar",
        title = 'Rename "*.*"|File Operation Progress|Confirm to replace files|Attention'
    },

    float = true,
    persistent_size = true,
})

hl.window_rule({
    name = "Thunar stayfocused",
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
