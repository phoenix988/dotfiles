-- Imports all widgets so its available to use
local init          = {}

-- Imports modules we need
local lain          = require("lain")
local chosen_theme  = require("activate_theme")
local theme         = require("themes/" .. chosen_theme.chosen_theme .. "/color")
local font          = require("themes.default.font")
local command       = require("widgets.layout").command

-- imports kernelwidgets
init.kernelwidget = require("widgets.kernelwidget")

-- System monitor widgets
init.cpu = require("widgets.barwidgets.cpuwidget")
init.fs  = require("widgets.barwidgets.fswidget")
init.mem = require("widgets.barwidgets.memwidget")
init.vol = require("widgets.barwidgets.volwidget")
init.bat = require("widgets.barwidgets.batwidget")

-- Seperators
init.pow = require("widgets.seperator.powerline")
init.sep = require("widgets.seperator.normal")

-- Clock
init.clock = require("widgets.clock")

-- Launcher
init.launcher = require("widgets.launcher")
init.weather  = require("widgets.weather")

-- Custom widgets
init.layouticon = require("widgets.layout").layouticon
init.layoutwidget = require("widgets.layout").layoutwidget
init.update = require("widgets.functions.update")

local mem_command = "free | awk '/Mem/ {print $3 '/' $2}"
local memory = command(mem_command)

-- Create mem text widget
init.mem_text = lain.widget.mem({
    settings = function()
        widget:set_markup("<span foreground='" .. theme.fg_mem.. "' font='" .. font.mem .. "'>" .. mem_now.used .. "/" .. mem_now.total .. "</span>")
    end
})


return init









