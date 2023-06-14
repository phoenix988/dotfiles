local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")
local var     = require("themes.default.variables")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local font  = require("themes.default.font")

local markup       = lain.util.markup

local widget       = {}

-- Makes the memory widget
   local memorybar = wibox.widget {
       forced_height    = 1,
       forced_width     = var.bar_width,
       color            = theme.fg_mem,
       background_color = theme.bg_normal,
       margins          = 1,
       paddings         = 1,
       ticks            = true,
       ticks_size       = 13,
       widget           = wibox.widget.progressbar,
   }

    local memorytext = wibox.widget.textbox()

    local memorymargin = wibox.widget {
         widget = wibox.container.margin,
         bottom = 10,
         top = 1000,
         left = 1000,
    }

    local memorystack = wibox.widget {
        memorybar,
        memorytext,
        layout = wibox.layout.stack
    }
   
   theme.mem = lain.widget.mem({
     settings = function()
           memorybar:set_value(mem_now.used / mem_now.total )
           --memorytext:set_markup("<span foreground='" .. theme.fg_alt .. "' font='" .. font.bar .. "'> Free: " .. mem_now.used .. " MB</span>")
       end
   })
   
   local memorybg = wibox.container.background(memorystack, "#474747", gears.shape.rectangle)
   local memorywidget = wibox.container.margin(memorybg, table.unpack(var.bar_size))

   widget.memorywidget = wibox.container.background(memorywidget, theme.bg_normal, gears.shape.rectangle)
   
   -- Makes memory icon
   local memicon =  wibox.widget {
        markup = "<span foreground='" .. theme.fg_mem .. "' font='" .. font.mem .. "'>🖬</span>",
        widget = wibox.widget.textbox
   }
   
   local memicon = wibox.container.margin(memicon, 10, 7, 7, 4)
   widget.memicon = wibox.container.background(memicon, theme.bg_normal, gears.shape.rectangle)

   awful.tooltip {
       objects = { widget.memorywidget },
       timer_function = function()
           return mem_now.used .. " / " .. mem_now.total .. " MB" 
       end
   }
-- Memory widget end

return widget
