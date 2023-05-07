##____  _                      _
#|  _ \| |__   ___   ___ _ __ (_)_  __
#| |_) | '_ \ / _ \ / _ \ '_ \| \ \/ /
#|  __/| | | | (_) |  __/ | | | |>  <
#|_|   |_| |_|\___/ \___|_| |_|_/_/\_\
# -*- coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

# Import the colors qtile will use
from color import colors, layout_colors

# Importing qtile_extras libaries
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration, PowerLineDecoration, BorderDecoration

# Define super key as variable
mod = "mod4"

# Terminals
MYTERM = "kitty -e zsh"
MYTERM_NORMAL = "kitty -e zsh"
SYSMON = "kitty --class=btop -e btop"

# Filemanagers
FILE_MANAGER = "emacsclient -c -a '' --eval '(dired nil)'"
GUI_FILE_MANAGER = "pcmanfm"

# Browsers
BROWSER2  = "brave-browser --new-window --app=https://duckduckgo.com"
BROWSER1  = "librewolf"

# Text editors
EDITOR = "emacsclient -c -a emacs"

# Utilities
VIRTMAN = "virt-manager"
BACKUP = "sudo timeshift-gtk"
LOCKSCREEN =  "slock"

# My custom scripts
DMENU_PATH = "/home/karl/.dmenu"
SCRIPT_PATH = "/home/karl/.scripts/activated"
TMUX_PATH = "/home/karl/.scripts/tmux"

