-- Imports all widgets so its available to use
local init = {}

-- imports kernelwidgets
require("widgets.kernelwidget")

-- Imports weather widget
init.wea = require("widgets.weather")

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

init.updatemodule = require("widgets.updatewidget")
init.updatewidget = init.updatemodule.updatewidget
init.updateicon   = init.updatemodule.updateicon

init.launcher     = require("widgets.launcher")

return init









