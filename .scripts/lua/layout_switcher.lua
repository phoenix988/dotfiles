#!/usr/bin/env lua
-- Script to change the keyboard layot üritten in lua
local io = require("io")
local os = require("os")

local se,us,az = "se","us","az"

-- function to switch to switch the layout
local function layout_switcher(...)
     local layouts = {}
     
     -- Makes the table
     for i, arg in ipairs({...}) do
         table.insert(layouts, arg)
         last = i
     end
     
     local bash_command = "setxkbmap -query | grep layout | awk '{print $NF}'"
     local file = io.popen(bash_command)
     local output = file:read("*a")
	 local output = string.gsub(output, "%s", "")
     for key, value in pairs(layouts) do
         if value == output then
             choice = key
         end
     end
     
     if choice == nil then
          choice = 2
     end
     
     if choice == last then
        choice = 1
     else 
        choice = choice + 1
     end    
        
     local command = "setxkbmap " .. layouts[choice]

     return command
end


local switch = layout_switcher(se, us, az)

os.execute(switch)


