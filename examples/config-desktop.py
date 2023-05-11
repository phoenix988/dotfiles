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
                        filename = "~/.config/qtile/icons/pop-os-rose-pine.png",
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
                       fontsize = 16,
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
                       text = '',
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
                       text = '',
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
                       text = '',
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
                      padding = 1
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
                       text = '',
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
                       text = '',
                       background = colors[0],
                       foreground = colors[0],
                       padding = -1,
                       fontsize = 45
                       ),
             widget.TextBox(
                       text = '' ,
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
                       text='',
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
                       text = '',
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
                       text='',
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
                       text = '',
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
                       text = '',
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
