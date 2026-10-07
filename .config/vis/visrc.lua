require("vis")

vis.events.subscribe(vis.events.INIT, function()
  vis:command("set theme adamant")
end)

-- Plugins
local complete_filename = require("plugins.complete-filename")

-- External plugins
local autoclose = require("plugins.vis-autoclose")
local colorizer = require("plugins.vis-colorizer")

colorizer.three = false
colorizer.six   = true
