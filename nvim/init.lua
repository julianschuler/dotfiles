-- Bootstrapping lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Setup AstroNvim and plugins
require("lazy").setup {
  {
    "AstroNvim/AstroNvim",
    version = "^4",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = " ",
    },
  },
  {
    "AstroNvim/astrocore",
    opts = {
      options = require "options",
      mappings = require "mappings",
    },
  },
  {
    "AstroNvim/astrolsp",
    opts = require "lsp",
  },
  {
    "AstroNvim/astroui",
    opts = {
      colorscheme = "gruvbox",
    },
  },
  { import = "plugins" },
}
require "polish"
