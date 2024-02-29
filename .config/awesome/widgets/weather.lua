local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local var = require("themes.default.variables")

local chosen_theme = require("activate_theme")
local theme = require("themes/" .. chosen_theme.chosen_theme .. "/color")

local font = require("themes.default.font")

local markup = lain.util.markup

local M = {}

-- Weather widget
M.widget = lain.widget.weather({
    city_id = 598316,
    units = "metric", -- Use "imperial" for Fahrenheit
    settings = function()
        -- Format the weather widget text
        local text = weather_now["main"]["temp"] .. "°C "
        widget.markup = '<span foreground="'
            .. theme.fg_focus
            .. '" background="'
            .. theme.bg_normal
            .. '" font="'
            .. font.update
            .. '">'
            .. text
            .. "</span>"
    end,
})

-- Weather widget
M.widget_2 = lain.widget.weather({
    city_id = 598316,
    units = "metric", -- Use "imperial" for Fahrenheit
    settings = function()
        -- Format the weather widget text
        local text = weather_now["main"]["temp"] .. "°C "
        widget.markup = '<span foreground="'
            .. theme.fg_icon
            .. '" background="'
            .. theme.seperator_2
            .. '" font="'
            .. font.update
            .. '">'
            .. text
            .. "</span>"
    end,
})

-- Weather icon
M.icon = wibox.widget({
    markup = "<span foreground='" .. theme.fg_focus .. "' font='" .. font.weather .. "'>󰖐  </span>",
    widget = wibox.widget.textbox,
})

M.icon = wibox.container.margin(M.icon, 0, 0, 0, 0)
M.icon = wibox.container.background(M.icon, theme.bg_normal, gears.shape.rectangle)

return M
