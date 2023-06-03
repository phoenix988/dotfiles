--[[

     Powerline Awesome WM theme 2.0
     github.com/phoenix988

--]]

-- Imports libaries
local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")
local os      = { getenv = os.getenv, setlocale = os.setlocale }
local gpmdp   = require("widgets.gpmdp")
local mytasklist = require("widgets.mytasklist")
local awesome, client = awesome, client

-- Imports the colors to use
local chosen_theme  = "iceberg"
local theme         = require("themes/" .. chosen_theme .. "/color")

-- Command to run to check for updates
local update_command = "bash -c 'paru -Syy &> /dev/null && paru -Qu 2> /dev/null | wc -l'"

-- Command to check for kernel version
local kernel_command = "uname -r"

-- Sets some variables
local threshold    = 80
local tempfile_set = "/sys/class/thermal/thermal_zone0/hwmon4/temp1_input"
local markup       = lain.util.markup
local blue         = theme.fg_focus
local red          = "#F7768E"
local green        = "#9ECE6A"
local white        = theme.fg_normal
local icon         = {}

-- Sets the size of the progressbar here by modifying the numbers
local bar_size     = {2, 7, 7, 7}

-- Defines fonts used in the widgets
local font         = {}
font.first         = "Droid Sans 7"
font.seperator     = "FiraCode Nerd Font Mono 38"
font.seperator_alt = "Droid Sans 25"
font.linux_icon    = "Droid Sans 17"
font.fs            = "Droid Sans 14"
font.cpu           = "Droid Sans 12"
font.temp          = "Droid Sans 11"
font.bar           = "Droid Sans 9"
font.mem           = "Droid Sans 12"
font.update        = "JetBrains Mono Nerd 14"
font.taglist       = "Droid Sans 19"

theme.tasklist_font             = "JetBrains Mono Nerd 16"
theme.tasklist_plain_task_name  = true

-- Make the clock widget
local mytextclock = wibox.widget.textclock(markup(theme.bg_normal, "  %a") .. markup(theme.bg_alt, " %d ") .. markup(theme.bg_normal, "%b ") .. markup(theme.bg_alt, " %I:%M "))
mytextclock.font = "JetBrains Mono Nerd 14"
local mytextclock = wibox.container.margin(mytextclock, 1, 1, 3, 1)

-- Set the bg color of the clock widget
local mytextclock = wibox.container.background(mytextclock, theme.seperator_1, gears.shape.rectangle)

-- Calendar
   lain.widget.calendar({
       attach_to = { mytextclock },
       notification_preset = {
           font = "Droid Sans Mono 13",
           fg   = white,
           bg   = theme.bg_normal
   }})
-- Calendar end

-- Makes update widget
   updatewidget = awful.widget.watch(
       update_command,
       600,
       function(widget, stdout)
           updatewidget.markup = '<span foreground="' .. theme.bg_normal .. '" background="' .. theme.seperator_1 .. '" font="' .. font.update .. '">' .. stdout .. '</span>'
       end
   )

   -- Update icon
   updateicon =  wibox.widget {
       markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. font.update .. "'>⟳</span>",
       widget = wibox.widget.textbox
   }
   
   -- Setting some settings for the update widget
   local updatewidget = wibox.container.margin(updatewidget, 0, 0, 4, 1)
   local updatewidget = wibox.container.background(updatewidget, theme.seperator_1, gears.shape.rectangle)
   
   -- Setting some settings for the update icon widget
   local updateicon = wibox.container.margin(updateicon, 0, 0, 4, 1)
   local updateicon = wibox.container.background(updateicon, theme.seperator_1, gears.shape.rectangle)
-- Update widget end

-- Makes kernel version widget
   kernelwidget = awful.widget.watch(
       kernel_command,
       1,
       function(widget, stdout)
           kernelwidget.markup = '<span foreground="' .. theme.fg_icon .. '" background="' .. theme.bg_normal .. '" font="' .. font.update .. '">' .. stdout .. '</span>'
       end
   )
   
   -- Setting some settings for the update icon widget
   local kernelwidget = wibox.container.margin(kernelwidget, 0, 0, 4, 1)
   local kernelwidget = wibox.container.background(kernelwidget, theme.bg_normal, gears.shape.rectangle)
-- Kernel widget end


-- Menu system where you can launch applications using a menu
   local mylauncher = awful.widget.button({image = theme.awesome_icon})
   mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)
   
   local mylauncher = wibox.container.background(mylauncher, theme.bg_alt, gears.shape.rectangle)

