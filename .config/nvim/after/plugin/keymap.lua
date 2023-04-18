vim.keymap.set("n", "<leader>.", vim.cmd.Vifm)
vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope file_browser<CR>', { noremap = true, silent = true })


-- Quickly move between windows
vim.keymap.set("n", "<leader>bn", vim.cmd.BufferNext)
vim.keymap.set("n", "<leader>bp", vim.cmd.BufferPrevious)
vim.keymap.set("n", "<leader>bk", vim.cmd.BufferClose)
vim.keymap.set("n", "<Leader>tn", vim.cmd.tabnew)
vim.keymap.set("n", "<Leader>td", vim.cmd.tabclose)
vim.keymap.set("n", "<Leader>ch", vim.cmd.HighlightColorsToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "gt", vim.cmd.BufferNext)
vim.keymap.set("n", "gT", vim.cmd.BufferPrevious)
vim.api.nvim_set_keymap('n', '<Leader>gp', ':Git push<CR>', { noremap = true, silent = true })

-- Neotree keybindings
vim.keymap.set("n", "<F5>", vim.cmd.NeoTreeFocusToggle)
vim.keymap.set("n", "<F6>", vim.cmd.Neotree)
vim.keymap.set("n", "<F4>", vim.cmd.NERDTreeToggle)
vim.keymap.set("n", "<Leader>ft", vim.cmd.NeoTreeFocusToggle)
vim.api.nvim_set_keymap('n', '<Leader>ns', ':Neotree ~/myrepos/setup<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>na', ':Neotree ~/myrepos/azla<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>nd', ':Neotree ~/myrepos/dotfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ng', ':Neotree ~/myrepos<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>nc', ':Neotree ~/.config<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>nn', ':Neotree ~/.config/nvim<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>n.', ':Neotree .<CR>', { noremap = true, silent = true })

-- Update plugins using packer
vim.keymap.set("n", "<leader>hr", vim.cmd.PackerSync)

-- Keybindings for Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end)
vim.keymap.set("n", "<C-5>", function() ui.nav_file(5) end)
vim.keymap.set("n", "<C-6>", function() ui.nav_file(6) end)
vim.keymap.set("n", "<C-7>", function() ui.nav_file(7) end)
vim.keymap.set("n", "<C-8>", function() ui.nav_file(8) end)
vim.keymap.set("n", "<C-9>", function() ui.nav_file(9) end)

-- Keybinding to save as sudo
vim.keymap.set('n', '<Leader>fs', vim.cmd.SudaWrite)

-- Keybinding to open UndoTree
vim.keymap.set("n", "<Leader>u", vim.cmd.UndotreeToggle)

-- Jump back to your dashboard
vim.keymap.set('n', '<Leader>d', vim.cmd.Dashboard)

-- Keybindings for telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<Leader>ht', builtin.colorscheme, {})
vim.keymap.set('n', '<Leader>ps', function()
builtin.grep_string({ search = vim.fn.input("Grep >") } );

end)

require("telescope").load_extension("recent_files")

vim.api.nvim_set_keymap("n", "<Leader>fr",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true})

require("telescope").load_extension "file_browser"
