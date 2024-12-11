local map = vim.keymap.set
local defaults = { noremap = true, silent = true }

map("n", "<esc><esc>", ":noh<cr>", defaults)
