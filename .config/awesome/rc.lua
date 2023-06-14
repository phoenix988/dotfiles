    
--[[

     Awesome WM configuration template
     github.com/copycat-killer

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local gpmdp	    = require("widgets.gpmdp")

local theme         = require("activate_theme")

-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated
-- }}}

-- {{{ Variable definitions
-- Choose your theme of widgets here
local chosen_theme = theme.chosen_widget
local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "kitty"
local terminal_alt = "kitty -e tmux attach"
local editor       = os.getenv("EDITOR") or "nvim"
local home         = os.getenv("HOME")
local gui_editor   = "emacsclient -c -a emacs"
local browser      = "librewolf"
local guieditor    = "emacsclient -c -a emacs"

awful.util.terminal = terminal

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,	--9
    awful.layout.suit.max,		--11
    awful.layout.suit.floating,		--1
    awful.layout.suit.tile,
--    lain.layout.cascade,
--    lain.layout.cascade.tile,
--    awful.layout.suit.max.fullscreen,
}

awful.util.taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )
awful.util.tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function()
                         local instance = nil

                         return function ()
                             if instance and instance.wibox.visible then
                                 instance:hide()
                                 instance = nil
                             else
                                 instance = awful.menu.clients({ theme = { width = 250 } })
                             end
                        end
                     end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
-- }}}

-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})
--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
--    awful.key({ altkey }, "p", function() os.execute("screenshot") end),

	-- User Hotkeys
	awful.key({ modkey, "Shift" }, "Return", function () awful.util.spawn( "pcmanfm" ) end,
        {description="run pcmanfm", group="Applications"}),
	awful.key({ modkey, "Shift" }, "e", function () awful.util.spawn(  "emacsclient -c -a '' --eval '(dired nil)'" ) end,
        {description="run dired in emacs", group="Applications"}),
	awful.key({ modkey, "Shift" }, "w", function () awful.util.spawn( "librewolf" ) end,
        {description="run librewolf", group="Applications"}),
	awful.key({ modkey, "Shift" }, "d", function () awful.util.spawn( gui_editor ) end,
        {description="run gui text editor", group="Applications"}),
	awful.key({ modkey }, "g", function () awful.util.spawn( "gimp" ) end,
        {description="run gimp", group="Applications"}),
	awful.key({ modkey, "Shift" }, "g", function () awful.util.spawn( "kdenlive" ) end,
        {description="run kdenlive", group="Applications"}),
	awful.key({ modkey, "Shift" }, "b", function () awful.util.spawn( browser ) end,
        {description="run browser", group="Applications"}),
	awful.key({ modkey }, "b", function () awful.util.spawn( "qutebrowser --backend webengine" ) end,
        {description="run qutebrowser", group="Applications"}),
	awful.key({ modkey, "Shift" }, "v", function () awful.util.spawn( "virt-manager" ) end,
        {description="run virt-manager", group="Applications"}),
	awful.key({ modkey,}, "i", function () awful.util.spawn( "lxappearance" ) end,
        {description="run lxappearance", group="Applications"}),
	awful.key({ altkey, "Control" }, "p", function () awful.util.spawn( "pavucontrol" ) end,
        {description="run pavucontrol", group="Applications"}),
	awful.key({ modkey, "Shift" }, "s", function () awful.util.spawn( "flameshot gui" ) end,
        {description="Take screenshot", group="Applications"}),
	awful.key({ modkey, "Shift" }, "y", function () awful.util.spawn( editor ) end,
        {description="Take screenshot", group="Applications"}),
	awful.key({ modkey, "Shift" }, "t", function () awful.util.spawn( "kitty -e btop" ) end,
        {description="Run btop", group="Applications"}),
	awful.key({ modkey, "Shift" }, "y", function () awful.util.spawn( "kitty -e neomutt" ) end,
        {description="Run Neomutt", group="Applications"}),
	awful.key({ modkey,}, "F9", function () awful.util.spawn("azla" ) end,
        {description="Run Azla", group="Applications"}),
	awful.key({ modkey, "Control" }, "k", function () awful.util.spawn( "rofi -show window" ) end,
        {description="Jump between windows using rofi", group="Client"}),



    -- Hotkeys
    awful.key({ modkey, }, "F1",      hotkeys_popup.show_help,
              {description="show awesome keybindings", group="awesome"}),
    awful.key({ modkey, }, "F2", function () awful.util.spawn(home .. "/.config/kitty/kitty-keys.sh") end,
              {description="show help for kitty", group="awesome"}),
    awful.key({ modkey, }, "F11", function () awful.util.spawn(home .. "/.scripts/restart/picom-control") end,
              {description="kill picom/start picom", group="awesome"}),
    awful.key({ modkey, }, "F12", function () awful.util.spawn(home .. "/.scripts/activated/set-random-bg") end,
              {description="set random wallpaper", group="awesome"}),
   
    -- Tag browsing
    awful.key({ modkey, }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey, }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
             {description = "go back", group = "tag"}),
       
    -- Tag browsing keyboard
    awful.key({ modkey, altkey, "Control" }, "h",   awful.tag.viewprev,
          {description = "view previous", group = "tag"}),
    awful.key({ modkey, altkey, "Control" }, "l",  awful.tag.viewnext,
          {description = "view next", group = "tag"}),

    -- Switch between workspaces on all monitors
    awful.key({ modkey, "Control"   }, ",", 
      function()
        for i = 1, screen.count() do
          awful.tag.viewprev(screen[i])
        end
      end ),
    
    awful.key({ modkey, "Control"   }, ".", 
      function()
        for i = 1, screen.count() do
          awful.tag.viewnext(screen[i])
        end
      end ),

    -- Default client focus
    awful.key({ modkey, }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey, }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- By direction client focus
    awful.key({ altkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, "Control" }, "w", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, }, "s", function () awful.client.movetoscreen() end,
              {description = "move client to the next screen", group = "screen"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, }, "e", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, }, "w", function () awful.screen.focus_relative(-1) end,	--Switch between monitors
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,  "Control"  }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Show/Hide Horizontal Wibox
    awful.key({ altkey, "Control" }, "t", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end),

    -- Standard program
    awful.key({ modkey, }, "Return", function () awful.spawn(terminal_alt) end,
              {description = "open a terminal with tmux", group = "launcher"}),
    awful.key({ modkey, }, "t", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ altkey, "Control"}, "l", function() awful.spawn("slock") end,
              {description = "lock the screen", group = "awesome"}),
