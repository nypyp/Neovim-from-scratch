local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- LocalLeader 用反斜杠，供 CodeCompanion 官方 <LocalLeader>a 等键位使用

require("lazy").setup("plugins")

require "user.options"
require "user.keymaps"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
