-- Create your own update widget
-- package manager supported
-- paru, pacman, apt
local awful   = require("awful")
local gears   = require("gears")
local wibox   = require("wibox")
local var     = require("themes.default.variables")

local update = {}

-- Define the constructor method
function update:create(dist,theme,font)
      local M = {}
      
      -- Command to run to check for updates
      if dist == "arch" then 
           M.command = "bash -c 'pacman -Qu | wc -l'"
      elseif dist == "paru" then     
           M.command = "bash -c 'paru -Syy &> /dev/null && paru -Qu 2> /dev/null | wc -l'"
      elseif dist == "ubuntu" then
           M.command = "dpkg -l 2> /dev/null | wc -l"
      else      
           M.command = "bash -c 'pacman -Syy &> /dev/null && pacman -Qu 2> /dev/null | wc -l'"
      end
      
      -- Makes update widget
      M.widget = awful.widget.watch(
          M.command,
          0,
          function(widget, stdout)
              widget.markup = '<span foreground="' .. theme.bg_normal .. '" background="' .. theme.seperator_1 .. '" font="' .. font.update .. '">'  .. stdout .. '</span>'
          end
      )

      -- Update icon
      local icon =  wibox.widget {
          markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. font.update .. "'> </span>",
          widget = wibox.widget.textbox
      }

      -- Setting some settings for the update widget
      M.widget = wibox.container.margin(M.widget, 0, 0, 4, 1)
      M.widget = wibox.container.background(M.widget, theme.seperator_1, gears.shape.rectangle)
      
      -- Setting some settings for the update icon widget
      local icon = wibox.container.margin(icon, 0, 0, 4, 1)
      M.icon = wibox.container.background(icon, theme.seperator_1, gears.shape.rectangle)

      return M

end

return update


