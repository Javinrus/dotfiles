-- Keybinds
local scripts = "~/.local/bin/"

-- Set some apps
local terminal = "foot"
local menu     = "rofi"
local file     = "thunar"
local code     = "vscodium"
local browser  = "brave-origin-nightly"
local monitor  = "btop"
local picker   = "hyprpicker"
local shot     = "hyprshot"

-- Writing hl.dsp.exec_cmd() all the time is too long, here is a shortcut
local function prun(cmd, rules)
    return hl.dsp.exec_cmd(cmd, rules)
end

local function srun(name)
    return hl.dsp.exec_cmd(scripts .. name)
end

-- Launch terminal
hl.bind("SUPER + Q",         prun(terminal))
hl.bind("SUPER + SHIFT + Q", prun(terminal, {float = true}))

-- Launch some menus
hl.bind("SUPER + E",      prun("rofimoji"))
hl.bind("SUPER + R",      prun(menu .. " -show drun"))
hl.bind("SUPER + W",      prun(menu .. " -show window"))
hl.bind("SUPER + Z",      srun("wallpaper-select.sh"))
hl.bind("SUPER + ESCAPE", prun("wlogout"))

-- Launch some apps
hl.bind("SUPER + ENTER", prun(code))
hl.bind("SUPER + F",     prun(file))
hl.bind("SUPER + B",     prun(browser))
hl.bind("SUPER + A",     prun(picker .. " -a"))
hl.bind("SUPER + M",     prun(terminal .. " -e " .. monitor))

-- Screenshot
hl.bind("SUPER + PRINT",         prun(shot .. " -m window")) -- Screenshot a window
hl.bind("SUPER + SHIFT + PRINT", prun(shot .. " -m region")) -- Screenshot a selected area

-- Window actions
hl.bind("SUPER + C",     hl.dsp.window.close())
hl.bind("SUPER + X",     hl.dsp.layout("togglesplit"))
hl.bind("SUPER + SPACE", hl.dsp.window.float({ action = "toggle" }))

-- Windows action
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    hl.bind("SUPER + " .. dir, hl.dsp.focus({ direction = dir }))               -- Move focus
    hl.bind("SUPER + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir })) -- Move windows
    hl.bind("SUPER + CTRL + " .. dir, hl.dsp.window.swap({ direction = dir }))  -- Swap windows
end

-- Workspaces action
for i = 1, 10 do
    local key = i % 10 -- map 10 → 0 key
    hl.bind("SUPER + " .. key,         hl.dsp.focus({ workspace = i}))        -- Switch workspaces
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i })) -- Move active window to workspace
end

-- Cycle active workspaces
hl.bind("SUPER + TAB",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

-- Special workspace
hl.bind("SUPER + S",         hl.dsp.workspace.toggle_special("attic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:attic" }))

-- Mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true }) -- Move windows with mouse
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize windows with mouse

-- Laptop specific functions
hl.bind("XF86AudioRaiseVolume", prun("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true }) -- Increase volume by 5%
hl.bind("XF86AudioLowerVolume", prun("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true }) -- Decrease volume by 5%
hl.bind("XF86AudioMute",        prun("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true }) -- Toggle audio output
hl.bind("XF86AudioMicMute",     prun("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true }) -- Toggle audio input
hl.bind("XF86MonBrightnessUp",  prun("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true }) -- Increase brightness by 5%
hl.bind("XF86MonBrightnessDown",prun("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true }) -- Decrease brightness by 5%

-- Media player
hl.bind("SUPER + PERIOD", prun("playerctl next"))        -- Play next media
hl.bind("SUPER + COMMA",  prun("playerctl previous"))    -- Play previous media
hl.bind("SUPER + SLASH",  prun("playerctl play-pause"))  -- Play or pause media
