local colors = require("colors")
local settings = require("settings")

sbar.add("event", "input-change", "AppleSelectedInputSourcesChangedNotification")

local input_item = sbar.add("item", "items.input_source", {
    position = "right",
    icon = {
        string = "",
        font = "JetBrainsMono Nerd Font:Regular:19.0",
        padding_left = 10,
        padding_right = -1
    },
    label = {
        string = "—",
        font = "SF Mono:Heavy:16.0",
        color = colors.white,
        width = 36,
        align = "center",
        padding_right = 3,
        padding_left = 0,
    },
    background = {
        color = colors.t_aqua,
        border_color = colors.transparent,
        -- Gap is too big for some reason, so this is needed
        padding_right = -1,
    }
})

local function update_input_source()
    sbar.exec("macism | awk -F '.' '{print $NF}'", function(input)
        input = input and input:gsub("%s+$","") or "—"
        if input == "Danish" then
            input = "DA"
        end
        input_item:set({
            label = {
                string = input
            }
        })
    end)
end


-- Initial update
update_input_source()

input_item:subscribe("input-change", function(env)
    update_input_source()
end)


sbar.add("item", "items.input.padding", {
    position = "right",
    width = settings.group_paddings
})

