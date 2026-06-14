-- This config is a multifile, splitting helps to organize better
-- This was made as of version 0.55.2
local parts = {
    "parts.monitors",
    "parts.environment",
    "parts.autostart",
    "parts.keybinds",
}

for _, i in ipairs(parts) do
    require(i)
end
