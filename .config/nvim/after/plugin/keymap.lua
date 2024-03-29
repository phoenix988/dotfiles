local v = vim

-- Yazi
v.api.nvim_set_keymap('n', '<leader>.', ':Yazi<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<leader>fm', ':Yazi<CR>', { noremap = true, silent = true })

-- Quickly move between buffers
v.api.nvim_set_keymap('n', '<leader>bn', ':BufferNext<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<leader>bp', ':BufferPrevious<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<leader>bk', ':BufferClose<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<leader>bl', ':Telescope buffers<CR>', { noremap = true, silent = true })

-- Manage tabs
v.api.nvim_set_keymap('n', '<Leader>tn', ':tabnew<CR>', { noremap = true, silent = true, desc = 'New Tab' })
v.api.nvim_set_keymap('n', '<Leader>td', ':tabclose<CR>', { noremap = true, silent = true, desc = 'Close Tab' })
v.api.nvim_set_keymap('n', '<Leader>ch', ':HighlightColors on<CR>',
  { noremap = true, silent = true, desc = 'Toggle Hex Colors on/off' })
v.api.nvim_set_keymap('n', 'gt', ':BufferNext<CR>', { noremap = true, silent = true, desc = 'Next Buffer' })
v.api.nvim_set_keymap('n', 'gT', ':BufferPrevious<CR>', { noremap = true, silent = true, desc = 'Previous Buffer' })

-- Tab between splits
v.api.nvim_set_keymap('n', '<Tab>', '<C-W>w', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<S-Tab>', '<C-W>W', { noremap = true, silent = true })

-- Git commands
v.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<leader>gg', ':Neogit<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<leader>gs', ':Gitsigns preview_hunk<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>gp', ':Git push<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>gP', ':Git pull<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>gd', ':Gdiff %<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<leader>gl', ':LazyGit<CR>', { noremap = true, silent = true })

-- Neotree keybindings
v.api.nvim_set_keymap('n', '<F5>', ':Neotree toggle<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>nt', ':Neotree toggle<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>nf', ':Neotree float<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>ns', ':Neotree ~/myrepos/setup<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>na', ':Neotree ~/myrepos/azla<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>nd', ':Neotree ~/myrepos/dotfiles<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>ng', ':Neotree ~/myrepos<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>nc', ':Neotree ~/.config<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>nn', ':Neotree ~/.config/nvim<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>nh', ':Neotree ~<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>n.', ':Neotree .<CR>', { noremap = true, silent = true })

-- Oil
v.api.nvim_set_keymap('n', '<Leader>fo', ':Oil<CR>', { noremap = true, silent = true, desc = 'Oil file tree' })

-- Update plugins using lazy
v.api.nvim_set_keymap('n', '<Leader>hr', ':Lazy<CR>', { noremap = true, silent = true, desc = 'Lazy Plugin Menu' })

-- Terminal
v.api.nvim_set_keymap('n', '<Leader>tt', ':terminal<CR>', { noremap = true, silent = true, desc = 'Open Terminal' })
v.api.nvim_set_keymap('n', '<Leader>ok', ':terminal<CR>', { noremap = true, silent = true, desc = 'Open Terminal' })

-- Keybindings for Harpoon
local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'

v.api.nvim_set_keymap('n', '<Leader>h1', ':ToHarpoon 1<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>h2', ':ToHarpoon 2<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>h3', ':ToHarpoon 3<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>h4', ':ToHarpoon 4<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>h5', ':ToHarpoon 5<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>h6', ':ToHarpoon 6<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>h7', ':ToHarpoon 7<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>h8', ':ToHarpoon 8<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>h9', ':ToHarpoon 9<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>p1', ':ToHarpoon 1<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>p2', ':ToHarpoon 2<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>p3', ':ToHarpoon 3<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>p4', ':ToHarpoon 4<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>p5', ':ToHarpoon 5<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>p6', ':ToHarpoon 6<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>p7', ':ToHarpoon 7<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>p8', ':ToHarpoon 8<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<Leader>p9', ':ToHarpoon 9<CR>', { noremap = true, silent = true })
v.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon Add file' })
v.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = 'Harpoon Quick File Menu' })
v.keymap.set('n', '<leader>pa', mark.add_file, { desc = 'Harpoon Add file' })
v.keymap.set('n', '<leader>pl', ui.toggle_quick_menu, { desc = 'Harpoon Quick File Menu' })
--v.api.nvim_set_keymap('n', '<C-h>', ':ToHarpoon 1<CR>', { noremap = true, silent = true })
--v.api.nvim_set_keymap('n', '<C-j>', ':ToHarpoon 2<CR>', { noremap = true, silent = true })
--v.api.nvim_set_keymap('n', '<C-k>', ':ToHarpoon 3<CR>', { noremap = true, silent = true })
--v.api.nvim_set_keymap('n', '<C-l>', ':ToHarpoon 4<CR>', { noremap = true, silent = true })

