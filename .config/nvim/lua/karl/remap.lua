vim.g.mapleader = " "
vim.keymap.set("n", "<leader>.", vim.cmd.Vifm)
vim.keymap.set("n", "<leader>hr", vim.cmd.PackerSync)
vim.keymap.set("n", "<leader>hs", vim.cmd.so)
vim.keymap.set("n", "<leader>bn", vim.cmd.BufferNext)
vim.keymap.set("n", "<leader>bp", vim.cmd.BufferPrevious)
vim.keymap.set("n", "<leader>bk", vim.cmd.BufferClose)
vim.keymap.set("n", "gt", vim.cmd.BufferNext)
vim.keymap.set("n", "gT", vim.cmd.BufferPrevious)
