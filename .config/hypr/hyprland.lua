-- This config is a multifile, splitting helps to organize better
local parts = {
    "parts.environment",
    "parts.monitors",
    "parts.autostart",
    "parts.keybinds",
}

for _, i in ipairs(parts) do
    require(i)
end
