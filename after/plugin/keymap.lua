vim.keymap.set("n", "<leader>.", vim.cmd.Vifm)

-- Quickly move between windows
vim.api.nvim_set_keymap("n", "<leader>bn", ':BufferNext' ,{ noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bp", ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bk", ':BufferClose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>tn", ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>td", ':tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>ch", ':HighlightColorsToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gt", ':BufferNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gT", ':BufferPrevious<CR>', { noremap = true, silent = true })

-- Git commands
vim.api.nvim_set_keymap("n", "<leader>gs", ':Git<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gg", ':Git<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gp', ':Git push<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gP', ':Git pull<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gd', ':Gdiff %<CR>', { noremap = true, silent = true })

-- Neotree keybindings
vim.api.nvim_set_keymap("n", "<F4>", ':NvimTreeFocus<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F5>", ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>ft", ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>nf", ':NeoTreeFloat<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ns', ':Neotree ~/myrepos/setup<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>na', ':Neotree ~/myrepos/azla<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>nd', ':Neotree ~/myrepos/dotfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ng', ':Neotree ~/myrepos<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>nc', ':Neotree ~/.config<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>nn', ':Neotree ~/.config/nvim<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>nh', ':Neotree ~<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>n.', ':Neotree .<CR>', { noremap = true, silent = true })

-- Update plugins using lazy
vim.api.nvim_set_keymap('n', '<Leader>hr', ':Lazy<CR>', { noremap = true, silent = true })

-- Terminal
vim.api.nvim_set_keymap('n', '<Leader>tt', ':terminal<CR>', { noremap = true, silent = true })

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
vim.api.nvim_set_keymap('n', '<Leader>fs', ':SudaWrite<CR>', { noremap = true, silent = true })

-- Keybinding to open UndoTree
vim.api.nvim_set_keymap("n", "<Leader>u", ':UndotreeToggle<CR>', { noremap = true, silent = true })

-- Jump back to your dashboard
vim.api.nvim_set_keymap('n', '<Leader>d', ':Dashboard<CR>', { noremap = true, silent = true })

-- Keybindings for telescope
local builtin = require('telescope.builtin')
vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gf', ':Telescope git_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ht', ':Telescope colorscheme<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope file_browser<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>fg', function()
builtin.grep_string({ search = vim.fn.input("Grep >") } );

end)

require("telescope").load_extension("recent_files")

vim.api.nvim_set_keymap("n", "<Leader>fr",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true})

require("telescope").load_extension "file_browser"

-- ORGMODE Tangle
vim.api.nvim_set_keymap('n', '<Leader>oT', ':OrgTangle<CR>', { noremap = true, silent = true })
