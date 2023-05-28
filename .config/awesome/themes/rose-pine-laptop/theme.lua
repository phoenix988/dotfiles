--[[

     Copland Awesome WM theme 2.0
     github.com/copycat-killer

--]]

local gears   = require("gears")
local lain    = require("lain")
local awful   = require("awful")
local wibox   = require("wibox")
local os      = { getenv = os.getenv, setlocale = os.setlocale }
local awesome, client = awesome, client
local gpmdp   = require("widgets.gpmdp")


update_command = "bash -c 'apt list --upgradable 2>/dev/null | wc -l'"

local threshold = 80
local markup = lain.util.markup
local blue   = theme.fg_focus
local red    = "#EB8F8F"
local green  = "#31748f"
local white	 = theme.fg_normal

-- Make the clock widget
local mytextclock = wibox.widget.textclock(markup(theme.bg_normal, "  %a") .. markup(theme.bg_alt, " %d ") .. markup(theme.bg_normal, "%b ") .. markup(theme.bg_alt, " %I:%M "))
mytextclock.font = "JetBrains Mono Nerd 12"
local mytextclock = wibox.container.margin(mytextclock, 1, 1, 3, 1)

-- Set the bg color of the clock widget
local mytextclock = wibox.container.background(mytextclock, theme.seperator_1, gears.shape.rectangle)

local updatefont = "JetBrains Mono Nerd 12"

-- Makes update widget
update_widget = awful.widget.watch(
    update_command,
    600,
    function(widget, stdout)
        update_widget.markup = '<span foreground="' .. theme.bg_normal .. '" background="' .. theme.seperator_1 .. '" font="' .. updatefont .. '">' .. stdout .. '</span>'
    end
)


local updateicon =  wibox.widget {
     markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. updatefont .. "'>⟳</span>",
     widget = wibox.widget.textbox
}

local update_widget = wibox.container.margin(update_widget, 0, 0, 4, 1)
local updateicon = wibox.container.margin(updateicon, 0, 0, 4, 1)
local updateicon = wibox.container.background(updateicon, theme.seperator_1, gears.shape.rectangle)
local update_widget = wibox.container.background(update_widget, theme.seperator_1, gears.shape.rectangle)


-- Calendar
lain.widget.calendar({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Droid Sans Mono 13",
        fg   = white,
        bg   = theme.bg_normal
}})

-- Launcher
local mylauncher = awful.widget.button({image = theme.awesome_icon})
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

local mylauncher = wibox.container.background(mylauncher, theme.bg_alt, gears.shape.rectangle)
--[[ Mail IMAP check
-- commented because it needs to be set before use
local mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "<span font='Droid Sans 5'> </span>Mail "
            count = mailcount .. " "
        end

        widget:set_markup(markup(blue, mail) .. count)
    end
})
--]]

-- MPD
local mpdicon = wibox.widget.imagebox()
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            title = mpd_now.title
            artist  = " " .. mpd_now.artist  .. markup("#333333", " <span font='Droid Sans 2'> </span>|<span font='Droid Sans 5'> </span>")
            mpdicon:set_image(theme.play)
        elseif mpd_now.state == "pause" then
            title = "mpd "
            artist  = "paused" .. markup("#333333", " |<span font='Droid Sans 5'> </span>")
            mpdicon:set_image(theme.pause)
        else
            title  = ""
            artist = ""
            mpdicon._private.image = nil
            mpdicon:emit_signal("widget::redraw_needed")
            mpdicon:emit_signal("widget::layout_changed")
        end

        widget:set_markup(markup.font(theme.font, markup(blue, title) .. artist))
    end
})

-- MPD widget end

