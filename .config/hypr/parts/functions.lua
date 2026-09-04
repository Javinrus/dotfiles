--
--

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
