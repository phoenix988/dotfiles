--[[

     Powerline Awesome WM theme 2.0
     github.com/phoenix988

--]]

-- Imports libaries
local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")
local dpi     = require('beautiful').xresources.apply_dpi
local os      = { getenv = os.getenv, setlocale = os.setlocale }
local gpmdp   = require("widgets.gpmdp")
local awesome, client = awesome, client

-- Imports the colors to use
local theme         = require("activate_theme")
local theme         = require("themes/" .. theme.chosen_theme .. "/color")

-- Imports some widgets from init.lua
local init        = require("widgets.init")

-- Imports my fonts
local font        = require("themes.default.font")

-- Custom tasklist with class names as titles
local mytasklist  = require("widgets.mytasklist")

local mytextclock = init.clock

-- Imports fs widget
local fs          = init.fs

-- Imports cpu widget
local cpu         = init.cpu

-- Imports volume widget
local vol         = init.vol

-- Imports Memory widget
local mem         = init.mem

-- Imports seperators
local powerline   = init.pow
local seperator   = init.sep

-- Import batwidget
local bat         = init.bat

-- App launcher
local mylauncher  = init.launcher


-- Imports update widget
local updatewidget = init.updatewidget
local updateicon   = init.updateicon

-- imports variables
local var     = require("themes.default.variables")
local markup  = var.markup

-- Sets some global variables
theme.tasklist_font             = var.tasklist_font
theme.tasklist_plain_task_name  = var.tasklist_plain_task_name
  
   -- Eminent-like task filtering
   local orig_filter = awful.widget.taglist.filter.all
   
   -- Taglist label functions
   awful.widget.taglist.filter.all = function (t, args)
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
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    s.mylayoutbox = wibox.container.background(s.mylayoutbox, theme.bg_normal, gears.shape.rectangle)


    -- Create a taglist widget
    -- s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)
    s.mytaglist = awful.widget.taglist {
       screen    = s,
       filter    = awful.widget.taglist.filter.all,
       buttons   = awful.util.taglist_buttons,
       style     = {
          font     = font.taglist,      
          spacing  = 2,
       },
    }

    -- Create a tasklist widget
    --s.mytasklist = mytasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    s.mytasklist = mytasklist {
        screen   = s,
        filter   = function(c, scr)
            return awful.widget.tasklist.filter.currenttags(c, scr) and c == client.focus
        end,
        buttons  = awful.util.tasklist_buttons,
        template = {
            -- Your template configuration here
        },
    }
        
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

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            seperator.first_main,
            mylauncher,
            powerline.sep_right,
            layout = wibox.layout.fixed.horizontal,
            seperator.first_sec,
            s.mylayoutbox,
            seperator.first_sec,
            seperator.first,
            {
            {s.mytaglist,
             bottom = 2,
             color  = theme.fg_normal,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            s.mypromptbox,
            seperator.first_sec,
            seperator.first_sec,
        },
          -- Middle widget
            s.mytasklist,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            seperator.first_sec,
            seperator.first_sec,
            powerline.sep_1,
            mytextclock,
            seperator.clock_sep,
            updateicon,
            updatewidget,
            seperator.clock_sep,
            powerline.sep_2,
            seperator.first_sec,
            {
            {seperator.linuxicon,
             bottom = 2,
             color  = theme.fg_icon,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {seperator.small_spr,
             bottom = 2,
             color  = theme.fg_icon,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {kernelwidget,
             bottom = 2,
             color  = theme.fg_icon,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            seperator.first_sec,
            {
            {mem.memicon,
             bottom = 2,
             color  = theme.fg_mem,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {mem.memorywidget,
             bottom = 2,
             color  = theme.fg_mem,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            powerline.sep_4,
            {
            {cpu.cpuicon,
             bottom = 2,
             color  = theme.fg_cpu,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {cpu.cpuwidget,
             bottom = 2,
             color  = theme.fg_cpu,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {cpu.tempicon,
             bottom = 2,
             color  = theme.fg_cpu,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {cpu.tempwidget,
             bottom = 2,
             color  = theme.fg_cpu,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            powerline.sep_3,
            {
            {fs.fsicon,
             bottom = 2,
             color  = theme.fg_focus,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {fs.fswidget,
             bottom = 2,
             color  = theme.fg_focus,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            powerline.sep_4,
            {
            {vol.volicon,
             bottom = 2,
             color  = theme.fg_alt,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {vol.volumewidget,
             bottom = 2,
             color  = theme.fg_alt,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            powerline.sep_3,
            seperator.first_sec,
            {
            {wibox.widget.systray(),
             bottom = 4,
             top    = 6,
             color  = theme.bg_normal,
             widget = wibox.container.margin,
            },
             left  = 3,
             right = -2,
             layout = wibox.container.margin,
            },
        },
    }

end

return theme