-- awful.key({ modkey, "Shift"   }, "q", function () awful.util.spawn_with_shell("oblogout") end),

    awful.key({ modkey, "Control"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Control"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "Tab", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "Tab", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

-- tmux bindings
    awful.key({ altkey, }, "1", function () awful.spawn( home .. "/.scripts/tmux/window-1" ) end),
    awful.key({ altkey, }, "2", function () awful.spawn( home .. "/.scripts/tmux/window-2" ) end),
    awful.key({ altkey, }, "3", function () awful.spawn( home .. "/.scripts/tmux/window-3" ) end),
    awful.key({ altkey, }, "4", function () awful.spawn( home .. "/.scripts/tmux/window-4" ) end),
    awful.key({ altkey, }, "5", function () awful.spawn( home .. "/.scripts/tmux/window-5" ) end),
    awful.key({ altkey, }, "6", function () awful.spawn( home .. "/.scripts/tmux/window-6" ) end),
    awful.key({ altkey, }, "7", function () awful.spawn( home .. "/.scripts/tmux/window-7" ) end),
    awful.key({ altkey, }, "8", function () awful.spawn( home .. "/.scripts/tmux/window-8" ) end),
    awful.key({ altkey, }, "9", function () awful.spawn( home .. "/.scripts/tmux/window-9" ) end),
    

    
    awful.key({ altkey }, "e", function () awful.util.spawn(home .. "/.dmenu/dm-editconfig") end,
              {description = "run dm-editconfig", group = "dmenu"}),
    awful.key({ altkey }, "v", function () awful.util.spawn(home .. "/.dmenu/dm-vpn") end,
              {description = "run dm-vpn", group = "dmenu"}),
    awful.key({ altkey }, "o", function () awful.util.spawn(home .. "/.dmenu/dm-openweb") end,
              {description = "run dm-openweb", group = "dmenu"}),
    awful.key({ altkey }, "f", function () awful.util.spawn(home .. "/.dmenu/dm-openweb-fullscreen") end,
              {description = "run dm-openweb-fullscreen", group = "dmenu"}),
    awful.key({ altkey }, "a", function () awful.util.spawn(home .. "/.dmenu/dm-audioset") end,
              {description = "run dm-audioset", group = "dmenu"}),
    awful.key({ altkey }, "l", function () awful.util.spawn(home .. "/.dmenu/dm-input") end,
              {description = "run dm-input", group = "dmenu"}),
    awful.key({ altkey }, "k", function () awful.util.spawn(home .. "/.dmenu/dm-kill") end,
              {description = "run dm-kill", group = "dmenu"}),
    awful.key({ altkey }, "t", function () awful.util.spawn(home .. "/.dmenu/dm-kittychangetheme") end,
              {description = "run dm-kittychangetheme", group = "dmenu"}),
    awful.key({ altkey }, "w", function () awful.util.spawn(home .. "/.dmenu/dm-set-wallpaper") end,
              {description = "run dm-set-wallpaper", group = "dmenu"}),
    awful.key({ altkey }, "j", function () awful.util.spawn(home .. "/.dmenu/dm-pass") end,
              {description = "run dm-pass", group = "dmenu"}),
    awful.key({ altkey }, "q", function () awful.util.spawn(home .. "/.dmenu/dm-virt-manager") end,
              {description = "run dm-pass", group = "dmenu"}),
    awful.key({ altkey }, "p", function () awful.util.spawn(home .. "/.dmenu/dm-play-pause") end,
              {description = "run dm-play-pause", group = "dmenu"}),
    awful.key({ altkey }, "g", function () awful.util.spawn(home .. "/.dmenu/dm-theme") end,
              {description = "run dm-theme", group = "dmenu"}),
              
    -- switch layout
    awful.key({ modkey, }, "space", function () awful.spawn( home .. "/.scripts/activated/layout-switcher" ) end),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Dropdown application
    awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end),

    -- Widgets popups
    awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end),
    awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end),
    awful.key({ altkey, "Control" }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 10") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 10") end),

    -- ALSA volume control
    --awful.key({ altkey }, "Up",
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    --awful.key({ altkey }, "Down",
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ altkey, "Control" }, "0",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    
    -- Play/Pause/next
     awful.key({  }, "XF86AudioPlay", function () awful.util.spawn("/home/karl/.scripts/activated/mediaplay") end),
     awful.key({  }, "XF86AudioNext", function () awful.util.spawn("/home/karl/.scripts/activated/medianext") end),
     awful.key({  }, "XF86AudioPrev", function () awful.util.spawn("/home/karl/.scripts/activated/mediaprev") end),


    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.spawn.with_shell("mpc toggle")
            beautiful.mpd.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.spawn.with_shell("mpc stop")
            beautiful.mpd.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.spawn.with_shell("mpc prev")
            beautiful.mpd.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.spawn.with_shell("mpc next")
            beautiful.mpd.update()
        end),
    awful.key({ altkey }, "0",
        function ()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ altkey, "Shift" }, "c", function () awful.spawn("xsel | xsel -i -b") end),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ altkey, "Shift" }, "v", function () awful.spawn("xsel -b | xsel") end),

    -- User programs
