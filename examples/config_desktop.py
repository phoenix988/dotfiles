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

from libqtile import widget
from color import colors
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration, PowerLineDecoration, BorderDecoration
from var import variables

widget_font = 14
widget_fam = "JetBrainsMono Nerd Font"

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

def init_widgets_list():
    widgets_list = [
             widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.Image(
                       filename = "~/.config/qtile/icon.png",
                       scale = "False",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(variables['run'])},
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
                       fontsize = 25,
                       margin_y = 5,
                       margin_x = 0,
                       padding_y = 0,
                       padding_x = 2,
                       hide_unused = "true",
                       borderwidth = 3,
                       active = colors[5],
                       inactive = colors[1],
                       rounded = "true",
                       disable_drag = "true",
                       highlight_color = colors[4],
                       highlight_method = "line",
                       this_current_screen_border = colors[4],
                       this_screen_border = colors[2],
                       other_current_screen_border = colors[4],
                       other_screen_border = colors[2],
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
                       text = '',
                       background = colors[0],
                       foreground = colors[2],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = ' ',
                       background = colors[2],
                       foreground = colors[0],
                       padding = 1,
                       font = widget_fam,
                       fontsize = 25,
                       ),
             widget.KeyboardLayout(
                       foreground = colors[0],
                       background = colors[2],
                       font = widget_fam,
                       fontsize = 20,
                       configured_keyboards = ['us', 'se', 'az'],
                       padding = 10,
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[2],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.Sep(
                       linewidth = 0,
                       padding = 10,
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.TaskList(
                       font = widget_fam,
                       fontsize = 16,
                       foreground = colors[15],
                       background = colors[0],
                       borderwidth = 0,
                       border = colors[4],
                       margin = 5,
                       margin_y = 4,
                       padding = 0,
                       highlight_method = "block",
                       title_width_method = "uniform",
                       urgent_alert_method = "border",
                       urgent_border = colors[1],
                       rounded = False,
                       icon_size = 27,
                       txt_floating = "🗗 ",
                       txt_maximized = "🗖 ",
                       txt_minimized = "🗕 ",
                       ),
             widget.Sep(
                       linewidth = 1,
                       padding = 10,
                       foreground = colors[0],
                       background = colors[0]
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[2],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.Clock(
                       foreground = colors[0],
                       background = colors[2],
                       fontsize   = widget_font,
                       font = "JetBrainsMono Nerd Font",
                       format = " %A, %B %d/%Y -  %H:%M ",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("yad --calendar")},
                       ),
             widget.NvidiaSensors(
                       foreground = colors[0],
                       background = colors[2],
                       font = widget_fam,
                       threshold = 85,
                       ),
             widget.TextBox(
                       text = '',
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
                       text = '',
                       background = colors[0],
                       foreground = colors[1],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.Systray(
                       background = colors[1],
                       padding = 1,
                       ),
             widget.Sep(
                       linewidth = 0,
                       padding = 12,
                       foreground = colors[1],
                       background = colors[1]
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[1],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.OpenWeather(
                       background = colors[0],
                       foreground = colors[8],
                       fontsize   = widget_font,
                       font = widget_fam,
                       cityid = "598316",
                       format = '󰖐 {main_temp} {units_temperature}° {weather_details}',
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(variables['browser'] + " https://openweathermap.org/city/598316")},
                       decorations = [
                            BorderDecoration (
                            colour = colors[8],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       #text = '🖴',
                       text = '⛁ ',
                       background = colors[0],
                       foreground = colors[9],
                       padding = 1,
                       font = widget_fam,
                       fontsize = widget_font,
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("baobab")},
                       decorations = [
                            BorderDecoration (
                            colour = colors[9],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.DF(
                       partition = "/",
                       visible_on_warn = False,
                       foreground = colors[9],
                       background = colors[0],
                       fontsize = widget_font,
                       font = widget_fam,
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("baobab")},
                       decorations = [
                            BorderDecoration (
                            colour = colors[9],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = "",
                       background = colors[0],
                       foreground = colors[10],
                       padding = 1,
                       fontsize = widget_font,
                       decorations = [
                            BorderDecoration (
                            colour = colors[10],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.CPU(
                       foreground = colors[10],
                       background = colors[0],
                       fontsize = widget_font,
                       font = widget_fam,
                       padding = 8,
                       format = ' {load_percent}%',
                       decorations = [
                            BorderDecoration (
                            colour = colors[10],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text='',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = " 󰔐",
                       padding = 6,
                       foreground = colors[11],
                       background = colors[0],
                       fontsize = widget_font,
                       font = widget_fam,
                       tag_sensor =  "temp1",
                       decorations = [
                            BorderDecoration (
                            colour = colors[11],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.ThermalSensor(
                       background = colors[0],
                       foreground = colors[11],
                       tag_sensor = "Tctl",
                       fontsize = widget_font,
                       font = widget_fam,
                       threshold = 75,
                       decorations = [
                            BorderDecoration (
                            colour = colors[11],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = "",
                       foreground = colors[12],
                       background = colors[0],
                       padding = 0,
                       fontsize = widget_font,
                       decorations = [
                            BorderDecoration (
                            colour = colors[12],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.Memory(
                       foreground = colors[12],
                       background = colors[0],
                       font = "JetBrainsMono Nerd Font",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(variables['sysmon'])},
                       format = '{MemUsed: .0f}{mm} /{MemTotal: .0f}{mm}',
                       fontsize = widget_font,
                       padding = 5,
                       decorations = [
                            BorderDecoration (
                            colour = colors[12],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text='',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = "",
                       padding = 2,
                       foreground = colors[13],
                       background = colors[0],
                       fontsize = widget_font,
                       decorations = [
                            BorderDecoration (
                            colour = colors[13],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.CheckUpdates(
                       update_interval = 1800,
                       distro = "Arch",
                       fontsize = widget_font,
                       font = widget_fam,
                       display_format = " {updates} Updates",
                       colour_have_updates = colors[13],
                       colour_no_updates = colors[13],
                       foreground = colors[13],
                       background = colors[0],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(variables['term'] + ' -e sudo pacman -Syu')},
                       decorations = [
                            BorderDecoration (
                            colour = colors[13],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = "♫ Vol:",
                       foreground = colors[14],
                       background = colors[0],
                       padding = 0,
                       fontsize = widget_font,
                       font = widget_fam,
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("pavucontrol")},
                       decorations = [
                            BorderDecoration (
                            colour = colors[14],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.Volume(
                       foreground = colors[14],
                       background = colors[0],
                       padding = 5,
                       fontsize = widget_font,
                       font = widget_fam,
                       decorations = [
                            BorderDecoration (
                            colour = colors[14],
                            border_width = [0, 0, 4, 0],
                            padding_x = 0, )
                            ],
                       ),
             widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.Sep(
                       linewidth = 0,
                       padding = 12,
                       foreground = colors[2],
                       background = colors[0]
                       ),
             widget.CurrentLayoutIcon(
                       background = colors[2],
                       font = widget_fam,
                       use_mask = "true",
                       foreground = colors[0],
                       scale = 0.8,
                       padding = 10
                       ),
             widget.Sep(
                       linewidth = 0,
                       padding = 4,
                       foreground = colors[2],
                       background = colors[2]
                       ),

    ]

    return widgets_list
