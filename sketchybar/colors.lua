-- "t_..." = 70% opacity

local transparent = 0x00000000

return {
    --= TokyoNight palette =--
    red = 0xfff7768e,
    yellow = 0xffe0af68,
    green = 0xff9ece6a,
    blue = 0xff7aa2f7,
    purple = 0xffbb9af7,
    aqua = 0xff7dcfff,
    light_gray = 0xffc0caf5,
    gray = 0xff8189af,
    dark_gray = 0xff414868,
    black = 0xff15161e,
    t_red = 0x80f7768e,
    t_yellow = 0x80e0af68,
    t_green = 0x809ece6a,
    t_blue = 0x807aa2f7,
    t_purple = 0x80bb9af7,
    t_aqua = 0x807dcfff,
    t_light_gray = 0x80c0caf5,
    t_gray = 0x808189af,
    t_dark_gray = 0x80414868,
    t_black = 0x8015161e,

    --= Other colors =--
    transparent = transparent,
    spotify_green = 0xb31be68c,
    white = 0xffffffff,
    bar = {
        bg = transparent,
    },
    popup = {
        bg = 0xc02c2e34,
        border = 0xff7f8490,
    },
    bg1 = 0x80414868, -- previously tokyonight_palette.t_dark_gray
    bg2 = 0xff414550,

    with_alpha = function(color, alpha)
        if color ~= nil then
            if alpha > 1.0 or alpha < 0.0 then
                return color
            end
            return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
        end
    end,
}

