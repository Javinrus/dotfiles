-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
local HOME = os.getenv("HOME")

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

-- Good sir, what is this?
-- Basically helps apps to figure out where to store:
local XDG_STATE_HOME  = HOME .. "/.local/state" -- Persistent state/history
local XDG_DATA_HOME   = HOME .. "/.local/share" -- Persistent application data
local XDG_CONFIG_HOME = HOME .. "/.config"      -- Configuration files
local XDG_CACHE_HOME  = HOME .. "/.cache"       -- Disposable cache

-- Global XDG environment variables 
hl.env("XDG_STATE_HOME",  XDG_STATE_HOME)
hl.env("XDG_DATA_HOME",   XDG_DATA_HOME)
hl.env("XDG_CONFIG_HOME", XDG_CONFIG_HOME)
hl.env("XDG_CACHE_HOME",  XDG_CACHE_HOME)

-- I found this very useful, thanks man!
-- https://github.com/cebem1nt/dotfiles/blob/main/.config/hypr/config/env.lua
