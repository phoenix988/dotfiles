-- Built in File explorer in neovim
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex)

-- Source a file
vim.keymap.set("n", "<leader>hs", vim.cmd.so)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>",  "<C-d>zz")
vim.keymap.set("n", "<C-u>",  "<C-u>zz")

vim.keymap.set("x", "<leader>p",  "\"_dp")

vim.keymap.set("n", "<leader>d",  "\"_d")
vim.keymap.set("v", "<leader>d",  "\"_d")

vim.keymap.set("n", "<C-f>",  "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>sc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Save/load Session
vim.api.nvim_set_keymap('n', '<Leader>ss', ':SaveSession<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>sl', ':LoadSession<CR>', { noremap = true, silent = true })