#START_KEYS
keys = [
         #KEYS_GROUP Qtile
         Key([mod, "shift"], "r", #Restart
              lazy.restart(),
              desc='Restart Qtile'
              ),
         Key([mod, "shift"], "q", #Logout
              lazy.shutdown(),
              desc='Shutdown Qtile'
              ),
         Key([mod, ], "F2", #Show all the keybindings
              lazy.spawn("/home/karl/.config/qtile/qtile-keys.sh"),
              desc='Run Help Menu'
              ),
         Key([mod, ], "F1", #show kitty bindings
              lazy.spawn("/home/karl/.config/kitty/kitty-keys.sh"),
              desc='Run Help Menu for kitty'
              ),
         Key(["control", "mod1" ], "l", #Lock the computer
              lazy.spawn(LOCKSCREEN),
              desc='Lock computer'
              ),
         Key([mod, ], "space", #Toggle between keyboard layouts
              lazy.spawn(SCRIPT_PATH + "/layout-switcher"),
              desc='switch between Keyboard layouts'
             ),
         Key([mod, ], "r", #Run Rofi
              lazy.spawn("rofi -show drun -show-icons -display-drun \"Run : \" -drun-display-format \"{name}\""),
              desc='Run rofi'
             ),

#KEYS_GROUP Launch applications with super + key
Key([mod, ], "s", #Take Screenshot
    lazy.spawn("flameshot gui"),
    desc='flameshot'
    ),
Key([mod, ], "b", #Brave fullscreen
    lazy.spawn(BROWSER2),
    desc='Launch browser2'
    ),
Key([mod, ], "i", #lxappearance
    lazy.spawn("lxappearance"),
    desc='theme settings'
    ),
Key([mod, ], "o", #Launch OBS
    lazy.spawn("obs"),
    desc='OBS studio'
    ),
Key([mod, ], "t", #Launch Terminal
    lazy.spawn( MYTERM_NORMAL ),
    desc='kitty terminal'
    ),
Key([mod, ], "g", #Launch Gimp
    lazy.spawn( "gimp" ),
    desc='run gimp'
    ),
Key([mod], "Return", #Run Terminal
    lazy.spawn( MYTERM ),
    desc='Launches My Terminal'
     ),

#KEYS_GROUP Launch applications with super + shift + key
Key([mod, "shift"], "y", #Run Graphical Text editor
    lazy.spawn( EDITOR ),
    desc='Launch My Graphical Editor'
    ),
Key([mod, "shift"], "w", #Browser 1
    lazy.spawn(BROWSER1),
    desc='Launch browser1'
    ),
Key([mod, "shift"], "v", #Launch Virt-Manager
    lazy.spawn(VIRTMAN),
    desc='virt-manager'
    ),
Key([mod, "shift"], "e", #Launch your filemanager
    lazy.spawn(FILE_MANAGER),
    desc='Terminal File Manager'
    ),
Key([mod, "shift"], "Return", #Launch your Graphical filemanager
    lazy.spawn(GUI_FILE_MANAGER),
    desc='Launch Graphical FileManager'
    ),
Key([mod, "shift"], "g", #Launch kdenlive
    lazy.spawn("kdenlive"),
    desc='Launch kdenlive'
    ),
Key([mod, "shift"], "d", #Launch your text editor
    lazy.spawn(EDITOR),
    desc='Launch Your text editor'
    ),
Key([mod, "shift"], "o", #Launch gparted
    lazy.spawn("Gparted"),
    desc='Launch Gparted'
    ),

#KEYS_GROUP Launch application with alt + control + key
Key(["mod1", "control"], "t", #Launch TaskManager
    lazy.spawn("lxtask"),
    desc='Launch LxTask'
    ),
Key(["mod1", "control"], "g", #Launch Steam
    lazy.spawn("steam"),
    desc='Launch Steam'
    ),
Key(["mod1", "control"], "b", #Launch Timeshift
    lazy.spawn(BACKUP),
    desc='Launch timeshift'
    ),
Key(["mod1", "control"], "p", #Launch Pavucontrol
    lazy.spawn("pavucontrol"),
    desc='Launch Pavucontrol'
    ),
Key(["mod1", "control"], "w", #Launch Bitwarden
    lazy.spawn("flatpak run com.bitwarden.desktop"),
    desc='Launch Bitwarden'
    ),

#KEYS_GROUP Some of my custom scripts
Key([mod, ],"F12", #Set a Random wallpaper
    lazy.spawn(SCRIPT_PATH + "/set-random-bg"),
    desc='Set a random wallpaper'
    ),
Key([mod, ],"F11", #Kills and starts picom compositor
    lazy.spawn(SCRIPT_PATH + "/picom-control"),
    desc='kills and start picom'
    ),
Key([mod, ],"F10", #Change display layout,for my laptop when I connect external Screens
    lazy.spawn(SCRIPT_PATH + "/change-display-layout.sh"),
    desc='Change Display layout, I use it when I connect external Screens to my laptop'
    ),

#KEYS_GROUP Media control
Key([ ],"XF86AudioPlay", #Resume/Stop
    lazy.spawn(SCRIPT_PATH + "/mediaplay"),
    desc='Pause'
    ),
Key([ ],"XF86AudioNext", #Next
    lazy.spawn(SCRIPT_PATH + "/medianext"),
    desc='Next'
    ),
Key([ ],"XF86AudioPrev", #Prev
    lazy.spawn(SCRIPT_PATH + "/mediaprev"),
    desc='Previous'
    ),
Key([ ],"XF86AudioMute", #Mute Audio
    lazy.spawn(SCRIPT_PATH + "/mute-unmute.sh"),
    desc='Previous'
    ),
Key([ ],"XF86AudioLowerVolume", #Lower Volume
    lazy.spawn(SCRIPT_PATH + "/volume-down.sh"),
    desc='Previous'
    ),
Key([ ],"XF86AudioRaiseVolume", #Raise Volume``
    lazy.spawn(SCRIPT_PATH + "/volume-up.sh"),
    desc='Previous'
    ),

#KEYS_GROUP Switch focus to specific monitor (out of two)
Key([mod], "w", #Move focus to monitor 1
    lazy.to_screen(0),
    desc='Keyboard focus to monitor 1'
    ),
Key([mod], "e", #Move focus to moinitor 2
    lazy.to_screen(1),
    desc='Keyboard focus to monitor 2'
    ),
Key([mod, "control"], "r",  #Move focus to moinitor 3
    lazy.to_screen(2),
    desc='Keyboard focus to monitor 3'
    ),

#Switch focus of monitors
Key([mod], "period", #Move focus to the next monitor
    lazy.next_screen(),
    desc='Move focus to next monitor'
    ),
Key([mod], "comma", #Move focus to the prev monitor
    lazy.prev_screen(),
    desc='Move focus to prev monitor'
    ),

#KEYS_GROUP Treetab controls
Key([mod, "control"], "h", #Move up a section in treetab
    lazy.layout.move_left(),
    desc='Move up a section in treetab'
    ),
Key([mod, "shift"], "l", #Move up a section in treetab
    lazy.layout.move_right(),
    desc='Move down a section in treetab'
    ),

#KEYS_GROUP Window controls
Key([mod], "Tab", #Toggle through layouts
    lazy.next_layout(),
    desc='Toggle through layouts'
    ),
Key([mod,], "q", #Close window
    lazy.window.kill(),
    desc='Kill active window'
    ),
Key([mod], "k", #Move focus down a pane
    lazy.layout.up(),
    desc='Move focus down in current stack pane'
    ),
Key([mod], "j", #Move focus up a pane
    lazy.layout.down(),
    desc='Move focus up in current stack pane'
    ),
Key([mod], "h", #Shrink window in tilling layout
    lazy.layout.left(),
    desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
    ),
Key([mod], "l", #Expand window in tilling layout
    lazy.layout.right(),
    desc='Expand window (MonadTall), increase number in master pane (Tile)'
    ),
Key([mod], "n", #Normalize window size ratio
    lazy.layout.normalize(),
    desc='normalize window size ratios'
    ),
Key([mod], "m", #Toggle window between minimum and maximum size
    lazy.layout.maximize(),
    desc='toggle window between minimum and maximum sizes'
    ),
Key(["mod1", ], "m", #Minimize window
     lazy.spawn("Qminimize -m"),
     desc='Minimize window'
    ),
Key([mod], "f", #Toggle fullscreen
    lazy.window.toggle_fullscreen(),
    desc='toggle fullscreen'
    ),
Key([mod, "shift"], "j", #Move windows down in current stack
    lazy.layout.shuffle_down(),
    lazy.layout.section_jown(),
    desc='Move windows down in current stack'
    ),
Key([mod, "shift"], "k", #Move widnows up in current stack
    lazy.layout.shuffle_up(),
    lazy.layout.section_up(),
    desc='Move windows up in current stack'
    ),
Key([mod, "shift"], "l", #Move windows down in current stack
    lazy.layout.shuffle_right(),
    desc='Move windows down in current stack'
    ),
Key([mod, "shift"], "h", #Move widnows up in current stack
    lazy.layout.shuffle_left(),
    desc='Move windows up in current stack'
    ),
Key([mod, "shift"], "f", #Toggle floating
    lazy.window.toggle_floating(),
    desc='toggle floating'
    ),
Key([mod, "mod1"], "l", #change the position of the window to the right
    lazy.layout.flip_right(),
    desc='change the position of the window to the right'
    ),
Key([mod, "mod1"], "h", #change the position of the window to the left
    lazy.layout.flip_left(),
    desc='change the position of the window to the left'
    ),
Key([mod, "mod1"], "j", #change the position of the window down
    lazy.layout.flip_down(),
    desc='change the position of the window down'
    ),
Key([mod, "mod1"], "k", #change the position of the window up
    lazy.layout.flip_up(),
    desc='change the position of the window up'
    ),
Key([mod, "control"], "h", #increase the size of the window to the left
    lazy.layout.grow_left(),
    desc='increase the size of the window to the left'
    ),
Key([mod, "control"], "l", #increase the size of the window to the left
    lazy.layout.grow_right(),
    desc='increase the size of the window to the left'
    ),
Key([mod, "control"], "j", #increase the size of the window downwards
    lazy.layout.grow_down(),
    desc='increase the size of the window downwards'
    ),
Key([mod, "control"], "k", #increase the size of the window upwards
    lazy.layout.grow_up(),
    desc='increase the size of the window upwards'
    ),

#KEYS_GROUP Stack controls
Key([mod, "shift"], "Tab", #Switch which side main pane occupies, XmonadTall
    lazy.layout.rotate(),
    lazy.layout.flip(),
    desc='Switch which side main pane occupies (XmonadTall)'
    ),
Key([mod, "control"], "space", #Switch window focus to other panes of stack
    lazy.layout.next(),
    desc='Switch window focus to other pane(s) of stack'
    ),
Key([mod, "shift"], "space", #Toggle between split and unsplit sides of stack
    lazy.layout.toggle_split(),
    desc='Toggle between split and unsplit sides of stack'
    ),

#KEYS_GROUP keybindings to control tmux without keychords
Key(["mod1",], "1", #Move to tmux window 1
    lazy.spawn(TMUX_PATH + "/window-1"),
    ),
Key(["mod1",], "2", #Move to tmux window 2
    lazy.spawn(TMUX_PATH + "/window-2"),
    ),
Key(["mod1"], "3", #Move to tmux window 3
    lazy.spawn(TMUX_PATH + "/window-3"),
    ),
Key(["mod1",], "4", #Move to tmux window 4
    lazy.spawn(TMUX_PATH + "/window-4"),
    ),
Key(["mod1",], "5", #Move to tmux window 5
    lazy.spawn(TMUX_PATH + "/window-5"),
    ),
Key(["mod1",], "6", #Move to tmux window 6
    lazy.spawn(TMUX_PATH + "/window-6"),
    ),
Key(["mod1",], "7", #Move to tmux window 7
    lazy.spawn(TMUX_PATH + "/window-7"),
    ),
Key(["mod1",], "8", #Move to tmux window 8
    lazy.spawn(TMUX_PATH + "/window-8"),
    ),
Key(["mod1",], "9", #Move to tmux window 9
    lazy.spawn(TMUX_PATH + "/window-9"),
    ),
Key(["control", "mod1"], "v", #create horizontal split
    lazy.spawn("tmux splitw -h"),
    ),
Key(["control", "mod1"], "s", #create vertical split
    lazy.spawn("tmux splitw -v"),
    ),

#KEYS_GROUP Launch terminal based programs using the key chord CONTROL+e followed by 'key'
KeyChord(["control"], "e", [
    Key([], "d", #Launch dired emacs file manager
        lazy.spawn(FILE_MANAGER),
    desc='Open file manager in emacs'
    ),
    Key([], "s", #Launch Eshell in emacs
        lazy.spawn("emacsclient -c -a '' --eval '(eshell)'"),
    desc='Launch Eshell in emacs'
    ),
    Key([], "h", #Launch htop
        lazy.spawn(SYSMON),
    desc='Launch HTOP'
    ),
    Key([], "r", #Launch ranger
        lazy.spawn("kitty --class=ranger -e ranger"),
    desc='Launch Ranger'
    ),
    Key([], "e", #Launch Emacs
        lazy.spawn("emacsclient -c -a 'emacs'"),
    desc='Launch Emacs'
    ),
    Key([], "t", #Change rofi theme
        lazy.spawn("rofi-theme-selector"),
    desc='Change Rofi Theme'
    ),],

name="Action: "),

#KEYS_GROUP Dmenu scripts launched using the key chord SUPER+p followed by 'key'
         KeyChord([mod], "p", [
             Key([], "e", #Choose config file to edit
                 lazy.spawn(DMENU_PATH + "/dm-editconfig"),
                 desc='Choose a config file to edit'
                 ),
             Key([], "m", #Mount some of my filesystems
                 lazy.spawn(DMENU_PATH + "/dm-mount"),
                 desc='Mount some harddrives using dmenu'
                 ),
             Key([], "k", #Kill a process
                 lazy.spawn(DMENU_PATH + "/dm-kill"),
                 desc='Kill processes via dmenu'
                 ),
             Key([], "n", #Ssh script
                 lazy.spawn("sudo /home/karl/.dmenu/dm-ssh"),
                 desc='Config a file that requires root'
                 ),
             Key([], "w", #Set wallpaper
                 lazy.spawn(DMENU_PATH + "/dm-set-wallpaper"),
                 desc='set a wallpaper'
                 ),
             Key([], "u", #Open a choosen program with dmenu
                 lazy.spawn(DMENU_PATH + "/dm-app"),
                 desc='Open a program with dmenu'
                 ),
             Key([], "a", #Change audio source
                 lazy.spawn(DMENU_PATH + "/dm-audioset"),
                 desc='choose audio source'
                 ),
             Key([], "o", #Open a website using your default browser
                 lazy.spawn(DMENU_PATH + "/dm-openweb"),
                 desc='Search your qutebrowser bookmarks and quickmarks'
                 ),
             Key([], "t", #Change theme for kitty
                 lazy.spawn(DMENU_PATH + "/dm-kittychangetheme"),
                 desc='Change kitty theme'
                 ),
             Key([], "l", #Change keyboard layout
                 lazy.spawn(DMENU_PATH + "/dm-input"),
                 desc='Choose your keyboardlayout'
                 ),
             Key([], "v", #Connect to a vpn server using vpn
                 lazy.spawn(DMENU_PATH + "/dm-vpn"),
                 desc='Choose your VPN server for NordVPN'
                 ),
             Key([], "s", #search the web requires qutebrowser
                 lazy.spawn(DMENU_PATH + "/dm-search"),
                 desc='search the web'
                 ),
             Key([], "g", #Change the overall system theme
                lazy.spawn(DMENU_PATH + "/dm-theme"),
                desc='Change the overall system theme'
                ),
             Key([], "f", #opens my favorite websites in fullscreen mode with minimal UI
                 lazy.spawn(DMENU_PATH + "/dm-openweb-fullscreen"),
                 desc='open a website in fullscreen'
                 ),
             Key([], "b", #creates or remove timeshift backup
                 lazy.spawn(DMENU_PATH + "/dm-timeshift"),
                 desc='creates or remove timeshift backup'
                 ),
             Key([], "q", #Opens a VM of your choice in KVM
                 lazy.spawn(DMENU_PATH + "/dm-virt-manager"),
                 desc='Opens a VM of your choice in KVM'
                 ),
             Key([], "j", #Script for pass
                 lazy.spawn(DMENU_PATH + "/dm-pass"),
                 desc='Script for pass'
                 ),
             Key([], "y", #Script to manage tmux session
                 lazy.spawn(DMENU_PATH + "/dm-tmux"),
                 desc='Script to manage tmux session'
                 ),
             Key([], "p", #menu to control music
                 lazy.spawn(DMENU_PATH + "/dm-play-pause"),
                 desc='menu to control music'
                 ),],

            name="Rofi Script"
         ),

]