--    awful.key({ modkey }, "q", function () awful.spawn(browser) end),
    awful.key({ modkey, "Shift" }, "a", function () awful.spawn(guieditor) end),

    -- Default
    -- Menubar
    awful.key({ modkey }, "a", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    
    -- dmenu
--    awful.key({ altkey }, "x", function ()
--        awful.spawn(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
--        beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus)),
--		end)
    
    -- Prompt
    awful.key({ modkey }, "r", function () awful.util.spawn("rofi -show drun -show-icons -display-drun '' -drun-display-format \'{name}\'") end,

              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
    --]]
)

clientkeys = awful.util.table.join(
    awful.key({ altkey, "Shift" }, "m",lain.util.magnify_client ),
    awful.key({ modkey, }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey, }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     ontop = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     --placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     placement = awful.placement.centered,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },
--      properties = { titlebars_enabled = true } },

    { rule = { class = "LibreWolf" },
     properties = {tag = "" } },

    { rule = { class = "Steam" },
     properties = {tag = "󰓓 " } },

    { rule = { class = "Gimp" },
          properties = { tag = " " } },

    { rule = { class = "kdenlive" },
          properties = { tag = " " } },

    { rule = { class = "youtube.com" },
        properties = { screen = 1, tag = "󰝚 " } },

    { rule = { class = "whatsapp-nativefier-d40211" },
        properties = { tag = "󰙯 " } },
    
    { rule = { class = "discord" },
        properties = { tag = "󰙯 " } },
       

         { rule = { class = "Yad" },
               properties = { floating = true } },

         { rule = { class = "Blueman-manager" },
               properties = { floating = true } },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        --awful.placement.no_offscreen(c)
        awful.placement.centered(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 16}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized then -- no borders if only 1 client visible
            c.border_width = 0
        elseif #awful.screen.focused().clients > 1 then
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("~/.config/awesome/autostart_custom.sh")
--awful.spawn.with_shell("~/.fehbg")

