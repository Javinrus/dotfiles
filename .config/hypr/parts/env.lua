-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- Themes
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- I'm making my own cursor theme soon
-- Using Nordzy's for now
hl.env("HYPRCURSOR_THEME", "Nordzy-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("XCURSOR_THEME", "Nordzy-cursor")
hl.env("XCURSOR_SIZE", "32")

-- Toolkit backends
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- XDG specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
