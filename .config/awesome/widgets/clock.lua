local wibox = require("wibox")
local lain  = require("lain")
local gears = require("gears")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local markup       = lain.util.markup
local font         = require("themes.default.font")

-- Make the clock widget
local mytextclock = wibox.widget.textclock(markup(theme.bg_normal, " %a") .. markup(theme.bg_alt, " %d ") .. markup(theme.bg_normal, "%b ") .. markup(theme.bg_alt, " %I:%M "))
mytextclock.font = font.clock
local mytextclock = wibox.container.margin(mytextclock, 1, 1, 3, 1)
--
-- Set the bg color of the clock widget
local mytextclock = wibox.container.background(mytextclock, theme.seperator_1, gears.shape.rectangle)
--
-- Calendar
   lain.widget.calendar({
       attach_to = { mytextclock },
       notification_preset = {
           font = "Droid Sans Mono 13",
           fg   = theme.fg_alt,
           bg   = theme.bg_normal
   }})
-- Calendar end


return mytextclock


