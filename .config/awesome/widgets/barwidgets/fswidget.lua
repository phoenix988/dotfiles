local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")
local var     = require("themes.default.variables")
local command = require("widgets.layout").command

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local font  = require("themes.default.font")
local file_system = "/"

local markup       = lain.util.markup

local widget       = {}

---- / fs
--local fsicon = wibox.widget.imagebox(theme.disk)
local fsbar = wibox.widget {
    forced_height    = 1,
    forced_width     = var.bar_width,
    color            = theme.fg_focus,
    background_color = theme.bg_normal,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = 13,
    widget           = wibox.widget.progressbar,
}

local fsicon = wibox.widget.textbox()

theme.fs = lain.widget.fs({
    partition = file_system,
    options = "--exclude-type=tmpfs",
    notification_preset = { fg = theme.fg_focus, bg = theme.bg_normal, font = "Droid Sans 10.5" },
    settings  = function()
        if tonumber(fs_now.used) < 90 then
            fsbar:set_color(theme.fg_focus)
            fsicon:set_markup('<span foreground="' .. theme.fg_focus .. '"font="' .. font.vol .. '">⛁</span>')
            widget.color = theme.fg_focus
        else
            fsbar:set_color(var.red)
            fsicon:set_markup('<span foreground="' .. var.red .. '" font="' .. font.fs .. '">⛁</span>')
            widget.color = var.red
        end
        fsbar:set_value(fs_now.used / 100)
    end
})

local fsbg = wibox.container.background(fsbar, "#474747", gears.shape.rectangle)

local fswidget = wibox.container.margin(fsbg, table.unpack(var.bar_size))
widget.fswidget = wibox.container.background(fswidget, theme.bg_normal, gears.shape.rectangle)

--local fsicon =  wibox.widget {
--     markup = "<span foreground='" .. theme.fg_focus .. "' font='" .. font.fs .. "'>⛁</span>",
--     widget = wibox.widget.textbox
--}

local fsicon = wibox.container.margin(fsicon, 10, 7, 6, 4)
widget.fsicon = wibox.container.background(fsicon, theme.bg_normal, gears.shape.rectangle)

-- Launch disk usage analyzer when you click the fs widget
widget.fswidget.widget:connect_signal("button::press", function(_, _, _, button)
    -- Perform some action when the widget is clicked
    if button == 1 then
       awful.spawn("baobab")
    end
end)

local free_space_command = string.format("df -h | grep '%s$' | awk '{print $4}'", file_system)

awful.tooltip {
       objects = { widget.fswidget },
       timer_function = function()
           local free_space = command(free_space_command)
           return string.format("Free: %s on %s", free_space, file_system) 
       end
}

-- fs widget end
return widget
