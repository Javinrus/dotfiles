-- This was modified as of version 0.55.4
local parts = {
    "parts.monitors",
    "parts.environment",
    "parts.autostart",
    "parts.keybinds",
    "parts.gestures",
    "parts.rules",
    "parts.main",
    "parts.animations",
    "parts.theme"
}

for _, i in ipairs(parts) do
    require(i)
end