-- Keybinding to open UndoTree
v.api.nvim_set_keymap('n', '<Leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })

-- Keybinding to save as sudo
v.api.nvim_set_keymap('n', '<Leader>fs', ':SudaWrite<CR>', { noremap = true, silent = true, desc = 'Save as sudo' })

-- Keybindings for telescope
local builtin = require 'telescope.builtin'
require('telescope').load_extension 'recent_files'
require('telescope').load_extension 'file_browser'
v.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>',
  { noremap = true, silent = true, desc = 'Find Files' })
v.api.nvim_set_keymap('n', '<Leader>gf', ':Telescope git_files<CR>',
  { noremap = true, silent = true, desc = 'Git Files' })
v.api.nvim_set_keymap('n', '<Leader>ft', ':Telescope git_files<CR>',
  { noremap = true, silent = true, desc = 'Git Files' })
v.api.nvim_set_keymap('n', '<Leader>ht', ':Telescope colorscheme<CR>',
  { noremap = true, silent = true, desc = 'Colorschemes' })
v.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope file_browser<CR>',
  { noremap = true, silent = true, desc = 'File Browser' })
v.api.nvim_set_keymap('n', '<Leader>fG', ':Telescope live_grep<CR>',
  { noremap = true, silent = true, desc = 'Live Grep for string' })
v.keymap.set('n', '<Leader>fg', function()
  builtin.grep_string { search = v.fn.input 'Grep >' }
end)

v.api.nvim_set_keymap(
  'n',
  '<Leader>fr',
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  { noremap = true, silent = true, desc = 'Recent Files' }
)

-- ORGMODE Tangle
v.api.nvim_set_keymap('n', '<Leader>oT', ':OrgTangle<CR>',
  { noremap = true, silent = true, desc = 'Tangle Org Document' })

-- Terminal mode
v.api.nvim_set_keymap('t', '<Esc>l', '<C-\\><C-n>', { noremap = true })

-- Session
-- List all your sessions
v.keymap.set('n', '<Leader>sm', require('auto-session.session-lens').search_session, {
  noremap = true,
})

-- None-ls format
v.keymap.set('n', '<leader>fF', vim.lsp.buf.format, {})
v.api.nvim_set_keymap('n', '<Leader>hm', ':Mason<CR>', { noremap = true, silent = true, desc = 'Mason Meny' })

-- Co-pilot
v.api.nvim_set_keymap('i', '<C-/>', 'copilot#Accept(“<CR>”)', { expr = true, silent = true })

-- Tmux navigation
v.api.nvim_set_keymap('n', '<C-h', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<C-l', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<C-j', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
v.api.nvim_set_keymap('n', '<C-k', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })

-- Silicon
v.api.nvim_set_keymap('v', '<Leader>S', ':Silicon<CR>', { noremap = true, silent = true })