-- Battery
   local baticon = wibox.widget.imagebox(theme.bat)
   local batbar = wibox.widget {
       forced_height    = 1,
       forced_width     = 143,
       color            = theme.fg_normal,
       background_color = theme.bg_normal,
       margins          = 1,
       paddings         = 1,
       ticks            = true,
       ticks_size       = 13,
       widget           = wibox.widget.progressbar,
   }
   local batupd = lain.widget.bat({
       settings = function()
           if bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end
   
           if bat_now.status == "Charging" then
               baticon:set_image(theme.ac)
               if bat_now.perc >= 98 then
                   batbar:set_color(green)
               elseif bat_now.perc > 50 then
                   batbar:set_color(theme.fg_normal)
               elseif bat_now.perc > 15 then
                   batbar:set_color(theme.fg_normal)
               else
                   batbar:set_color(red)
               end
           else
               if bat_now.perc >= 98 then
                   batbar:set_color(green)
               elseif bat_now.perc > 50 then
                   batbar:set_color(theme.fg_normal)
                   baticon:set_image(theme.bat)
               elseif bat_now.perc > 15 then
                   batbar:set_color(theme.fg_normal)
                   baticon:set_image(theme.bat_low)
               else
                   batbar:set_color(red)
                   baticon:set_image(theme.bat_no)
               end
           end
           batbar:set_value(bat_now.perc / 100)
       end
   })
   local batbg = wibox.container.background(batbar, "#474747", gears.shape.rectangle)
   local batwidget = wibox.container.margin(batbg, 2, 7, 4, 4)
-- bat widget end

---- / fs
   --local fsicon = wibox.widget.imagebox(theme.disk)
   local fsbar = wibox.widget {
       forced_height    = 1,
       forced_width     = 100,
       color            = theme.fg_focus,
       background_color = theme.bg_normal,
       margins          = 1,
       paddings         = 1,
       ticks            = true,
       ticks_size       = 13,
       widget           = wibox.widget.progressbar,
   }
   
   theme.fs = lain.widget.fs({
       partition = "/",
       options = "--exclude-type=tmpfs",
       notification_preset = { fg = theme.fg_focus, bg = theme.bg_normal, font = "Droid Sans 10.5" },
       settings  = function()
           if tonumber(fs_now.used) < 90 then
               fsbar:set_color(theme.fg_focus)
           else
               fsbar:set_color(red)
           end
           fsbar:set_value(fs_now.used / 100)
       end
   })
 
   local fsbg = wibox.container.background(fsbar, "#474747", gears.shape.rectangle)
   local fswidget = wibox.container.margin(fsbg, table.unpack(bar_size))
   
   local fswidget = wibox.container.background(fswidget, theme.bg_normal, gears.shape.rectangle)
   
   local fsicon =  wibox.widget {
        markup = "<span foreground='" .. theme.fg_focus .. "' font='" .. font.fs .. "'>⛁</span>",
        widget = wibox.widget.textbox
   }
   
   local fsicon = wibox.container.margin(fsicon, 10, 7, 6, 4)
   local fsicon = wibox.container.background(fsicon, theme.bg_normal, gears.shape.rectangle)
   
   -- Launch disk usage analyzer when you click the fs widget
   fswidget.widget:connect_signal("button::press", function()
       -- Perform some action when the widget is clicked
       awful.spawn("baobab")
   end)

    awful.tooltip {
           objects = { fswidget },
           timer_function = function()
               return fs_now.used  
           end
    }

-- fs widget end