#END_KEYS

group_names = [("", {'layout': 'bsp' ,'matches':[Match(wm_class=["Brave-browser-nightly", "Chromium" , "librewolf"])]}),
               ("", {'layout': 'bsp','matches':[Match(wm_class=["neo"])]}),
               ("", {'layout': 'bsp', 'matches':[Match(wm_class=["TeamViewer"])]}),
               ("", {'layout': 'max', 'matches':[Match(wm_class=["lutris" , "Steam" , "upc.exe" , "steam_proton" , "heroic"])]}),
               ("", {'layout': 'bsp', 'matches':[Match(wm_class=["re.sonny.Tangram", "crx_cifhbcnohmdccbgoicgdjpfamggdegmo", "disk.yandex.com__client_disk"])]}),
               ("", {'layout': 'max', 'matches':[Match(wm_class=["discord" , "Franz" , "whatsapp-nativefier-d40211" , "altus" , "whatsdesk" , "whatsapp-for-linux", "web.whatsapp.com"])]}),
               ("", {'layout': 'bsp', 'matches':[Match(wm_class=["Spotify"])]}),
               ("", {'layout': 'treetab', 'matches':[Match(wm_class=["io.github.celluloid_player.Celluloid" , "urxvt" , "obs", "youtube.com", "netflix.com"])]}),
               ("", {'layout': 'bsp', 'matches':[Match(wm_class=["gimp-2.10","Gimp" ,"Cinelerra","Olive", "kdenlive" , "resolve" ])]})]


groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

#My default layout theme
#and if you want to activate a layout just uncomment them
layout_theme = {"border_width": 2,
                "margin": 5,
                "border_focus": layout_colors[0],
                "border_normal": layout_colors[1]
                }

layouts = [
    layout.Bsp(**layout_theme,
                 lower_right = True,
                 border_on_single = True,
                 fair = False  ),
    layout.RatioTile(border_width = 2,
                     margin = 0,
                     ratio_increment = 0.2,
                     border_focus = layout_colors[0],
                     border_normal = layout_colors[1],
                      ),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2,
                border_focus = layout_colors[0],
                border_normal = layout_colors[1],
                autosplit = False,
                fair = True ),
    layout.RatioTile(**layout_theme),
    layout.TreeTab(
         font = "Ubuntu Mono",
         fontsize = 10,
         sections = [""],
         section_fontsize = 10,
         border_width = 2,
         bg_color = layout_colors[2],
         active_bg = layout_colors[0],
         active_fg = layout_colors[3],
         inactive_bg = layout_colors[4],
         inactive_fg = layout_colors[3],
         padding_left = 0,
         padding_right = 10,
         padding_x = 8,
         padding_y = 8,
         section_top = 5,
         section_bottom = 15,
         section_padding = 10,
         level_shift = 8,
         vspace = 5,

         margin_y = 20,
         panel_width = 150
         ),
    layout.Floating(**layout_theme,
                      fullscreen_border_width = 1,
                      max_border_width = 1),
]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

