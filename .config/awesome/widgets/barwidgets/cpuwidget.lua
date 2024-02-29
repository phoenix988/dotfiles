local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local var = require("themes.default.variables")
local command = require("widgets.layout").command

-- Import theme
local chosen_theme = require("activate_theme")
local theme = require("themes/" .. chosen_theme.chosen_theme .. "/color")

-- Import fonts
local font = require("themes.default.font")

local markup = lain.util.markup

-- Sets the threshold value
local threshold = 80
-- Sets the temp command to run
local temp_command = var.temp_command

-- Create empty table for the widgets
local widget = {}

-- Creates cpu widget
local cpuicon = wibox.widget({
    markup = "<span foreground='" .. theme.fg_cpu .. "' font='" .. font.cpu .. "'></span>",
    widget = wibox.widget.textbox,
})

-- Create bar for the cpu
local cpubar = wibox.widget({
    forced_height = 1,
    forced_width = var.bar_width,
    color = theme.fg_cpu,
    background_color = theme.bg_normal,
    margins = 1,
    paddings = 1,
    ticks = true,
    ticks_size = 13,
    widget = wibox.widget.progressbar,
})

-- Sets the value of the cpubar
theme.cpu = lain.widget.cpu({
    settings = function()
        --widget:set_markup(" CPU: " .. cpu_now.usage .. "% ")
        cpubar:set_value(cpu_now.usage / 100)
    end,
})

-- Sets background and margin of the cpu widget
local cpubg = wibox.container.background(cpubar, "#474747", gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpubg, table.unpack(var.bar_size))

-- Create the colour of the cpu widget
widget.cpuwidget = wibox.container.background(cpuwidget, theme.seperator_2, gears.shape.rectangle)

-- Sets bg and margin of the cpuicon
local cpuicon = wibox.container.margin(cpuicon, 10, 7, 4, 4)
widget.cpuicon = wibox.container.background(cpuicon, theme.seperator_2, gears.shape.rectangle)

-- Launch btop when you click the cpu widget
widget.cpuwidget.widget:connect_signal("button::press", function(_, _, _, button)
    -- Perform some action when the widget is clicked
    if button == 1 then
        awful.spawn(string.format("%s -e btop", awful.util.terminal))
    end
end)

-- Sets hover function
awful.tooltip({
    objects = { widget.cpuwidget },
    timer_function = function()
        return "Cpu: " .. cpu_now.usage .. "%"
    end,
})

-- cpu widget end

-- Make tempbar widget
local tempbar = wibox.widget({
    forced_height = 5,
    forced_width = var.bar_width_temp,
    color = theme.fg_cpu,
    background_color = theme.bg_normal,
    margins = 1,
    paddings = 1,
    ticks = true,
    ticks_size = 13,
    widget = wibox.widget.progressbar,
})

-- Create tempicon
local tempicon = wibox.widget.textbox()

-- Makes custom temp widget
widget.temp_custom = awful.widget.watch(
    temp_command,         -- runs the temp command
    1,                    -- timer
    function(widget, stdout) -- function to run
        -- Filtering the output
        local stdout = string.gsub(stdout, "Tctl:", "")
        local stdout = string.gsub(stdout, "%s", "")
        local stdout = string.gsub(stdout, "+", "")
        local temp_string = string.gsub(stdout, "°C", "")
        local temp = tonumber(temp_string) -- converts to a number
        -- Sets the widget markup
        widget.markup = '<span foreground="'
            .. theme.fg_cpu
            .. '" background="'
            .. theme.seperator_2
            .. '" font="'
            .. font.mem
            .. '">'
            .. stdout
            .. "</span>"

        -- sets color to red if reaches threshold
        if temp >= threshold then
            tempbar:set_color(var.red) -- sets color of tempbar and icon
            tempicon:set_markup("<span foreground='" .. var.red .. "' font='" .. font.temp .. "'>🌡</span>")
        else
            tempbar:set_color(theme.fg_cpu) -- sets color of tempbar and icon
            tempicon:set_markup("<span foreground='" .. theme.fg_cpu .. "' font='" .. font.temp .. "'>🌡</span>")
        end

        tempbar:set_value(temp / 100) -- sets the value of the tempbar
    end
)

-- Sets the size and background of the tempbar widget
widget.temp_custom = wibox.container.background(tempbar, "#474747", gears.shape.rectangle)
widget.temp_custom = wibox.container.margin(widget.temp_custom, table.unpack(var.bar_size))
widget.temp_custom = wibox.container.background(widget.temp_custom, theme.seperator_2, gears.shape.rectangle)

-- Launch btop when you click the temp widget
widget.temp_custom:connect_signal("button::press", function(_, _, _, button)
    -- Perform some action when the widget is clicked
    if button == 1 then -- function when you left click
        awful.spawn(string.format("%s -e btop", awful.util.terminal))
    end
end)

-- Sets hover function of the bar widget
awful.tooltip({
    objects = { widget.temp_custom },
    timer_function = function()
        local command = command("sensors | grep Tctl | awk '{print $NF}' | sed 's/+//g'")
        return "Temperature: " .. command -- Returns the temperature when you hover
    end,
})

-- Sets the background and margin of the temp icon
local tempicon = wibox.container.margin(tempicon, 8, 7, 6, 0)
widget.tempicon = wibox.container.background(tempicon, theme.seperator_2, gears.shape.rectangle)
-- Temp  widget End

-- Returns the widget
return widget
