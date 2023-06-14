local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")
local var     = require("themes.default.variables")

local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local font  = require("themes.default.font")

local markup       = lain.util.markup

-- Weather widget
   weatherwidget = lain.widget.weather({
       city_id = 598316,
       units = "metric",  -- Use "imperial" for Fahrenheit
       settings = function()
           -- Format the weather widget text
           widget:set_text("Temp: " .. weather_now["main"]["temp"] .. "°C | " .. weather_now["weather"][1]["description"])
       end
   })
-- Weather widget end



