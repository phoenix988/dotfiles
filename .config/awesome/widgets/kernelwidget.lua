local wibox = require("wibox")
local awful = require("awful")
local lain  = require("lain")
local gears = require("gears")
local font  = require("themes.default.font")
local var   = require("themes.default.variables")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local markup       = lain.util.markup

-- Command to check for kernel version
local kernel_command = var.kernel_command

-- Makes kernel version widget
local kernelwidget = awful.widget.watch(
    kernel_command,
    1,
    function(widget, stdout)
        widget.markup = '<span foreground="' .. theme.fg_icon .. '" background="' .. theme.bg_normal .. '" font="' .. font.update .. '">' .. stdout .. '</span>'
    end
)

-- Setting some settings for the update icon widget
local kernelwidget = wibox.container.margin(kernelwidget, 0, 0, 4, 1)
local kernelwidget = wibox.container.background(kernelwidget, theme.bg_normal, gears.shape.rectangle)

return kernelwidget
-- Kernel widget end


