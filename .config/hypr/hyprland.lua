-- This was modified as of version 0.55.2
-- This config is a multifile, splitting helps to organize better
local parts = {
    "parts.monitors",
    "parts.environment",
    "parts.autostart",
    "parts.keybinds",
}

for _, i in ipairs(parts) do
    require(i)
end
