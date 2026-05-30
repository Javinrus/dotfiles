-- Monitor devices
local default = "eDP-1"

hl.monitor({
    output   = "default",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1.2,
})

-- Mirror default monitor to all plugged monitors
hl.monitor({  
    output   = "",  
    mode     = "preferred",  
    position = "auto",  
    scale    = "1",  
    mirror   = default  
})
