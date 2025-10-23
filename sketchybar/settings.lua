local colors = require("colors")
local icons = require("icons")

return {
    paddings = 3,
    group_paddings = 5,
    modes = {
        main = {
            icon = icons.apple,
            color = colors.white,
        },
        service = {
            icon = icons.nuke,
            color = 0xffff9e64
        }
    },
    bar = {
        height = 36,
        padding = {
            x = 10,
            y = 0
        },
        background = colors.bar.bg
    },
    items = {
        height = 26,
        gap = 2,
        padding = {
            right = 16,
            left = 12,
            top = 0,
            bottom = 0
        },
        empty_color = colors.t_light_gray,
        filled_color = colors.purple,
        border_default_color = colors.transparent,
        border_highlight_color = colors.purple,
        colors = {
            background = colors.bg1
        },
        corner_radius = 5
    },

    icons = "sketchybar-app-font:Regular:16.0", -- alternatively available: NerdFont

    font = {
        text = "SF Pro", -- Used for text
        numbers = "SF Mono", -- Used for numbers
        style_map = {
            ["Regular"] = "Regular",
            ["Semibold"] = "Medium",
            ["Bold"] = "SemiBold",
            ["Heavy"] = "Bold",
            ["Black"] = "ExtraBold"
        }
    }
}
