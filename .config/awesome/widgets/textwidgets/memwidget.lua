local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local font  = require("themes.default.font")

local markup       = lain.util.markup

text       = {}

text.memwidget = lain.widget.mem({
settings = function()
    widget:markup("Memory Usage: " .. mem_now.used .. "MB")
end
})
   
   --local memorybg = wibox.container.background(memorystack, "#474747", gears.shape.rectangle)
   --local memorywidget = wibox.container.margin(memorybg, table.unpack(var.bar_size))

   --widget.memorywidget = wibox.container.background(memorywidget, theme.bg_normal, gears.shape.rectangle)
   --
   ---- Makes memory icon
   --local memicon =  wibox.widget {
   --     markup = "<span foreground='" .. theme.fg_mem .. "' font='" .. font.mem .. "'>🖬</span>",
   --     widget = wibox.widget.textbox
   --}
   --
   --local memicon = wibox.container.margin(memicon, 10, 7, 7, 4)
   --widget.memicon = wibox.container.background(memicon, theme.bg_normal, gears.shape.rectangle)

   --awful.tooltip {
   --    objects = { widget.memorywidget },
   --    timer_function = function()
   --        return mem_now.used .. " / " .. mem_now.total .. " MB" 
   --    end
   --}
-- Memory widget end

