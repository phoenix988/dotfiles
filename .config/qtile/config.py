##____  _                      _      
#|  _ \| |__   ___   ___ _ __ (_)_  __
#| |_) | '_ \ / _ \ / _ \ '_ \| \ \/ /
#|  __/| | | | (_) |  __/ | | | |>  < 
#|_|   |_| |_|\___/ \___|_| |_|_/_/\_\
#                                     
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

from color import colors, layout_colors

#Importing qtile_extras libaries
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration, PowerLineDecoration, BorderDecoration

#This is mainly for my dmenu script :)
#Choose browser you wanna use for my script dm-openweb
#BROWSER = qutebrowser

#Define variables
mod = "mod4"        # Sets mod key to SUPER/WINDOWS
#Terminals
myTerm = "kitty -e /home/karl/.scripts/activated/create-tmux-session.sh"      # My terminal of choice
myterm = "kitty -e zsh"
sysmon = "kitty --class=btop -e btop" #System monitor utility

#Filemanagers
fileManager = "kitty --class=vifm -e vifm"              #My terminal filemanager of choice
guifileManager = "nautilus /home/karl/Pictures/"        #My gui terminal of choice

#Browsers
browser1 = "brave-browser"       #My browser of choice
browser2  = "brave-browser --new-window --app=https://duckduckgo.com" #Browser of choice in fullscreen

#Text editors
guieditor = "neovide"  #My GUI text editor of choice
editor = "kitty --class vim -e vim" #My terminal based editor of choice

#Utilities
virtman = "virt-manager"   #Hypervisor of choice
backup = "sudo timeshift-gtk"   #Backup utility
lockscreen =  "slock"   #My lockscreen of choice

