local awful   = require("awful")
local gears   = require("gears")
local wibox   = require("wibox")

local update = {}

-- Define the constructor method
function update.widget_create(dist,theme,font)

    -- Command to run to check for updates
    if dist == "arch" then 
         update.command = "bash -c 'paru -Syy &> /dev/null && paru -Qu 2> /dev/null | wc -l'"
    elseif dist == "ubuntu" then
         update.command = "dpkg -l 2> /dev/null | wc -l"
    end
    
    -- Makes update widget
    update.widget = awful.widget.watch(
        update.command,
        600,
        function(widget, stdout)
            update.widget.markup = '<span foreground="' .. theme.bg_normal .. '" background="' .. theme.seperator_1 .. '" font="' .. font.update .. '">'  .. stdout .. '</span>'
        end
    )

   -- Update icon
   update.icon =  wibox.widget {
       markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. font.update .. "'>⟳</span>",
       widget = wibox.widget.textbox
   }

   -- Setting some settings for the update widget
   update.widget = wibox.container.margin(update.widget, 0, 0, 4, 1)
   update.widget = wibox.container.background(update.widget, theme.seperator_1, gears.shape.rectangle)
   
   -- Setting some settings for the update icon widget
   update.icon = wibox.container.margin(update.icon, 0, 0, 4, 1)
   update.icon = wibox.container.background(update.icon, theme.seperator_1, gears.shape.rectangle)

   return update

end

return update


