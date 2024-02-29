-- Widget to display kernel version
local wibox = require("wibox")
local awful = require("awful")
local lain = require("lain")
local gears = require("gears")
local font = require("themes.default.font")
local var = require("themes.default.variables")
local command = require("widgets.layout").command

-- Import theme
local chosen_theme = require("activate_theme")
local theme = require("themes/" .. chosen_theme.chosen_theme .. "/color")

-- Markup function
local markup = lain.util.markup

-- Command to check for kernel version
local kernel_command = var.kernel_command

-- Gets the current kernel version
local kernelwidget = command(kernel_command)

-- Create the text widget
local kernelwidget = wibox.widget({
    markup = "<span foreground='" .. theme.fg_icon .. "' font='" .. font.update .. "'>" .. kernelwidget .. "</span>",
    widget = wibox.widget.textbox,
})

-- Setting some settings for the update icon widget
local kernelwidget = wibox.container.margin(kernelwidget, 0, 0, 4, 1)
local kernelwidget = wibox.container.background(kernelwidget, theme.seperator_2, gears.shape.rectangle)

return kernelwidget
