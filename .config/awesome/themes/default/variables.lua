-- Files to set global variables 
-- So I can easily use the same settings for multiple widgets
-- To make it easier to manager
local lain  = require("lain")
local awful = require("awful")
local theme = require("activate_theme")


local var = {}

if theme.chosen_widget == "laptop" then

  var.bar_size       = {2, 7, 7, 7}
  var.bar_width      = 70
  var.bar_width_vol  = 90
  var.bar_width_temp = 50
else
  var.bar_size       = {2, 7, 7, 7}
  var.bar_width      = 100
  var.bar_width_vol  = 120
  var.bar_width_temp = 60

end

var.green        = "#9ECE6A"
var.red          = "#F7768E"
var.terminal     = "kitty"
var.markup       = lain.util.markup

-- Global tasklist settings
var.tasklist_font             = "JetBrains Mono Nerd 16"
var.tasklist_plain_task_name  = true

-- Command to check for kernel version
var.kernel_command = "uname -r"

-- Command to check for updates
var.update_command = "bash -c 'paru -Syy &> /dev/null && paru -Qu 2> /dev/null | wc -l'"

-- Set Tagicons
-- Example of icons you can use
-- local names = ["", "", "", "", "", "", "", "", "ﭮ", "", "", "﨣", "F1", "F2", "F3", "F4", "F5"]
-- local names = { " ", " ", " ", " ", " ", " ", " ", " ", " "  }
var.names = { "", " ", " ", "󰓓 ", " ", "󰝚 ", "󰙯 ", " ", " " }
l = awful.layout.suit
var.layouts = { l.max, l.tile.right, l.tile.right, l.max, l.tile.right, l.tile.right, l.tile.right, l.floating, l.floating, }

return var
