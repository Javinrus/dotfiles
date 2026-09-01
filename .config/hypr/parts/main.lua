--
hl.config({
    misc = {
        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,

        disable_hyprland_logo        = true,
        force_default_wallpaper      = 0,

        on_focus_under_fullscreen    = 2,
        allow_session_lock_restore   = true,
        middle_click_paste           = false,
        session_lock_xray            = false,


        disable_splash_rendering     = true,
        background_color             = "rgb(" .. theme.surfaceContainer .. ")", -- To be changed
    },

    debug = {
        error_position = 1
    }
})
