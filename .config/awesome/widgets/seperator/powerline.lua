local wibox = require("wibox")
local lain  = require("lain")
local gears = require("gears")
local font  = require("themes.default.font")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local markup       = lain.util.markup


  -- powerline seperators
   local powerline = {}
   powerline.sep_1 = wibox.widget {
            markup = "<span foreground='" .. theme.seperator_1 .. "' background='" .. theme.bg_normal .. "'  font='" .. font.seperator .. "'></span>",
            widget = wibox.widget.textbox,
   }
   
   powerline.sep_2 = wibox.widget {
            markup = "<span foreground='" .. theme.seperator_2 .. "' background='" .. theme.seperator_1 .. "' font='" .. font.seperator .. "'></span>",
            widget = wibox.widget.textbox,
   }
   
   
   powerline.sep_3 = wibox.widget {
            markup = "<span foreground='" .. theme.bg_normal .. "' background='" .. theme.seperator_2 .. "' font='" .. font.seperator .. "'></span>",
            widget = wibox.widget.textbox,
   }
   
   powerline.sep_4 = wibox.widget {
            markup = "<span foreground='" .. theme.seperator_2 .. "' background='" .. theme.bg_normal .. "' font='" .. font.seperator .. "'></span>",
            widget = wibox.widget.textbox,
   }
   
   powerline.sep_right = wibox.widget {
                markup = "<span foreground='" .. theme.bg_alt .. "' background='" .. theme.bg_normal .. "' font='" .. font.seperator .. "'></span>",
                widget = wibox.widget.textbox,
   }

   powerline.sep_right_alt = wibox.widget {
                    markup = "<span foreground='" .. theme.bg_normal .. "' background='" .. theme.bg_alt .. "' font='" .. font.seperator .. "'></span>",
                    widget = wibox.widget.textbox,
   }

return powerline
