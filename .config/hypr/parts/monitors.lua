-- https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output   = "eDP-1",
  mode     = "1920x1080@60"",
  position = "0x0",
  scale    = 1,
})

-- Mirror default monitor to all plugged monitors
hl.monitor({  
    output   = "",  
    mode     = "preferred",  
    position = "auto",  
    scale    = "1",  
    mirror   = "eDP-1",
})