def init_widgets_list():
    widgets_list = [
             widget.Sep(
                       linewidth = 0,
                       padding = 0,
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.Image(
                        filename = "~/.config/qtile/icons/pop-os-iceberg.png",
                        scale = "False",
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(MYTERM_NORMAL)},
                        padding = 10
                        ),
             widget.Sep(
                       linewidth = 0,
                       padding = 0,
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.GroupBox(
                       font = "Ubuntu Bold",
                       fontsize = 28,
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 5,
                       padding_x = 3,
                       borderwidth = 2,
                       active = colors[5],
                       inactive = colors[1],
                       rounded = "true",
                       disable_drag = "true",
                       highlight_color = colors[4],
                       highlight_method = "line",
                       this_current_screen_border = colors[4],
                       this_screen_border = colors[4],
                       other_current_screen_border = colors[4],
                       other_screen_border = colors[4],
                       urgent_border = colors[5],
                       urgent_alert_method = "line",
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.Prompt(
                       prompt = prompt,
                       font = "Ubuntu Mono",
                       padding = 10,
                       foreground = colors[3],
                       background = colors[1]
                       ),
             widget.Sep(
                       linewidth = 0,
                       padding = 20,
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[4],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.CurrentLayout(
                       foreground = colors[0],
                       background = colors[4],
                       padding = 8,
                       fontsize = 15
                       ),
             widget.CurrentLayoutIcon(
                       background = colors[4],
                       use_mask = "true",
                       foreground = colors[0],
                       scale = 0.8,
                       padding = 10
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[4],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.Sep(
                       linewidth = 0,
                       padding = 4,
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.TaskList(
                       foreground = colors[6],
                       background = colors[0],
                       padding = 0,
                       margin = 5,
                       border = colors[6],
                       borderwidth = 1,
                       urgent_alert_method = "text",
                       urgent_border = colors[2]
                       ),
             widget.Sep(
                       linewidth = 1,
                       padding = 0,
                       foreground = colors[0],
                       background = colors[0]
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[2],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.Clock(
                       foreground = colors[0],
                       background = colors[2],
                       format = "  %A, %B %d/%Y - %H:%M ",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("yad --calendar")},
                       ),
             widget.KeyboardLayout(
                       foreground = colors[0],
                       background = colors[2],
                       configured_keyboards = ['us', 'se', 'az'],
                       padding = 10,
                       ),
             widget.NvidiaSensors(
                       foreground = colors[0],
                       background = colors[2],
                       threshold = 85,
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[2],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.Sep(
                       linewidth = 15,
                       padding = 1,
                       foreground = colors[0],
                       background = colors[0]
                       ),
             widget.Chord(
                       background = colors[0],
                       foreground = colors[2],
                       padding = 1
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[1],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.Systray(
                      background = colors[1],
                      padding = 1
                      ),
             widget.TextBox(
                       text = '',
                       background = colors[1],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.OpenWeather(
                       background = colors[0],
                       foreground = colors[8],
                       cityid = "598316",
                       format = '{location_city}: {main_temp} {units_temperature}°  {weather_details}',
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("brave-browser https://openweathermap.org/city/598316")},
                       decorations = [
                            BorderDecoration (
                            colour = colors[8],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = '🖴',
                       background = colors[0],
                       foreground = colors[9],
                       padding = 1,
                       fontsize = 13,
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("baobab")},
                       decorations = [
                            BorderDecoration (
                            colour = colors[9],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.DF(
                        partition = "/",
                        visible_on_warn = False,
                        foreground = colors[9],
                        background = colors[0],
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("baobab")},
                        decorations = [
                            BorderDecoration (
                            colour = colors[9],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = '★',
                       background = colors[0],
                       foreground = colors[10],
                       padding = -1,
                       decorations = [
                            BorderDecoration (
                            colour = colors[10],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.CPU(
                         foreground = colors[10],
                         background = colors[0],
                         padding = 8,
                         format = '{load_percent}%',
                         decorations = [
                            BorderDecoration (
                            colour = colors[10],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text='',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = " 🌡",
                       padding = 6,
                       foreground = colors[11],
                       background = colors[0],
                       fontsize = 11,
                       tag_sensor =  "temp1",
                       decorations = [
                          BorderDecoration (
                          colour = colors[11],
                          border_width = [0, 0, 2, 0],
                          padding_x = 0, )
                          ],
                       ),
             widget.ThermalSensor(
                        background = colors[0],
                        foreground = colors[11],
                        tag_sensor = "Tctl",
                        threshold = 75,
                        decorations = [
                            BorderDecoration (
                            colour = colors[11],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = " 🖬",
                       foreground = colors[12],
                       background = colors[0],
                       padding = 0,
                       fontsize = 14,
                       decorations = [
                            BorderDecoration (
                            colour = colors[12],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.Memory(
                       foreground = colors[12],
                       background = colors[0],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(SYSMON)},
                       padding = 5,
                       decorations = [
                            BorderDecoration (
                            colour = colors[12],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text='',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                     text = " ⟳",
                     padding = 2,
                     foreground = colors[13],
                     background = colors[0],
                     fontsize = 14,
                     decorations = [
                            BorderDecoration (
                            colour = colors[13],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.CheckUpdates(
                     update_interval = 1800,
                     distro = "Arch",
                     display_format = "{updates} Updates",
                     colour_have_updates = colors[13],
                     colour_no_updates = colors[13],
                     foreground = colors[13],
                     decorations = [
                            BorderDecoration (
                            colour = colors[13],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                     mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(MYTERM_NORMAL + ' -e sudo pacman -Syu')},
                     background = colors[0]
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                      text = "♫  Vol:",
                      foreground = colors[14],
                      background = colors[0],
                      padding = 0,
                      mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("pavucontrol")},
                      decorations = [
                            BorderDecoration (
                            colour = colors[14],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.Volume(
                      foreground = colors[14],
                      background = colors[0],
                      padding = 5,
                      decorations = [
                            BorderDecoration (
                            colour = colors[14],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                        text = '',
                        background = colors[0],
                        foreground = colors[15],
                        padding = 4,
                        fontsize = 15,
                        decorations = [
                            BorderDecoration (
                            colour = colors[15],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
    ]

    return widgets_list

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[18:23]               # Slicing removes unwanted widgets (systray) on Monitors 2,3
    return widgets_screen2

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    del widgets_screen1[18]               # Slicing removes unwanted widgets on Monitors 1
    return widgets_screen1                 # Monitor 1 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=23, margin=8 )),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=23, margin=8)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=26, margin=8))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),
    Match(title='Qalculate!'),
    Match(wm_class='kdenlive'),
    Match(wm_class='gimp-2.10'),
    Match(wm_class='pinentry-gtk-2'),
    Match(wm_class='yad'),
    Match(wm_class='bitwarden'),
    Match(wm_class='Cinelerra'),
    Match(wm_class='Gpick'),
    Match(wm_class='resolve'),
    Match(wm_class='Olive'),
    Match(wm_class='lxtask'),
    Match(wm_class='pavucontrol'),
    Match(wm_class='sxiv'),
    Match(wm_class=BACKUP),
    Match(wm_class=VIRTMAN),
    Match(wm_class="shotcut")
])


auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])



# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
