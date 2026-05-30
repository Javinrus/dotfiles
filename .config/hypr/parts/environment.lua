-- Environment variables
local HOME = os.getenv("HOME")

-- Cursor variables
hl.env("XCURSOR_SIZE", "32")
hl.env("XCURSOR_THEME", "Nordzy-cursors")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_THEME", "Nordzy-hyprcursors")

-- Wayland variables
hl.env("GDK_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Qt related variables
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
