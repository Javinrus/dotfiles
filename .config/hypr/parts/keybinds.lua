-- Keybinds
local scripts = "~/.local/bin/"

local terminal = "foot"
local files    = "thunar"
local code     = "vscodium"
local browser  = "brave-origin-nightly"
local launcher = "rofi"

-- Writing hl.dsp.exec_cmd() all the time is too long
local function run(cmd, rules)
    return hl.dsp.exec_cmd(cmd, rules)
end

local function slash(name)
    return hl.dsp.exec_cmd(scripts .. name)        
end

-- Launch terminal
hl.bind("SUPER + Q",          run(terminal))
hl.bind("SUPER + SHIFT + Q"), run(terminal, {float = true}))

-- Launch menus
hl.bind("SUPER + R", run(launcher .. " -show drun"))
hl.bind("SUPER + W", run(launcher .. " -show window"))

-- Launch some apps
