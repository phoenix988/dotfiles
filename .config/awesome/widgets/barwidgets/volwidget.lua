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
-- ALSA volume bar
   local volicon = wibox.widget.textbox()
   theme.volume = lain.widget.alsabar({
       width = var.bar_width_vol, border_width = 0, ticks = true, ticks_size = 13,
       notification_preset = { font = theme.font },
       --togglechannel = "IEC958,3",
       settings = function()
           if volume_now.status == "off" then
               volicon:set_markup('<span foreground="' .. var.red .. '" background="' .. theme.seperator_2 .. '" font="' .. font.vol .. '">󰝟 </span>')
           elseif volume_now.level == 0 then
               volicon:set_markup('<span foreground="' .. theme.fg_alt .. '" background="' .. theme.seperator_2 .. '" font="' .. font.vol .. '">󰕿 </span>')
           elseif volume_now.level <= 50 then
               volicon:set_markup('<span foreground="' .. theme.fg_alt .. '" background="' .. theme.seperator_2 .. '" font="' .. font.vol .. '">󰖀 </span>')
           else
               volicon:set_markup('<span foreground="' .. theme.fg_alt .. '" background="' .. theme.seperator_2 .. '" font="' .. font.vol .. '">󰕾 </span>')
           end
       end,
       colors = {
           background   = theme.bg_normal,
           mute         = var.red,
           unmute       = theme.fg_alt
       }
   })
   theme.volume.tooltip.wibox.fg = theme.bg_normal
   theme.volume.bar:buttons(awful.util.table.join (
             awful.button({}, 1, function()
               awful.spawn.with_shell(string.format("%s -e alsamixer", awful.util.terminal))
             end),
             awful.button({}, 2, function()
               awful.spawn(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
               theme.volume.update()
             end),
             awful.button({}, 3, function()
               awful.spawn(string.format("%s set %s toggle", theme.volume.cmd, theme.volume.togglechannel or theme.volume.channel))
               theme.volume.update()
             end),
             awful.button({}, 4, function()
               awful.spawn(string.format("%s set %s 2%%+", theme.volume.cmd, theme.volume.channel))
               theme.volume.update()
             end),
             awful.button({}, 5, function()
               awful.spawn(string.format("%s set %s 2%%-", theme.volume.cmd, theme.volume.channel))
               theme.volume.update()
             end)
   ))
   
   local volumebg = wibox.container.background(theme.volume.bar, "#474747", gears.shape.rectangle)
   local volumewidget = wibox.container.margin(volumebg, table.unpack(var.bar_size))
   
   widget.volumewidget = wibox.container.background(volumewidget, theme.seperator_2 , gears.shape.rectangle)
   local volicon = wibox.container.margin(volicon, 2, 2, 2, 2)
   widget.volicon = wibox.container.background(volicon, theme.seperator_2 , gears.shape.rectangle)
-- volume widget end

return widget
