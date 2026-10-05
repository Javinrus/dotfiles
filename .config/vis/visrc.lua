require("vis")

vis.events.subscribe(vis.events.INIT, function()
  vis:command("set theme adamant")
end)

-- Plugins
local autoclose = require("plugins.vis-autoclose")
local colorizer = require("plugins.vis-colorizer")

colorizer.three = false
colorizer.six   = true
