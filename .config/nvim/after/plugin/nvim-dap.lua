local dap, dapui = require 'dap', require 'dapui'

-- Configure the plugins
require('dap-python').setup()
require('dapui').setup()

-- Define keymaps for nvim-dap
vim.keymap.set('n', '<Leader>bp', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<Leader>bc', dap.continue, {})

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

