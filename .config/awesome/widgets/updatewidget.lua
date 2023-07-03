local wibox = require("wibox")
local awful = require("awful")
local lain  = require("lain")
local gears = require("gears")
local font  = require("themes.default.font")
local var   = require("themes.default.variables")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local markup       = lain.util.markup

-- Command to run to check for updates
local update_command = var.update_command

-- Makes update widget
   updatewidget = awful.widget.watch(
       update_command,
       600,
       function(widget, stdout)
           updatewidget.markup = '<span foreground="' .. theme.bg_normal .. '" background="' .. theme.seperator_1 .. '" font="' .. font.update .. '">'  .. stdout .. '</span>'
       end
   )

   -- Update icon
   updateicon =  wibox.widget {
       markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. font.update .. "'> </span>",
       widget = wibox.widget.textbox
   }
   
   -- Setting some settings for the update widget
   local updatewidget = wibox.container.margin(updatewidget, 0, 0, 4, 1)
   local updatewidget = wibox.container.background(updatewidget, theme.seperator_1, gears.shape.rectangle)
   
   -- Setting some settings for the update icon widget
   local updateicon = wibox.container.margin(updateicon, 0, 0, 4, 1)
   local updateicon = wibox.container.background(updateicon, theme.seperator_1, gears.shape.rectangle)
-- Update widget end

return {updatewidget = updatewidget,
        updateicon   = updateicon }
