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

-- What is this?
-- Basically helps apps to figure out where to store:
local XDG_STATE_HOME  = HOME .. "/.local/state" -- Persistent state/history
local XDG_DATA_HOME   = HOME .. "/.local/share" -- Persistent application data
local XDG_CONFIG_HOME = HOME .. "/.config"      -- Configuration files
local XDG_CACHE_HOME  = HOME .. "/.cache"       -- Disposable cache

-- Your $HOME will then have less weird directories and files
-- https://wiki.archlinux.org/title/XDG_Base_Directory
-- https://wiki.archlinux.org/title/XDG_user_directories

-- XDG specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("XDG_STATE_HOME",  XDG_STATE_HOME)
hl.env("XDG_DATA_HOME",   XDG_DATA_HOME)
hl.env("XDG_CONFIG_HOME", XDG_CONFIG_HOME)
hl.env("XDG_CACHE_HOME",  XDG_CACHE_HOME)

-- Force some apps to use XDG base directories
hl.env("GNUPGHOME",             XDG_DATA_HOME   .. "/gnupg")
hl.env("HISTFILE",              XDG_STATE_HOME  .. "/bash_history")
hl.env("PYTHON_HISTORY",        XDG_STATE_HOME  .. "/python_history")
hl.env("NPM_CONFIG_USERCONFIG", XDG_CONFIG_HOME .. "/npm/npmrc")
hl.env("NPM_CONFIG_CACHE",      XDG_CACHE_HOME  .. "/npm")
hl.env("RUSTUP_HOME",           XDG_DATA_HOME   .. "/rustup")
hl.env("CARGO_HOME",            XDG_DATA_HOME   .. "/cargo")
hl.env("DOCKER_CONFIG",         XDG_CONFIG_HOME .. "/docker")
hl.env("ANDROID_USER_HOME",     XDG_CONFIG_HOME .. "/android")
hl.env("GOPATH",                XDG_DATA_HOME   .. "/go")
hl.env("GOMODCACHE",            XDG_CACHE_HOME  .. "/go/mod")

hl.env(
    "_JAVA_OPTIONS",
    "-Djava.util.prefs.userRoot=" .. XDG_CONFIG_HOME .. "/java"
)

hl.env(
    "GTK2_RC_FILES",
    string.format(
        "%s/gtk-2.0/gtkrc:%s/gtk-2.0/gtkrc.mine",
        XDG_CONFIG_HOME,
        XDG_CONFIG_HOME
    )
)

-- Based on:
-- https://github.com/cebem1nt/dotfiles/blob/main/.config/hypr/config/env.lua
