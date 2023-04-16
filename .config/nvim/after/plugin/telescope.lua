local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<Leader>ht', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>ps', function()
builtin.grep_string({ search = vim.fn.input("Grep >") } );


end)

require("telescope").load_extension("recent_files")

vim.api.nvim_set_keymap("n", "<Leader>fr",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true})

require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap(
  "n",
  "<space>o-",
  ":Telescope file_browser",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser",
  { noremap = true }
)
