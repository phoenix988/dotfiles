local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")
local var     = require("themes.default.variables")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local font  = require("themes.default.font")

local markup       = lain.util.markup

local widget       = {}

-- Battery
local baticon = wibox.widget.imagebox(theme.bat)
local batbar = wibox.widget {
    forced_height    = 1,
    forced_width     = 90,
    color            = theme.fg_focus,
    background_color = theme.bg_normal,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = 13,
    widget           = wibox.widget.progressbar,
}
local batupd = lain.widget.bat({
    battery = "BAT0", 
    settings = function()
        if bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

        if bat_now.status == "Charging" then
            if bat_now.perc >= 98 then
                baticon:set_image(theme.ac_full)
                batbar:set_color(var.green)
            elseif bat_now.perc > 50 then
                baticon:set_image(theme.ac)
                batbar:set_color(theme.fg_focus)
            elseif bat_now.perc > 15 then
                baticon:set_image(theme.ac)
                batbar:set_color(theme.fg_focus)
            else
                baticon:set_image(theme.ac_low)
                batbar:set_color(red)
            end
        else
            if bat_now.perc >= 98 then
                batbar:set_color(var.green)
                baticon:set_image(theme.bat_full)
            elseif bat_now.perc > 50 then
                batbar:set_color(theme.fg_focus)
                baticon:set_image(theme.bat)
            elseif bat_now.perc > 15 then
                batbar:set_color(theme.fg_focus)
                baticon:set_image(theme.bat_low)
            else
                batbar:set_color(red)
                baticon:set_image(theme.bat_no)
            end
        end
        batbar:set_value(bat_now.perc / 100)
    end
})
local batbg = wibox.container.background(batbar, "#474747", gears.shape.rectangle)
widget.batwidget = wibox.container.margin(batbg, table.unpack(var.bar_size))

widget.baticon = wibox.container.margin(baticon, 0,0, 3, 0)
-- bat widget end



return widget
