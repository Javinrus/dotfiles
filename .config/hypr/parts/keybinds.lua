-- Keybinds
local scripts = "~/.local/bin/"

local terminal = "foot"
local menu     = "rofi"
local file     = "thunar"
local code     = "vscodium"
local browser  = "brave-origin-nightly"

-- Writing hl.dsp.exec_cmd() all the time is too long, here is a shortcut
local function run(cmd, rules)
    return hl.dsp.exec_cmd(cmd, rules)
end

local function srun(name)
    return hl.dsp.exec_cmd(scripts .. name)
end

-- Launch terminal
hl.bind("SUPER + Q",         run(terminal))
hl.bind("SUPER + SHIFT + Q", run(terminal, {float = true}))

-- Launch some menus
hl.bind("SUPER + E",      run("rofimoji"))
hl.bind("SUPER + R",      run(menu .. " -show drun"))
hl.bind("SUPER + W",      run(menu .. " -show window"))
hl.bind("SUPER + Z",      srun("wallpaper-select.sh"))
hl.bind("SUPER + ESCAPE", run("wlogout"))

-- Launch some apps
hl.bind("SUPER + F", run(file))