-- Battery
local baticon = wibox.widget.imagebox(theme.bat)
local batbar = wibox.widget {
    forced_height    = 1,
    forced_width     = 90,
    color            = theme.fg_focus,
    background_color = theme.bg_normal,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = 13,
    widget           = wibox.widget.progressbar,
}
local batupd = lain.widget.bat({
    battery = "BAT0", 
    settings = function()
        if bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

        if bat_now.status == "Charging" then
            if bat_now.perc >= 98 then
                baticon:set_image(theme.ac_full)
                batbar:set_color(green)
            elseif bat_now.perc > 50 then
                baticon:set_image(theme.ac)
                batbar:set_color(theme.fg_focus)
            elseif bat_now.perc > 15 then
                baticon:set_image(theme.ac)
                batbar:set_color(theme.fg_focus)
            else
                baticon:set_image(theme.ac_low)
                batbar:set_color(red)
            end
        else
            if bat_now.perc >= 98 then
                batbar:set_color(green)
                baticon:set_image(theme.bat_full)
            elseif bat_now.perc > 50 then
                batbar:set_color(theme.fg_focus)
                baticon:set_image(theme.bat)
            elseif bat_now.perc > 15 then
                batbar:set_color(theme.fg_focus)
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

local baticon = wibox.container.margin(baticon, 0,0, 3, 0)
-- bat widget end

---- / fs
--local fsicon = wibox.widget.imagebox(theme.disk)
local fsbar = wibox.widget {
    forced_height    = 1,
    forced_width     = 120,
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
--    partition = "/",
    options = "--exclude-type=tmpfs",
    notification_preset = { fg = theme.fg_focus, bg = theme.bg_normal, font = "Droid Sans 10.5" },
    settings  = function()
        if tonumber(fs_now.used) < 90 then
            fsbar:set_color(theme.fg_focus)
        else
            fsbar:set_color("#EB8F8F")
        end
        fsbar:set_value(fs_now.used / 100)
    end
})
local fsbg = wibox.container.background(fsbar, "#474747", gears.shape.rectangle)
local fswidget = wibox.container.margin(fsbg, 2, 7, 4, 4)

local fswidget = wibox.container.background(fswidget, theme.bg_normal, gears.shape.rectangle)

local fsfont = "Droid Sans 10"

local fsicon =  wibox.widget {
     markup = "<span foreground='" .. theme.fg_focus .. "' font='" .. fsfont .. "'>⛁</span>",
     widget = wibox.widget.textbox
}

local fsicon = wibox.container.margin(fsicon, 10, 7, 6, 4)
local fsicon = wibox.container.background(fsicon, theme.bg_normal, gears.shape.rectangle)

-- Launch disk usage analyzer when you click the fs widget
fswidget.widget:connect_signal("button::press", function()
    -- Perform some action when the widget is clicked
    awful.spawn("baobab")
end)
-- fs widget end

-- ALSA volume bar
local volicon = wibox.widget.imagebox(theme.vol)
theme.volume = lain.widget.alsabar({
    width = 90, border_width = 0, ticks = true, ticks_size = 13,
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
theme.volume.tooltip.wibox.fg = theme.fg_focus
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
local volumewidget = wibox.container.margin(volumebg, 2, 7, 4, 4)

local volumewidget = wibox.container.background(volumewidget, theme.seperator_2 , gears.shape.rectangle)
local volicon = wibox.container.background(volicon, theme.seperator_2 , gears.shape.rectangle)

-- volume icons
--"🕪"
--"🕩"
--"🕨"

-- volume widget end

-- Creates cpu widget
--local cpuicon = wibox.widget.imagebox(theme.cpu)

local cpufont = "Droid Sans 12"

local cpuicon =  wibox.widget {
     markup = "<span foreground='" .. theme.fg_cpu .. "' font='" .. cpufont .. "'></span>",
     widget = wibox.widget.textbox
}

local tempfont = "Droid Sans 7"



local cpubar = wibox.widget {
    forced_height    = 1,
    forced_width     = 80,
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


local tempbar = wibox.widget {
    forced_height    = 5,
    forced_width     = 45,
    color            = theme.fg_cpu,
    background_color = theme.bg_normal,
    margins          = 1,
    paddings         = 1,
    shape = gears.shape.rectangle, 
    bar_shape = gears.shape.rectangle,
    ticks            = false,
    ticks_size       = 13,
    widget           = wibox.widget.progressbar,
}

-- make the temp widget
theme.temp = lain.widget.temp({
    tempfile = "/sys/class/thermal/thermal_zone0/hwmon1/temp1_input",
    settings = function()
        if coretemp_now >= threshold then
            tempbar:set_color(red)
            tempicon =  wibox.widget {
            markup = "<span foreground='" .. red .. "' font='" .. tempfont .. "'>🌡</span>",
            widget = wibox.widget.textbox}
        else
            tempbar:set_color(theme.fg_cpu)
               tempicon =  wibox.widget {
               markup = "<span foreground='" .. theme.fg_cpu .. "' font='" .. tempfont .. "'>🌡</span>",
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


temp_text = lain.widget.temp({
    tempfile = "/sys/class/hwmon/hwmon3/temp1_input",
    settings = function()
        if coretemp_now >= threshold then
            temp_text_setting:set_markup("<b><span foreground='" .. red .. "'>" .. coretemp_now .. "°C</span></b>")
        else
            temp_text_setting:set_markup("<b><span foreground='" .. theme.fg_cpu .. "'>" .. coretemp_now .. "°C</span></b>")
        end
    end
})

local  tempbg = wibox.container.background(tempbar, theme.seperator_2 , gears.shape.rectangle)
local tempwidget = wibox.container.margin(tempbg, 2, 7, 4, 4)
local  tempwidget = wibox.container.background(tempwidget, theme.seperator_2 , gears.shape.rectangle)

local  temptextbg = wibox.container.background(temp_text_setting, theme.seperator_2 , gears.shape.rectangle)
local  temp_text = wibox.container.margin(temptextbg, 2, 7, 4, 4)
local  temp_text = wibox.container.background(temp_text, theme.seperator_2 , gears.shape.rectangle)

tempwidget.font = theme.font

awful.tooltip {
    objects = { tempwidget },
    timer_function = function()
        return "Temperature: " .. coretemp_now .. "°C"
    end
}


local  cpubg = wibox.container.background(cpubar, "#474747", gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpubg, 2, 7, 4, 4)

-- makes the colour of the cpu widget
local cpuwidget = wibox.container.background(cpuwidget, theme.seperator_2 , gears.shape.rectangle)

local cpuicon = wibox.container.margin(cpuicon, 0, 7, 4, 4)
local cpuicon = wibox.container.background(cpuicon, theme.seperator_2 , gears.shape.rectangle)

local tempicon = wibox.container.margin(tempicon, 8, 7, 4, 0)
local tempicon = wibox.container.background(tempicon, theme.seperator_2 , gears.shape.rectangle)

-- Launch btop when you click the cpu widget
cpuwidget.widget:connect_signal("button::press", function()
    -- Perform some action when the widget is clicked
    awful.spawn("kitty -e btop")
end)
-- cpu widget end

-- Makes the memory widget
local memorybar = wibox.widget {
    forced_height    = 1,
    forced_width     = 80,
    color            = theme.fg_mem,
    background_color = theme.bg_normal,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = 13,
    widget           = wibox.widget.progressbar,
}

-- Makes memory widget
theme.mem = lain.widget.mem({
  settings = function()
        --widget:set_markup( "MEM: " .. mem_now.used .. "MB ")
        memorybar:set_value(mem_now.used / mem_now.total )
    end
})

local memorybg = wibox.container.background(memorybar, "#474747", gears.shape.rectangle)
local memory_widget = wibox.container.margin(memorybg, 2, 7, 4, 4)

-- Sets the font of the memory widget
memory_widget.font = theme.font

local mem_font = "Droid Sans 10"

-- Makes memory icon
local mem_icon =  wibox.widget {
     markup = "<span foreground='" .. theme.fg_mem .. "' font='" .. mem_font .. "'>🖬</span>",
     widget = wibox.widget.textbox
}

local mem_icon = wibox.container.background(mem_icon, theme.bg_normal, gears.shape.rectangle)
local mem_icon = wibox.container.margin(mem_icon, 10, 7, 7, 4)

-- Memory widget end

local weather_widget = lain.widget.weather({
    city_id = 598316,
    units = "metric",  -- Use "imperial" for Fahrenheit
    settings = function()
        -- Format the weather widget text
        widget:set_text("Temp: " .. weather_now["main"]["temp"] .. "°C | " .. weather_now["weather"][1]["description"])
    end
})




-- Separators
local first     = wibox.widget.textbox(markup.font("Droid Sans 3", " "))
local spr       = wibox.widget.textbox(' ')
local spr_big       = wibox.widget.textbox('                        ')
local small_spr = wibox.widget.textbox(markup.font("Droid Sans 4", "  "))
local bar_spr   = wibox.widget.textbox(markup.font("Droid Sans 3", " ") .. markup.fontfg(theme.font, "#333333", "  |  ") .. markup.font("Droid Sans 5", " "))

local linux_icon_font = "Droid Sans 14"
local seperator_font = "FiraCode Nerd Font Mono 38"
local seperator_font_alt = "Droid Sans 25"



local linux_icon =  wibox.widget {
     markup = "<span foreground='" .. theme.fg_icon .. "' font='" .. linux_icon_font .. "'></span>",
     widget = wibox.widget.textbox
}

local linux_icon = wibox.container.background(linux_icon, theme.bg_normal, gears.shape.rectangle)

local col_bg =  wibox.widget {
     markup = "<span background='" .. theme.bg_normal .. "' font='" .. seperator_font_alt .. "'> </span>",
     widget = wibox.widget.textbox
}


-- powerline seperators
local seperator = wibox.widget {
     markup = "<span foreground='" .. theme.seperator_1 .. "' font='" .. seperator_font .. "'></span>",
     widget = wibox.widget.textbox,
}

local seperator_dif = wibox.widget {
     markup = "<span foreground='" .. theme.bg_normal .. "' background='" .. theme.seperator_1 .. "' font='" .. seperator_font .. "'></span>",
     widget = wibox.widget.textbox,
}


local seperator_col = wibox.widget {
     markup = "<span foreground='" .. theme.bg_normal .. "' background='" .. theme.seperator_2 .. "' font='" .. seperator_font .. "'></span>",
     widget = wibox.widget.textbox,
}

local seperator_col_dif = wibox.widget {
     markup = "<span foreground='" .. theme.seperator_2 .. "' background='" .. theme.bg_normal .. "' font='" .. seperator_font .. "'></span>",
     widget = wibox.widget.textbox,
}

local seperator_fs = wibox.widget {
     markup = "<span foreground='" .. theme.seperator_3 .. "' background='" .. theme.bg_normal .. "' font='" .. seperator_font .. "'></span>",
     widget = wibox.widget.textbox,
}

local seperator_fs_diff = wibox.widget {
     markup = "<span foreground='" .. theme.bg_normal .. "' background='" .. theme.seperator_3 .. "' font='" .. seperator_font .. "'></span>",
     widget = wibox.widget.textbox,
}

local seperator_black = wibox.widget {
     markup = "<span foreground='" .. theme.bg_normal .. "' font='" .. seperator_font .. "'></span>",
     widget = wibox.widget.textbox,
}

local right_powerline = wibox.widget {
     markup = "<span foreground='" .. theme.bg_alt .. "' background='" .. theme.bg_normal .. "' font='" .. seperator_font .. "'></span>",
     widget = wibox.widget.textbox,
}

local clock_sep = wibox.widget {
     markup = "<span foreground='" .. theme.seperator_1 .. "' background='" .. theme.seperator_1 .. "' font='" .. seperator_font .. "'> </span>",
     widget = wibox.widget.textbox,
}

local seperator = wibox.container.margin(seperator)
seperator:set_right(-1)

local seperator_col = wibox.container.margin(seperator_col)
seperator_col:set_right(-4)

local seperator_dif = wibox.container.margin(seperator_dif)
seperator_dif:set_left(0)

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
    --awful.tag(awful.util.tagnames, s, awful.layout.layouts)
	local names = { " ", " ", " ", " ", " ", " ", " ", " ", " " }
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

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    s.mytasklist = wibox.container.background(s.mytasklist, "#00000000")

    -- Create the horizontal wibox
    s.mywibox = awful.wibar({ position = "top", 
    screen = s, 
    height = 25, 
    border_width = 8, 
    bg = theme.bg_normal, 
    fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            mylauncher,
            right_powerline,
            layout = wibox.layout.fixed.horizontal,
            small_spr,
            small_spr,
            s.mylayoutbox,
            bar_spr,
            first,
            s.mytaglist,
            first,
            s.mypromptbox,
            spr_big,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spr_big,
            small_spr,
            seperator,
            mytextclock,
            clock_sep,
            updateicon,
            update_widget,
            clock_sep,
            seperator_dif,
            mem_icon,
            memory_widget,
            seperator_col_dif,
            cpuicon,
            cpuwidget,
            tempicon,
            tempwidget,
           -- temp_text,
            seperator_col,
            baticon,
            batwidget,
           -- fsicon,
           -- fswidget,
            seperator_col_dif,
            volicon,
            volumewidget,
            seperator_col,
            col_bg,
            col_bg,
            wibox.widget.systray(),
            col_bg,
            linux_icon,
            first,
        },
    }


end

return theme
