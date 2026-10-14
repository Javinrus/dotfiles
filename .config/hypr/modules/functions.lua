-- https://github.com/yayuuu/hyprland-scroll-overview/wiki/ALT-Tab-overview
local overview = {}

local overviewUse = false

local function object_value(value, key)
    if value == nil then
        return nil
    end

    local ok, result = pcall(function()
        return value[key]
    end)

    return ok and result or nil
end

local function selection_state()
    local workspaceId = object_value(hl.get_active_workspace(), "id")
    local windowAddress = object_value(hl.get_active_window(), "address")
    return tostring(workspaceId) .. ":" .. tostring(windowAddress)
end

local function navigate_to_first_column()
    local previousState
    local maxSteps = #(hl.get_windows() or {}) + #(hl.get_workspaces() or {}) + 1

    for _ = 1, maxSteps do
        local currentState = selection_state()
        if currentState == previousState then
            return
        end

        previousState = currentState
        hl.plugin.scrolloverview.navigate("left")
    end
end

local function navigate_next_column()
    local previousState = selection_state()
    hl.plugin.scrolloverview.navigate("right")

    if selection_state() == previousState then
        navigate_to_first_column()
    end
end

function overview.next()
    hl.plugin.scrolloverview.overview("on")
    overviewUse = true
    navigate_next_column()
end

function overview.close()
    hl.plugin.scrolloverview.overview("off")
    overviewUse = false
end

return overview