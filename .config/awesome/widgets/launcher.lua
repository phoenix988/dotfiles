local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

-- Menu system where you can launch applications using a menu
local mylauncher = awful.widget.button({image = theme.awesome_icon})
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

local mylauncher = wibox.container.background(mylauncher, theme.bg_alt, gears.shape.rectangle)

return mylauncher


