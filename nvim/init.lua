local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
  {
    "ggandor/leap.nvim",
    config = function ()
        require('leap').create_default_mappings()
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  }
})

-- Keymappings
local map = vim.keymap.set
local defaults = { noremap = true, silent = true }

map('n', '<esc><esc>', ':noh<cr>', defaults)

map('n', '<C-h>', '<C-w>h', defaults)
map('n', '<C-j>', '<C-w>j', defaults)
map('n', '<C-k>', '<C-w>k', defaults)
map('n', '<C-l>', '<C-w>l', defaults)

-- Options
vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object

vim.opt.ignorecase = true
vim.opt.smartcase = true