#My custom scripts
dmenu_path = "/home/karl/.dmenu" #Path to my dmenu scripts
script_path = "/home/karl/.scripts/activated" #Path to my scripts

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
         Key([mod, ], "u", #Show all the keybindings
              lazy.spawn("/home/karl/.config/qtile/qtile-keys.sh"),
              desc='Run Help Menu'
              ),
         Key([mod, ], "y", #show kitty bindings
              lazy.spawn("/home/karl/.config/kitty/kitty-keys.sh"),
              desc='Run Help Menu for kitty'
              ),
         Key([mod, "control" ], "i", #Lock the computer
              lazy.spawn(lockscreen),
              desc='Lock computer'
              ),
         Key([mod, ], "space", #Toggle between keyboard layouts
              lazy.spawn(script_path + "/layout-switcher"),
              desc='switch between Keyboard layouts'
             ),

         #KEYS_GROUP Keybindings for scratchpads
         # Key(["mod1", ], "o", #show scratchpad vifm
         #      lazy.group['scratchpad'].dropdown_toggle('vifm'),
         #      desc='show scratchpad vifm'
         #     ),


         #KEYS_GROUP Launch applications with super + key
         Key([mod, ], "r", #Run Rofi
              lazy.spawn("rofi -show drun -show-icons -display-drun \"Run : \" -drun-display-format \"{name}\""),
              desc='Run rofi'
             ),
         Key([mod, ], "s", #Take Screenshot
             lazy.spawn("flameshot gui"),
             desc='flameshot'
             ),
         Key([mod, ], "b", #Brave fullscreen
             lazy.spawn(browser2),
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
         Key([mod, ], "t", #Launch Kitty
             lazy.spawn( myterm ),
             desc='kitty terminal'
             ),
         Key([mod, ], "g", #Launch Gimp
             lazy.spawn( "gimp" ),
             desc='run gimp'
             ),
         Key([mod], "Return", #Run Terminal
             lazy.spawn( myTerm ),
             desc='Launches My Terminal'
              ),

         #KEYS_GROUP Launch applications with super + shift + key
         Key([mod, "shift"], "y", #Run GUIEditor
             lazy.spawn( guieditor ),
             desc='Launches My guieditor'
             ),
         Key([mod, "shift"], "w", #Brave
             lazy.spawn(browser1),
             desc='Launch browser1'
             ),
         Key([mod, "shift"], "v", #Launch Virt-Manager
             lazy.spawn(virtman),
             desc='virt-manager'
             ),
         Key([mod, "shift"], "e", #Launch your filemanager
             lazy.spawn(fileManager),
             desc='File Manager'
             ),
         Key([mod, "shift"], "Return", #Launch your gui filemanager
             lazy.spawn(guifileManager),
             desc='Gui FileManager'
             ),
         Key([mod, "shift"], "g", #Launch kdenlive
             lazy.spawn("kdenlive"),
             desc='kdenlive'
             ),

         #KEYS_GROUP Launch application with alt + control + key
         Key(["mod1", "control"], "t", #Launch TaskManager
             lazy.spawn("lxtask"),
             desc='TaskManager'
             ),
         Key(["mod1", "control"], "s", #Launch Steam
             lazy.spawn("steam"),
             desc='Steam'
             ),
         Key(["mod1", "control"], "b", #Launch Timeshift
             lazy.spawn(backup),
             desc='Open timeshift'
             ),
         Key(["mod1", "control"], "p", #Launch Pavucontrol
             lazy.spawn("pavucontrol"),
             desc='Open Pavucontrol'
             ),
         Key(["mod1", "control"], "w", #Launch Bitwarden
             lazy.spawn("bitwarden-desktop"),
             desc='Bitwarden'
             ),

         #KEYS_GROUP Some of my custom scripts
         Key([mod, ],"F12", #Set a Random wallpaper
             lazy.spawn(script_path + "/set-random-bg"),
             desc='Set a random wallpaper'
             ),
         Key([mod, ],"F11", #Kills and starts picom compositor
             lazy.spawn(script_path + "/picom-control"),
             desc='kills and start picom'
             ),
         Key([mod, ],"F10", #Change display layout,for my laptop when I connect external Screens
             lazy.spawn(script_path + "/change-display-layout.sh"),
             desc='Change Display layout, I use it when I connect external Screens to my laptop'
             ),

         #KEYS_GROUP Media control
         Key([ ],"XF86AudioPlay", #Resume/Stop
             lazy.spawn(script_path + "/mediaplay"),
             desc='Pause'
             ),
         Key([ ],"XF86AudioNext", #Next
             lazy.spawn(script_path + "/medianext"),
             desc='Next'
             ),
         Key([ ],"XF86AudioPrev", #Prev
             lazy.spawn(script_path + "/mediaprev"),
             desc='Previous'
             ),
         Key([ ],"XF86AudioMute", #Mute Audio
             lazy.spawn(script_path + "/mute-unmute.sh"),
             desc='Previous'
             ),
         Key([ ],"XF86AudioLowerVolume", #Lower Volume
             lazy.spawn(script_path + "/volume-down.sh"),
             desc='Previous'
             ),
         Key([ ],"XF86AudioRaiseVolume", #Raise Volume``
             lazy.spawn(script_path + "/volume-up.sh"),
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
         Key([mod, "control"], "r",
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
             #lazy.layout.shrink(),
             #lazy.layout.decrease_nmaster(),
             lazy.layout.left(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
         Key([mod], "l", #Expand window in tilling layout
             #lazy.layout.grow(),
             #lazy.layout.increase_nmaster(),
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
             #lazy.layout.section_jown(),
             desc='Move windows down in current stack'
             ),
         Key([mod, "shift"], "h", #Move widnows up in current stack
             lazy.layout.shuffle_left(),
             #lazy.layout.section_up(),
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
         Key(["mod1", ], "m", #Minimize window
              lazy.spawn("Qminimize -m"),
              desc='Minimize window'
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
         Key(["control", "mod1"], "1", #Move to tmux window 1
             lazy.spawn("tmux select-window -t karl:1"),
             ),
         Key(["control", "mod1"], "2", #Move to tmux window 2
             lazy.spawn("tmux select-window -t karl:2"),
             ),
         Key(["control", "mod1"], "3", #Move to tmux window 3
             lazy.spawn("tmux select-window -t karl:3"),
             ),
         Key(["control", "mod1"], "4", #Move to tmux window 4
             lazy.spawn("tmux select-window -t karl:4"),
             ),
         Key(["control", "mod1"], "5", #Move to tmux window 5
             lazy.spawn("tmux select-window -t karl:5"),
             ),
         Key(["control", "mod1"], "6", #Move to tmux window 6
             lazy.spawn("tmux select-window -t karl:6"),
             ),
         Key(["control", "mod1"], "7", #Move to tmux window 7
             lazy.spawn("tmux select-window -t karl:7"),
             ),
         Key(["control", "mod1"], "8", #Move to tmux window 8
             lazy.spawn("tmux select-window -t karl:8"),
             ),
         Key(["control", "mod1"], "9", #Move to tmux window 9
             lazy.spawn("tmux select-window -t karl:9"),
             ),
         Key(["control", "mod1"], "x", #kill tmux pane
             lazy.spawn("tmux kill-pane -t karl"),
             ),
         Key(["control", "mod1"], "c", #create tmux window
             lazy.spawn("tmux new-window -t karl"),
             ),
         Key(["control", "mod1"], "v", #create horizontal split
             lazy.spawn("tmux splitw -h"),
             ),
         Key(["control", "mod1"], "s", #create vertical split
             lazy.spawn("tmux splitw -v"),
             ),
         Key(["control", "mod1"], "h", #prev pane
             lazy.spawn(script_path + "/next-tmux-pane.sh"),
             ),
         Key(["control", "mod1"], "l", #next pane
             lazy.spawn(script_path + "/prev-tmux-pane.sh"),
             ),

         #KEYS_GROUP Launch terminal based programs using the key chord CONTROL+e followed by 'key'
         KeyChord([mod], "z", [
             Key([], "e", #Launch vifm
                 lazy.spawn(fileManager),
             desc='Open vifm file manager'
             ),
             Key([], "h", #Launch htop
                 lazy.spawn(sysmon),
             desc='Open HTOP'
             ),
             Key([], "r", #Launch ranger
                 lazy.spawn("kitty --class=ranger -e ranger"),
             desc='Open RANGER'
             ),
             Key([], "v", #Launch your terminal editor
                 lazy.spawn(editor),
             desc='launch your terminal editor'
             ),
             Key([], "t", #change rofi theme
                 lazy.spawn("rofi-theme-selector"),
             desc='change rofi theme'
             ),],

                  name="Action: "),

         #KEYS_GROUP Dmenu scripts launched using the key chord SUPER+p followed by 'key'
         KeyChord([mod], "p", [
             Key([], "e", #Choose config file to edit
                 lazy.spawn(dmenu_path + "/dm-editconfig"),
                 desc='Choose a config file to edit'
                 ),
             Key([], "m", #Change the fan Mode of my laptop 
                 lazy.spawn(dmenu_path + "/dm-fan-control"),
                 desc='Mount some harddrives using dmenu'
                 ),
             Key([], "c", #Change RGB color on my asus laptop
                 lazy.spawn(dmenu_path + "/dm-keyboard-color"),
                 desc='Mount some harddrives using dmenu'
                 ),
             Key([], "k", #Kill a process
                 lazy.spawn(dmenu_path + "/dm-kill"),
                 desc='Kill processes via dmenu'
                 ),
             Key([], "r", #Sudo config files
                 lazy.spawn("sudo /home/karl/.dmenu/dm-editconfig"),
                 desc='Config a file that requires root'
                 ),
             Key([], "w", #Set wallpaper
                 lazy.spawn(dmenu_path + "/dm-set-wallpaper"),
                 desc='set a wallpaper'
                 ),
             Key([], "u", #Open a choosen program with dmenu
                 lazy.spawn(dmenu_path + "/dm-app"),
                 desc='Open a program with dmenu'
                 ),
             Key([], "a", #Change audio source
                 lazy.spawn(dmenu_path + "/dm-audioset"),
                 desc='choose audio source'
                 ),
             Key([], "o", #Open a website using your default browser
                 lazy.spawn(dmenu_path + "/dm-openweb"),
                 desc='Search your qutebrowser bookmarks and quickmarks'
                 ),
             Key([], "t", #Change theme for kitty
                 lazy.spawn(dmenu_path + "/dm-kittychangetheme"),
                 desc='Change kitty theme'
                 ),
             Key([], "l", #Change keyboard layout
                 lazy.spawn(dmenu_path + "/dm-layout"),
                 desc='Choose your keyboardlayout'
                 ),
             Key([], "v", #Connect to a vpn server using vpn
                 lazy.spawn(dmenu_path + "/dm-nordvpn"),
                 desc='Choose your VPN server for NordVPN'
                 ),
             Key([], "s", #search the web requires qutebrowser 
                 lazy.spawn(dmenu_path + "/dm-search"),
                 desc='search the web'
                 ),
             Key([], "y", #print an emoji to the clipboard 
                 lazy.spawn(dmenu_path + "/dm-emojis"),
                 desc='print an emoji to the clipboard'
                 ),
             Key([], "g", #Change the overall system theme
                lazy.spawn(dmenu_path + "/change-theme"),
                desc='Change the overall system theme'
                ),
             Key([], "f", #opens my favorite websites in fullscreen mode with minimal UI 
                 lazy.spawn(dmenu_path + "/dm-openweb-fullscreen"),
                 desc='open a website in fullscreen'
                 ),
             Key([], "b", #creates or remove timeshift backup
                 lazy.spawn(dmenu_path + "/dm-timeshift"),
                 desc='creates or remove timeshift backup'
                 ),
             Key([], "q", #Opens a VM of your choice in KVM 
                 lazy.spawn(dmenu_path + "/dm-virt-manager"),
                 desc='Opens a VM of your choice in KVM'
                 ),
             Key([], "j", #Script for pass
                 lazy.spawn(dmenu_path + "/dm-pass"),
                 desc='Script for pass'
                 ),
             Key([], "p", #menu to control music
                 lazy.spawn(dmenu_path + "/dm-play-pause"),
                 desc='menu to control music'
                 ),],
             name="Rofi Script"
         ),

         #KEYS_GROUP window modifier (mainly for bsp) launched using the key chord SUPER+shift+b followed by 'key'
         KeyChord([mod, "shift"], "b", [
             Key([], "k", #Move focus down a pane
                 lazy.layout.up(),
              ),
             Key([], "j", #Move focus up a pane
                 lazy.layout.down(),
              ),
             Key([], "h", #Move focus to the left
                 lazy.layout.left(),
              ),
             Key([], "l", #Move focus to the right
                 lazy.layout.right(),
              ),
             Key([], "d", #flip to the right
                 lazy.layout.flip_right()),
             Key([], "a", #flip to the left
                 lazy.layout.flip_left()),
             Key([], "w", #flip up
                 lazy.layout.flip_up()),
             Key([], "s", #flip down
                 lazy.layout.flip_down()),
             Key([], "n", #normalize the size of the window
                 lazy.layout.normalize()),
             Key(["shift"], "l", #move to the right
                 lazy.layout.shuffle_right()),
             Key(["shift"], "h", #move to the left
                 lazy.layout.shuffle_left()),
             Key(["shift"], "k", #move up
                 lazy.layout.shuffle_up()),
             Key(["shift"], "j", #move down
                 lazy.layout.shuffle_down()),
             Key(["control"], "l", #grow the window to the right
                 lazy.layout.grow_right()),
             Key(["control"], "h", #grow the window to the left
                 lazy.layout.grow_left()),
             Key(["control"], "k", #grow the window up
                 lazy.layout.grow_up()),
             Key(["control"], "j", #grow the window down
                 lazy.layout.grow_down())],

            name="BSP Window"
         ),


]

#END_KEYS






group_names = [("WWW", {'layout': 'bsp' ,'matches':[Match(wm_class=["Brave-browser-nightly", "Chromium" , "librewolf"])]}),
               ("DEV", {'layout': 'bsp','matches':[Match(wm_class=["neo"])]}),
               ("SYS", {'layout': 'bsp', 'matches':[Match(wm_class=["TeamViewer"])]}),
               ("GAM", {'layout': 'max', 'matches':[Match(wm_class=["lutris" , "Steam" , "upc.exe" , "steam_proton" , "heroic"])]}),
               ("DOC", {'layout': 'bsp', 'matches':[Match(wm_class=["re.sonny.Tangram", "crx_cifhbcnohmdccbgoicgdjpfamggdegmo", "disk.yandex.com__client_disk"])]}),
               ("SOC", {'layout': 'max', 'matches':[Match(wm_class=["discord" , "Franz" , "whatsapp-nativefier-d40211" , "altus" , "whatsdesk" , "whatsapp-for-linux", "web.whatsapp.com"])]}),
               ("REC", {'layout': 'bsp', 'matches':[Match(wm_class=["Spotify"])]}),
               ("VID", {'layout': 'treetab', 'matches':[Match(wm_class=["nemo"  , "io.github.celluloid_player.Celluloid" , "urxvt" , "obs", "youtube.com", "netflix.com"])]}),
               ("GFX", {'layout': 'bsp', 'matches':[Match(wm_class=["gimp-2.10","Gimp" ,"Cinelerra","Olive", "kdenlive" , "resolve" ])]})]


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
    #layout.MonadWide(**layout_theme),
    layout.Bsp(**layout_theme,
                 lower_right = True,
                 border_on_single = True,
                 fair = False  ),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    layout.RatioTile(border_width = 2,
                     margin = 0,
                     ratio_increment = 0.2,
                     border_focus = layout_colors[0],
                     border_normal = layout_colors[1],
                      ),
    #layout.Tile(shift_windows=True,
    #ratio = "0,5",  **layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
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
    #layout.Slice(**layout_theme)
]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Ubuntu Mono",
    fontsize = 13,
    padding = 2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
             widget.Sep(
                       linewidth = 0,
                       padding = 0,
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.Image(
                        filename = "~/.config/qtile/icons/pop-os-nord.png",
                        scale = "False",
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myterm)},
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
                       fontsize = 10,
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 5,
                       padding_x = 3,
                       borderwidth = 3,
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
                       border = colors[4],
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
                       foreground = colors[4],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.Clock(
                       foreground = colors[0],
                       background = colors[4],
                       format = "  %A, %B %d/%Y - %H:%M ",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("yad --calendar")},
                       ),
             widget.KeyboardLayout(
                       foreground = colors[0],
                       background = colors[4],
                       configured_keyboards = ['us', 'se', 'az'],
                       padding = 10,
                       ),
             widget.NvidiaSensors(
                       foreground = colors[0],
                       background = colors[4],
                       threshold = 85,
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[4],
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
             widget.TextBox(
                       text = '🖴',
                       background = colors[0],
                       foreground = colors[8],
                       padding = 1,
                       fontsize = 13,
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("baobab")},
                       decorations = [
                            BorderDecoration (
                            colour = colors[8],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.DF(
                        partition = "/",
                        visible_on_warn = False,
                        foreground = colors[8],
                        background = colors[0],
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("baobab")},
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
                       text = '★',
                       background = colors[0],
                       foreground = colors[2],
                       padding = -1,
                       decorations = [
                            BorderDecoration (
                            colour = colors[2],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                        ),
             widget.CPU(
                         foreground = colors[2],
                         background = colors[0],
                         padding = 8,
                         format = '{load_percent}%',
                         decorations = [
                            BorderDecoration (
                            colour = colors[2],
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
                         foreground = colors[6],
                         background = colors[0],
                         fontsize = 11,
                         tag_sensor =  "temp1",
                         decorations = [
                            BorderDecoration (
                            colour = colors[6],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.ThermalSensor(
                        background = colors[0],
                        foreground = colors[6],
                        tag_sensor = "Tctl",
                        threshold = 75,
                        decorations = [
                            BorderDecoration (
                            colour = colors[6],
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
                       foreground = colors[3],
                       background = colors[0],
                       padding = 0,
                       fontsize = 14,
                       decorations = [
                            BorderDecoration (
                            colour = colors[3],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.Memory(
                       foreground = colors[3],
                       background = colors[0],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(sysmon)},
                       padding = 5,
                       decorations = [
                            BorderDecoration (
                            colour = colors[3],
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
                     foreground = colors[5],
                     background = colors[0],
                     decorations = [
                            BorderDecoration (
                            colour = colors[5],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                             ],
                     fontsize = 14
                      ),
             widget.CheckUpdates(
                     update_interval = 1800,
                     distro = "Ubuntu",
                     display_format = "{updates} Updates",
                     colour_have_updates = colors[5],
                     colour_no_updates = colors[5],
                     foreground = colors[5],
                     decorations = [
                            BorderDecoration (
                            colour = colors[5],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                       ],
                     mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myterm + ' -e sudo nala upgrade')},
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
                      foreground = colors[4],
                      background = colors[0],
                      padding = 0,
                      mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("pavucontrol")},
                      decorations = [
                            BorderDecoration (
                            colour = colors[4],
                            border_width = [0, 0, 2, 0],
                            padding_x = 0, )
                     ],
                       ),
             widget.Volume(
                      foreground = colors[4],
                      background = colors[0],
                      padding = 5,
                       decorations = [
                            BorderDecoration (
                            colour = colors[4],
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
             widget.Battery(
                       foreground = colors[8],
                       background = colors[0],
                       padding = -8,
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("xfce4-power-manager-settings")},
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
                        text = '',
                        background = colors[0],
                        foreground = colors[2],
                        padding = 4,
                        fontsize = 15,
                        decorations = [
                            BorderDecoration (
                            colour = colors[2],
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
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=23, margin=3 )),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=23, margin=3)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=26, margin=3))]

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
    Match(title='Confirmation'),  # tastyworks exit box
    Match(title='Qalculate!'),  # qalculate-gtk
    Match(wm_class='kdenlive'),  # kdenlive
    Match(wm_class='gimp-2.10'),  # gimp
    Match(wm_class='pinentry-gtk-2'),  # GPG key password entry
    Match(wm_class='yad'),
    Match(wm_class='bitwarden'),
    Match(wm_class='Cinelerra'),
    Match(wm_class='Gpick'),
    Match(wm_class='resolve'),
    Match(wm_class='Olive'),
    Match(wm_class='lxtask'),
    Match(wm_class='pavucontrol'),
    Match(wm_class='sxiv'),
    Match(wm_class='timeshift-gtk'),
    Match(wm_class=virtman),
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


