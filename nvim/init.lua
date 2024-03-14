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
})

-- Keymappings
local map = vim.keymap.set
local defaults = { noremap = true, silent = true }

map('n', '<esc><esc>', ':noh<cr>', defaults)

