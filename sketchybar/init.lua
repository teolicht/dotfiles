-- Require the sketchybar module
sbar = require("sketchybar")

local _old_set = sbar.set
sbar.set = function(item, props, ...)
    local item_name = tostring(item)
    local matched = false
    if type(item) == "string" and item:match("^space%.[0-9]+$") then
        matched = true
    elseif type(item) == "table" and tostring(item.item):match("^space%.[0-9]+$") then
        matched = true
    end

    if matched then
        local logfile = os.getenv("HOME") .. "/space_set_calls.log"
        local f = io.open(logfile, "a")
        if f then
            f:write("==== " .. os.date("%Y-%m-%d %H:%M:%S") .. " ====\n")
            f:write("sbar.set called with item: " .. item_name .. "\n")
            f:write("props: " .. tostring(props) .. "\n")
            f:write(debug.traceback() .. "\n\n")
            f:close()
        end
    end

    return _old_set(item, props, ...)
end

-- Set the bar name, if you are using another bar instance than sketchybar
-- sbar.set_bar_name("bottom_bar")

-- Bundle the entire initial configuration into a single message to sketchybar
sbar.begin_config()
require("bar")
require("default")
-- require("test")
require("items")
sbar.end_config()

-- Run the event loop of the sketchybar module (without this there will be no
-- callback functions executed in the lua module)
sbar.event_loop()
