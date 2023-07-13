local wibox = require("wibox")
local awful = require("awful")
local lain  = require("lain")
local gears = require("gears")
local font  = require("themes.default.font")
local var   = require("themes.default.variables")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local markup       = lain.util.markup


local M = {}

-- Command to run to check for updates
M.update_command = var.update_command

-- Makes update widget
M.updatewidget = awful.widget.watch(
    M.update_command,
    600,
    function(widget, stdout)
        widget.markup = '<span foreground="' .. theme.bg_normal .. '" background="' .. theme.seperator_1 .. '" font="' .. font.update .. '">'  .. stdout .. '</span>'
    end
)

-- Update icon
M.updateicon =  wibox.widget {
    markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. font.update .. "'> </span>",
    widget = wibox.widget.textbox
}

-- Setting some settings for the update widget
M.updatewidget = wibox.container.margin(M.updatewidget, 0, 0, 4, 1)
M.widget = wibox.container.background(M.updatewidget, theme.seperator_1, gears.shape.rectangle)

-- Setting some settings for the update icon widget
M.updateicon = wibox.container.margin(M.updateicon, 0, 0, 4, 1)
M.icon = wibox.container.background(M.updateicon, theme.seperator_1, gears.shape.rectangle)

M.widget:connect_signal("button::press", function(_, _, _, button)
    -- Perform some action when the widget is clicked
    if button == 1 then
       -- sets the available layouts to switch between when you click the widget
       awful.spawn.with_shell(string.format("%s -e sudo pacman -Syyu", awful.util.terminal))
    end
end)

-- Update widget end

return M
