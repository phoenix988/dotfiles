-- Creating a widget to display the current layout
local io = require("io")
local wibox = require("wibox")
local awful = require("awful")
local lain = require("lain")
local gears = require("gears")
local font = require("themes.default.font")
local var = require("themes.default.variables")

-- Import theme
local chosen_theme = require("activate_theme")
local theme = require("themes/" .. chosen_theme.chosen_theme .. "/color")

-- Markup function
local markup = lain.util.markup

-- Command to check for kernel version
local layout_command = "setxkbmap -query | grep layout | awk '{print $NF}'"

-- layout uptions
local layouts = awful.util.layouts

-- function to switch to switch the layout
local function layout_switcher(layouts)
    local bash_command = "setxkbmap -query | grep layout | awk '{print $NF}'"
    local file = io.popen(bash_command)
    local output = file:read("*a")
    local output = string.gsub(output, "%s", "")
    for key, value in pairs(layouts) do
        if value == output then
            choice = key
        end
        last = key
    end

    if choice == nil then
        choice = 2
    end

    if choice == last then
        choice = 1
    else
        choice = choice + 1
    end

    local command = "setxkbmap " .. layouts[choice]

    return command, layouts[choice]
end

-- Function to catch the output of a command
-- Useful to create a text widget to display certain information
local function command(command)
    local bash_command = command
    local file = io.popen(bash_command)
    local output = file:read("*a")
    local output = string.gsub(output, "%s", "")

    return output
end

-- Create layout icon
local layouticon = wibox.widget({
    markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. font.update .. "'>  </span>",
    widget = wibox.widget.textbox,
})

-- Sets background of the icons
local layouticon = wibox.container.margin(layouticon, 0, 0, 4, 1)
local layouticon = wibox.container.background(layouticon, theme.seperator_1, gears.shape.rectangle)

-- Gets the current layout
local layoutwidget = command(layout_command)
local layoutwidget = wibox.widget({
    markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. font.update .. "'>" .. layoutwidget .. "</span>",
    widget = wibox.widget.textbox,
})

-- Function to change the text of the layoutwidget
local function changeText(layout)
    layoutwidget:set_markup(
        "<span foreground='" .. theme.bg_normal .. "' font='" .. font.update .. "'>" .. layout .. "</span>"
    )
end

-- Sets background and margin of the layoutwidget
local layoutwidget = wibox.container.margin(layoutwidget, 0, 0, 4, 1)
local layoutwidget = wibox.container.background(layoutwidget, theme.seperator_1, gears.shape.rectangle)

-- Sets click action when you click the widget
layoutwidget:connect_signal("button::press", function(_, _, _, button)
    -- Perform some action when the widget is clicked
    if button == 1 then
        -- sets the available layouts to switch between when you click the widget
        local switch, choice = layout_switcher(layouts)
        awful.spawn("bash -c '" .. switch .. "'")
        changeText(choice)
    end
end)

-- Create new table and insert the icon and widget
local N = {}
table.insert(N, layouticon)
table.insert(N, layoutwidget)

-- Gets more information if you hover over the widget
for key, value in pairs(N) do
    awful.tooltip({
        objects = { N[key] },
        timer_function = function()
            local text
            local layoutwidget = command(layout_command)
            return string.format("Activated: %s", layoutwidget)
        end,
    })
end

-- Returns the widgets and function
return {
    layoutwidget = layoutwidget,
    layout_switcher = layout_switcher,
    layouticon = layouticon,
    layout_update = changeText,
    command = command,
}
