local io    = require("io")
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
local layout_command = var.layout_command

local se,us,az = "se","us","az"

-- function to switch to switch the layout
local function layout_switcher(...)
     local layouts = {}
     
     -- Makes the table
     for i, arg in ipairs({...}) do
         table.insert(layouts, arg)
         last = i
     end
     
	 local bash_command = "setxkbmap -query | grep layout | awk '{print $NF}'"
     local file = io.popen(bash_command)
     local output = file:read("*a")
	 local output = string.gsub(output, "%s", "")
     for key, value in pairs(layouts) do
         if value == output then
             choice = key
         end
     end
     
     if choice == nil then
          choice = 2
     end
     
     if choice == last then
        choice = 1
     else 
        choice = choice + 1
     end    
        
     local command = "setxkbmap " .. layouts[choice]

     return command
end

-- Makes keyboard layout widget
layoutwidget = awful.widget.watch(
    layout_command,
    0,
    function(widget, stdout)
        local stdout = string.gsub(stdout, "%s", "")
        layoutwidget.markup = '<span foreground="' .. theme.bg_normal .. '" background="' .. theme.seperator_1 .. '" font="' .. font.update .. '">'  .. stdout .. '</span>'
    end
)

layouticon =  wibox.widget {
    markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. font.update .. "'>  </span>",
    widget = wibox.widget.textbox
}

-- Setting some settings for the update icon widget
local layoutwidget = wibox.container.margin(layoutwidget, 0, 0, 4, 1)
layoutwidget = wibox.container.background(layoutwidget, theme.seperator_1, gears.shape.rectangle)

local layouticon = wibox.container.margin(layouticon, 0, 0, 4, 1)
layouticon = wibox.container.background(layouticon, theme.seperator_1, gears.shape.rectangle)

-- Sets click action when you click the widget   
layoutwidget:connect_signal("button::press", function(_, _, _, button)
    -- Perform some action when the widget is clicked
    if button == 1 then
       -- sets the available layouts to switch between when you click the widget
       local switch = layout_switcher(se, us, az)
       awful.spawn("bash -c '" .. switch .. "'")
    end
end)


-- Returns the widgets and function
return {layoutwidget = layoutwidget, 
        layout_switcher = layout_switcher, 
        layouticon = layouticon}