-- ALSA volume bar
   local volicon = wibox.widget.imagebox(theme.vol)
   theme.volume = lain.widget.alsabar({
       width = 120, border_width = 0, ticks = true, ticks_size = 13,
       notification_preset = { font = theme.font },
       --togglechannel = "IEC958,3",
       settings = function()
           if volume_now.status == "off" then
               volicon:set_image(theme.vol_mute)
           elseif volume_now.level == 0 then
               volicon:set_image(theme.vol_no)
           elseif volume_now.level <= 50 then
               volicon:set_image(theme.vol_low)
           else
               volicon:set_image(theme.vol)
           end
       end,
       colors = {
           background   = theme.bg_normal,
           mute         = red,
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
   local volumewidget = wibox.container.margin(volumebg, table.unpack(bar_size))
   
   local volumewidget = wibox.container.background(volumewidget, theme.seperator_2 , gears.shape.rectangle)
   local volicon = wibox.container.margin(volicon, 2, 7, 2, 2)
   local volicon = wibox.container.background(volicon, theme.seperator_2 , gears.shape.rectangle)
-- volume widget end

-- Creates cpu widget
   --local cpuicon = wibox.widget.imagebox(theme.cpu)
   local cpuicon =  wibox.widget {
        markup = "<span foreground='" .. theme.fg_cpu .. "' font='" .. font.cpu .. "'></span>",
        widget = wibox.widget.textbox
        }
   
   local cpubar = wibox.widget {
       forced_height    = 1,
       forced_width     = 100,
       color            = theme.fg_cpu,
       background_color = theme.bg_normal,
       margins          = 1,
       paddings         = 1,
       ticks            = true,
       ticks_size       = 13,
       widget           = wibox.widget.progressbar,
   }
   
   
   theme.cpu = lain.widget.cpu({
       settings = function()
           --widget:set_markup(" CPU: " .. cpu_now.usage .. "% ")
           cpubar:set_value(cpu_now.usage / 100 )
       end
   })

   local  cpubg = wibox.container.background(cpubar, "#474747", gears.shape.rectangle)
   local cpuwidget = wibox.container.margin(cpubg, table.unpack(bar_size))
   
   -- makes the colour of the cpu widget
   local cpuwidget = wibox.container.background(cpuwidget, theme.seperator_2 , gears.shape.rectangle)
   
   local cpuicon = wibox.container.margin(cpuicon, 10, 7, 4, 4)
   local cpuicon = wibox.container.background(cpuicon, theme.seperator_2 , gears.shape.rectangle)

   -- Launch btop when you click the cpu widget
   cpuwidget.widget:connect_signal("button::press", function()
       -- Perform some action when the widget is clicked
       awful.spawn("kitty -e btop")
   end)

   awful.tooltip {
       objects = { cpuwidget },
       timer_function = function()
           return "Cpu: " .. cpu_now.usage .. "%" 
       end
   }

-- cpu widget end
   
-- Make temp widget  
   local tempbar = wibox.widget {
       forced_height    = 5,
       forced_width     = 60,
       color            = theme.fg_cpu,
       background_color = theme.bg_normal,
       margins          = 1,
       paddings         = 1,
       ticks            = true,
       ticks_size       = 13,
       widget           = wibox.widget.progressbar,
   }
   
   -- make the temp widget
   theme.temp = lain.widget.temp({
       tempfile = "/sys/class/thermal/thermal_zone0/hwmon4/temp1_input",
       settings = function()
           if coretemp_now >= threshold then
               tempbar:set_color(red)
               tempicon =  wibox.widget {
               markup = "<span foreground='" .. red .. "' font='" .. font.temp .. "'>🌡</span>",
               widget = wibox.widget.textbox}
           else
               tempbar:set_color(theme.fg_cpu)
                  tempicon =  wibox.widget {
                  markup = "<span foreground='" .. theme.fg_cpu .. "' font='" .. font.temp .. "'>🌡</span>",
                  widget = wibox.widget.textbox}
           end
           tempbar:set_value(coretemp_now / 100 )
       end
   })
   
   local temp_text_setting = wibox.widget {
       color            = theme.fg_cpu,
       background_color = theme.seperator_2 ,
       margins          = 1,
       paddings         = 1,
       ticks            = false,
       ticks_size       = 13,
       widget           = wibox.widget.textbox,
   }
   
   theme.temp_text = lain.widget.temp({
       tempfile = "/sys/class/thermal/thermal_zone0/hwmon4/temp1_input",
       settings = function()
           if coretemp_now >= threshold then
               temp_text_setting:set_markup("<b><span foreground='" .. red .. "'>" .. coretemp_now .. "°C</span></b>")
           else
               temp_text_setting:set_markup("<b><span foreground='" .. theme.fg_cpu .. "'>" .. coretemp_now .. "°C</span></b>")
           end
       end
   })
   
   local tempbg     = wibox.container.background(tempbar,"#474747" , gears.shape.rectangle)
   local tempwidget = wibox.container.margin(tempbg, table.unpack(bar_size))
   local tempwidget = wibox.container.background(tempwidget, theme.seperator_2 , gears.shape.rectangle)
   
   local temptextbg = wibox.container.background(temp_text_setting, theme.seperator_2 , gears.shape.rectangle)
   local temptext  = wibox.container.margin(temptextbg, 2, 7, 4, 4)
   local temptext  = wibox.container.background(temptext, theme.seperator_2 , gears.shape.rectangle)
   
   awful.tooltip {
       objects = { tempwidget },
       timer_function = function()
           return "Temperature: " .. coretemp_now .. "°C"
       end
   }
   
   -- makes the colour of the temp widget
   local tempicon = wibox.container.margin(tempicon, 8, 7, 6, 0)
   local tempicon = wibox.container.background(tempicon, theme.seperator_2 , gears.shape.rectangle)
-- Temp  widget End
   
  -- Makes the memory widget
   local memorybar = wibox.widget {
       forced_height    = 1,
       forced_width     = 100,
       color            = theme.fg_mem,
       background_color = theme.bg_normal,
       margins          = 1,
       paddings         = 1,
       ticks            = true,
       ticks_size       = 13,
       widget           = wibox.widget.progressbar,
   }

    local memorytext = wibox.widget.textbox()

    local memorymargin = wibox.widget {
         widget = wibox.container.margin,
         bottom = 10,
         top = 1000,
         left = 1000,
    }

    local memorystack = wibox.widget {
        memorybar,
        memorytext,
        layout = wibox.layout.stack
    }
   
   theme.mem = lain.widget.mem({
     settings = function()
           memorybar:set_value(mem_now.used / mem_now.total )
           --memorytext:set_markup("<span foreground='" .. theme.fg_alt .. "' font='" .. font.bar .. "'> Free: " .. mem_now.used .. " MB</span>")
       end
   })
   
   local memorybg = wibox.container.background(memorystack, "#474747", gears.shape.rectangle)
   local memorywidget = wibox.container.margin(memorybg, table.unpack(bar_size))

   local memorywidget = wibox.container.background(memorywidget, theme.bg_normal, gears.shape.rectangle)
   
   -- Makes memory icon
   local memicon =  wibox.widget {
        markup = "<span foreground='" .. theme.fg_mem .. "' font='" .. font.mem .. "'>🖬</span>",
        widget = wibox.widget.textbox
   }
   
   local memicon = wibox.container.margin(memicon, 10, 7, 7, 4)
   local memicon = wibox.container.background(memicon, theme.bg_normal, gears.shape.rectangle)

   awful.tooltip {
       objects = { memorywidget },
       timer_function = function()
           return mem_now.used .. " / " .. mem_now.total .. " MB" 
       end
   }
-- Memory widget end

-- Weather widget
   local weather_widget = lain.widget.weather({
       city_id = 598316,
       units = "metric",  -- Use "imperial" for Fahrenheit
       settings = function()
           -- Format the weather widget text
           widget:set_text("Temp: " .. weather_now["main"]["temp"] .. "°C | " .. weather_now["weather"][1]["description"])
       end
   })
-- Weather widget end

-- Linux icon
   local linuxicon =  wibox.widget {
            markup = "<span foreground='" .. theme.fg_icon .. "' font='" .. font.linux_icon .. "'></span>",
            widget = wibox.widget.textbox
   }

   local linuxicon = wibox.container.background(linuxicon, theme.bg_normal, gears.shape.rectangle)

-- Separators

   local seperator = {}
   seperator.first     = wibox.widget.textbox(markup.font("Droid Sans 3", " "))
   seperator.spr       = wibox.widget.textbox(' ')
   seperator.spr_big   = wibox.widget.textbox(markup.font("Droid Sans 20", "         "))
   seperator.small_spr = wibox.widget.textbox(markup.font("Droid Sans 4", "  "))
   seperator.bar_spr   = wibox.widget.textbox(markup.font("Droid Sans 3", " ") .. markup.fontfg(theme.font, "#333333", "  |  ") .. markup.font("Droid Sans 5", " "))

   seperator.first_main =  wibox.widget {
                 markup = "<span background='" .. theme.bg_alt .. "' foreground='" .. theme.bg_alt .. "'  font='" .. font.first .. "'>|</span>",
                 widget = wibox.widget.textbox
   }
   
   seperator.first_main = wibox.container.background(seperator.first_main, theme.bg_alt, gears.shape.rectangle)
   
   seperator.first_sec =  wibox.widget {
                markup = "<span background='" .. theme.bg_normal .. "' foreground='" .. theme.bg_normal .. "'  font='" .. font.seperator_alt .. "'>|</span>",
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
   
   -- powerline seperators
   local powerline = {}
   powerline.sep_1 = wibox.widget {
            markup = "<span foreground='" .. theme.seperator_1 .. "' background='" .. theme.bg_normal .. "'  font='" .. font.seperator .. "'></span>",
            widget = wibox.widget.textbox,
   }
   
   powerline.sep_2 = wibox.widget {
            markup = "<span foreground='" .. theme.bg_normal .. "' background='" .. theme.seperator_1 .. "' font='" .. font.seperator .. "'></span>",
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
-- Seperator end

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

    -- Tag names and layouts
    -- awful.tag(awful.util.tagnames, s, awful.layout.layouts)
    
    -- Example of icons you can use
    -- local names = ["", "", "", "", "", "", "", "", "ﭮ", "", "", "﨣", "F1", "F2", "F3", "F4", "F5"]
    -- local names = { " ", " ", " ", " ", " ", " ", " ", " ", " "  }
    -- Set workspace names
    local names = { "  ", " ", "  ", "  ", "  ", "  ", "  ", " ", "  " }
    local l = awful.layout.suit
    local layouts = { l.max, l.tile.right, l.tile.right, l.max, l.tile.right, l.tile.right, l.tile.right, l.floating, l.floating, }
    awful.tag(names, s, layouts)

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
          spacing  = 0,
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

    -- Create tasklist with icons
    --s.mytasklist = awful.widget.tasklist {
    --   screen   = s,
    --   filter   = awful.widget.tasklist.filter.currenttags,
    --   buttons  = awful.util.tasklist_buttons,
    --   style    = {
    --      shape_border_width = 1,
    --      shape_border_color = theme.bg_normal,
    --      shape              = gears.shape.rounded_bar,
    --      bg_focus           = theme.taglist_fg_focus,
    --      bg_normal          = theme.bg_alt,
    --      spacing            = 10,
    --   },
    --   layout   = {
    --       spacing_widget = {
    --           {
    --               forced_width  = 5,
    --               forced_height = 30,
    --               thickness     = 1,
    --               shape         = gears.shape.circle,
    --               color         = theme.bg_normal,
    --               margin        = 20,
    --               widget        = wibox.widget.separator,
    --           },
    --           valign = 'center',
    --           halign = 'center',
    --           widget = wibox.container.place,
    --       },
    --       spacing = 20,
    --       layout  = wibox.layout.fixed.horizontal
    --   },
    --   -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    --   -- not a widget instance.
    --   widget_template = {
    --       {
    --           wibox.widget.base.make_widget(),
    --           forced_height = 5,
    --           id            = 'background_role',
    --           widget        = wibox.container.background,
    --       },
    --       {
    --           {
    --               id            = 'clienticon',
    --               widget        = awful.widget.clienticon,
    --               forced_width  = 25,
    --           },
    --           margins = 2,
    --           widget  = wibox.container.margin
    --       },
    --       nil,
    --       create_callback = function(self, c, index, objects) --luacheck: no unused args
    --           self:get_children_by_id('clienticon')[1].client = c
    --       end,
    --       layout = wibox.layout.align.vertical,
    --   },
    --}

    
    -- Makes systray widget
    local systraywidget = wibox.widget.systray()
    systraywidget:set_base_size(28)

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
            {linuxicon,
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
            {memicon,
             bottom = 2,
             color  = theme.fg_mem,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {memorywidget,
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
            {cpuicon,
             bottom = 2,
             color  = theme.fg_cpu,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {cpuwidget,
             bottom = 2,
             color  = theme.fg_cpu,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {tempicon,
             bottom = 2,
             color  = theme.fg_cpu,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {tempwidget,
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
            {fsicon,
             bottom = 2,
             color  = theme.fg_focus,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {fswidget,
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
            {volicon,
             bottom = 2,
             color  = theme.fg_alt,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            {
            {volumewidget,
             bottom = 2,
             color  = theme.fg_alt,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            powerline.sep_3,
            seperator.col_bg,
            seperator.first_sec,
            {
            {wibox.widget.systray(),
             bottom = 4,
             top    = 4,
             color  = theme.bg_normal,
             widget = wibox.container.margin,
            },
             left  = 0,
             right = 0,
             layout = wibox.container.margin,
            },
            seperator.first_sec,
        },
    }

end

return theme
