-- Space set as Leader Key
vim.g.mapleader = " "

-- Built in File explorer in neovim
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Source a file
vim.keymap.set("n", "<leader>hs", vim.cmd.so)
