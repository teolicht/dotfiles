local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", "items.calendar", {
    position = "right",
    width = settings.group_paddings
})

local cal = sbar.add("item", {
    icon = {
        font = "SF Pro:Medium:14.0",
        padding_left = 7,
        -- color = colors.white,
        -- padding_left = 8,
        -- font = {
        --     size = 22.0
        -- }
    },
    label = {
        color = colors.white,
        padding_left = 8,
        padding_right = 8,
        align = "center",
        font = "SF Pro:Bold:15.0",
        y_offset = 1.5,
    },
    position = "right",
    update_freq = 30,
    padding_left = 1,
    padding_right = 1,
    background = {
        color = colors.bg1,
        border_color = colors.transparent,
        border_width = 0
    }
})

-- Double border for calendar using a single item bracket
-- sbar.add("bracket", { cal.name }, {
--   background = {
--     color = colors.transparent,
--     height = 30,
--     border_color = colors.grey,
--   }
-- })

-- Padding item required because of bracket
sbar.add("item", {
    position = "right",
    width = settings.group_paddings
})

cal:subscribe({"forced", "routine", "system_woke"}, function(env)
    sbar.exec("date '+%a, %b %-d'", function(d)
        d = d and d:gsub("%s+$","") or "—"
        sbar.exec("date '+%H:%M'", function(t)
            t = t and t:gsub("%s+$","") or ""
            cal:set({
                icon = {
                    string = d
                }
            })
            cal:set({
                label = {
                  string = t
                }
            })
        end)
    end)
end)
