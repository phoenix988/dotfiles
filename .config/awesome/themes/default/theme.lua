--[[

     Powerline Awesome WM theme 2.0
     github.com/phoenix988

--]]

-- Imports libaries
local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local os = { getenv = os.getenv, setlocale = os.setlocale }
local gpmdp = require("widgets.gpmdp")
local awesome, client = awesome, client

-- Imports the colors to use
local theme = require("activate_theme")
local theme = require("themes/" .. theme.chosen_theme .. "/color")

local chosen_widget = require("activate_theme")

-- Imports some widgets from init.lua
local init = require("widgets.init")

-- Imports my fonts
local font = require("themes.default.font")

-- Custom tasklist with class names as titles
local mytasklist = require("widgets.mytasklist")

-- imports variables
local var = require("themes.default.variables")
local markup = var.markup

-- Create update widget with icon
init.update = init.update:create("arch", theme, font)

-- Create layout widget
--init.layout = init.layoutWidget:create()

-- Sets some global variables
theme.tasklist_font = var.tasklist_font
theme.tasklist_plain_task_name = var.tasklist_plain_task_name

-- Eminent-like task filtering
local orig_filter = awful.widget.taglist.filter.all

-- Taglist label functions
awful.widget.taglist.filter.all = function(t, args)
    if t.selected or #t:clients() > 0 then
        return orig_filter(t, args)
    end
end

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    awful.tag(var.names, s, var.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))

    s.mylayoutbox = wibox.container.background(s.mylayoutbox, theme.bg_normal, gears.shape.rectangle)

    -- Create a taglist widget
    -- s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = awful.util.taglist_buttons,
        style = {
            font = font.taglist,
            spacing = 2,
        },
    })

    -- Create a tasklist widget
    --s.mytasklist = mytasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    --s.mytasklist = mytasklist {
    --    screen   = s,
    --    filter   = function(c, scr)
    --        return awful.widget.tasklist.filter.currenttags(c, scr) and c == client.focus
    --    end,
    --    buttons  = awful.util.tasklist_buttons,
    --    template = {
    --        -- Your template configuration here
    --    },
    --}

    -- Tasklist widget
    s.mytasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = awful.util.tasklist_buttons,
        style = {
            shape_border_width = 1,
            shape_border_color = theme.fg_normal,
            shape = gears.shape.rectangle,
        },
        layout = {
            spacing = 20,
            spacing_widget = {
                {
                    forced_width = 20,
                    forced_height = 20,
                    shape = gears.shape.ellipse,
                    widget = wibox.widget.separator,
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout = wibox.layout.flex.horizontal,
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            id = "icon_role",
                            widget = wibox.widget.imagebox,
                        },
                        margins = 10,
                        widget = wibox.container.margin,
                    },
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 10,
                right = 10,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    })
    -- Makes systray widget
    s.systray = wibox.widget.systray()
    s.systray:set_base_size(29)

    -- Create the horizontal wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = 35,
        border_width = 10,
        bg = theme.bg_normal,
        fg = theme.fg_normal,
    })

    -- Creates the diffrent styles of wibars
    if chosen_widget.chosen_widget == "default" then
        local mywibar = require("widgets.wibar.wibox_default")
        if s.index == 1 then
            -- Add widgets to the wibox
            -- Create the wibar
            mywibar.create(s, wibox, init, theme)
        else
            mywibar.create_sec(s, wibox, init, theme)
        end
    elseif chosen_widget.chosen_widget == "laptop" then
        -- Create wibar thats made for laptops in mind
        local mywibar = require("widgets.wibar.wibox_laptop")

        -- Create the wibar made for laptops or smaller res screens
        if s.index == 1 then
            -- Add widgets to the wibox
            -- Create the wibar
            mywibar.create(s, wibox, init, theme)
        else
            mywibar.create_sec(s, wibox, init, theme)
        end
    end
end

return theme
