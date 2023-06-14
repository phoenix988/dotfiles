local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")
local var     = require("themes.default.variables")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local font  = require("themes.default.font")

local markup       = lain.util.markup

local threshold    = 80

local widget = {}
-- Creates cpu widget
   --local cpuicon = wibox.widget.imagebox(theme.cpu)
   local cpuicon =  wibox.widget {
        markup = "<span foreground='" .. theme.fg_cpu .. "' font='" .. font.cpu .. "'></span>",
        widget = wibox.widget.textbox
        }
   
   local cpubar = wibox.widget {
       forced_height    = 1,
       forced_width     = var.bar_width,
       color            = theme.fg_cpu,
       background_color = theme.bg_normal,
       margins          = 1,
       paddings         = 1,
       ticks            = true,
       ticks_size       = 13,
       widget           = wibox.widget.progressbar,
   }
   
   
   theme.cpu = lain.widget.cpu({
       settings = function()
           --widget:set_markup(" CPU: " .. cpu_now.usage .. "% ")
           cpubar:set_value(cpu_now.usage / 100 )
       end
   })

   local cpubg = wibox.container.background(cpubar, "#474747", gears.shape.rectangle)
   local cpuwidget = wibox.container.margin(cpubg, table.unpack(var.bar_size))
   
   -- makes the colour of the cpu widget
   widget.cpuwidget = wibox.container.background(cpuwidget, theme.seperator_2 , gears.shape.rectangle)
   
   local cpuicon = wibox.container.margin(cpuicon, 10, 7, 4, 4)
   widget.cpuicon = wibox.container.background(cpuicon, theme.seperator_2 , gears.shape.rectangle)

   -- Launch btop when you click the cpu widget
   widget.cpuwidget.widget:connect_signal("button::press", function(_, _, _, button)
       -- Perform some action when the widget is clicked
       if button == 1 then
          awful.spawn("kitty -e btop")
       end
   end)

   awful.tooltip {
       objects = { widget.cpuwidget },
       timer_function = function()
           return "Cpu: " .. cpu_now.usage .. "%" 
       end
   }

-- cpu widget end

-- Make temp widget  
   local tempbar = wibox.widget {
       forced_height    = 5,
       forced_width     = var.bar_width_temp,
       color            = theme.fg_cpu,
       background_color = theme.bg_normal,
       margins          = 1,
       paddings         = 1,
       ticks            = true,
       ticks_size       = 13,
       widget           = wibox.widget.progressbar,
   }
   
   -- make the temp widget
   theme.temp = lain.widget.temp({
       tempfile = "/sys/class/thermal/thermal_zone0/hwmon4/temp1_input",
       settings = function()
           if coretemp_now >= threshold then
               tempbar:set_color(var.red)
               tempicon =  wibox.widget {
               markup = "<span foreground='" .. var.red .. "' font='" .. font.temp .. "'>🌡</span>",
               widget = wibox.widget.textbox}
           else
               tempbar:set_color(theme.fg_cpu)
                  tempicon =  wibox.widget {
                  markup = "<span foreground='" .. theme.fg_cpu .. "' font='" .. font.temp .. "'>🌡</span>",
                  widget = wibox.widget.textbox}
           end
           tempbar:set_value(coretemp_now / 100 )
       end
   })
   
   local temp_text_setting = wibox.widget {
       color            = theme.fg_cpu,
       background_color = theme.seperator_2 ,
       margins          = 1,
       paddings         = 1,
       ticks            = false,
       ticks_size       = 13,
       widget           = wibox.widget.textbox,
   }
   
   theme.temp_text = lain.widget.temp({
       tempfile = "/sys/class/thermal/thermal_zone0/hwmon4/temp1_input",
       settings = function()
           if coretemp_now >= threshold then
               temp_text_setting:set_markup("<b><span foreground='" .. var.red .. "'>" .. coretemp_now .. "°C</span></b>")
           else
               temp_text_setting:set_markup("<b><span foreground='" .. theme.fg_cpu .. "'>" .. coretemp_now .. "°C</span></b>")
           end
       end
   })
   
   local tempbg     = wibox.container.background(tempbar,"#474747" , gears.shape.rectangle)
   local tempwidget = wibox.container.margin(tempbg, table.unpack(var.bar_size))
   widget.tempwidget = wibox.container.background(tempwidget, theme.seperator_2 , gears.shape.rectangle)
   
   local temptextbg = wibox.container.background(temp_text_setting, theme.seperator_2 , gears.shape.rectangle)
   local temptext  = wibox.container.margin(temptextbg, 2, 7, 4, 4)
   widget.temptext  = wibox.container.background(temptext, theme.seperator_2 , gears.shape.rectangle)
   
   awful.tooltip {
       objects = { widget.tempwidget },
       timer_function = function()
           return "Temperature: " .. coretemp_now .. "°C"
       end
   }
   
   -- makes the colour of the temp widget
   local tempicon = wibox.container.margin(tempicon, 8, 7, 6, 0)
   widget.tempicon = wibox.container.background(tempicon, theme.seperator_2 , gears.shape.rectangle)
-- Temp  widget End
 

return widget 

