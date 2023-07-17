local wibox = require("wibox")
local lain  = require("lain")
local gears = require("gears")
local font  = require("themes.default.font")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local markup       = lain.util.markup

-- Separators
   local seperator = {}
  
  -- Linux icon
   seperator.linuxicon =  wibox.widget {
            markup = "<span foreground='" .. theme.fg_icon .. "' font='" .. font.linux_icon .. "'></span>",
            widget = wibox.widget.textbox
   }

   seperator.linuxicon_alt = wibox.container.background(seperator.linuxicon, theme.bg_normal, gears.shape.rectangle)
   seperator.linuxicon = wibox.container.background(seperator.linuxicon, theme.seperator_2, gears.shape.rectangle)

   seperator.first     = wibox.widget.textbox(markup.font("Droid Sans 3", " "))
   seperator.spr       = wibox.widget.textbox(' ')
   seperator.spr_big   = wibox.widget.textbox(markup.font("Droid Sans 20", "         "))
   seperator.bar_spr   = wibox.widget.textbox(markup.font("Droid Sans 3", " ") .. markup.fontfg(theme.font, "#333333", "  |  ") .. markup.font("Droid Sans 5", " "))

   seperator.small_spr =  wibox.widget {
                 markup = "<span background='" .. theme.seperator_2 .. "' foreground='" .. theme.seperator_2 .. "'  font='" .. font.first .. "'>|</span>",
                 widget = wibox.widget.textbox
   }

   seperator.small_spr = wibox.container.background(seperator.small_spr, theme.seperator_2, gears.shape.rectangle)

   seperator.first_main =  wibox.widget {
                 markup = "<span background='" .. theme.bg_alt .. "' foreground='" .. theme.bg_alt .. "'  font='" .. font.first .. "'>|</span>",
                 widget = wibox.widget.textbox
   }
   
   seperator.first_main = wibox.container.background(seperator.first_main, theme.bg_alt, gears.shape.rectangle)
   
   seperator.first_sec =  wibox.widget {
                markup = "<span background='" .. theme.bg_normal .. "' foreground='" .. theme.bg_normal .. "'  font='" .. font.seperator_alt .. "'>|</span>",
                widget = wibox.widget.textbox
   }

   seperator.first_third =  wibox.widget {
                markup = "<span background='" .. theme.seperator_2 .. "' foreground='" .. theme.bg_normal .. "'  font='" .. font.seperator_alt .. "'>|</span>",
                widget = wibox.widget.textbox
                }
   
   seperator.clock_sep = wibox.widget {
                markup = "<span foreground='" .. theme.seperator_1 .. "' background='" .. theme.seperator_1 .. "' font='" .. font.seperator .. "'> </span>",
                widget = wibox.widget.textbox,
   }

   seperator.col_bg =  wibox.widget {
             markup = "<span background='" .. theme.bg_normal .. "' font='" .. font.seperator_alt .. "'> </span>",
             widget = wibox.widget.textbox
   }
-- Seperator end

return seperator
