local mark = require("harpoon.mark")
local ui   = require("harpoon.ui")

function to_harpoon(arg)
   ui.nav_file(arg) 
end

vim.cmd("command! -nargs=1 ToHarpoon lua to_harpoon(tonumber(<f-args>))")
