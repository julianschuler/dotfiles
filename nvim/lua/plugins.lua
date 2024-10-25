return {
  -- Disable unused plugins
  { "AstroNvim/astrotheme",         enabled = false },
  { "akinsho/toggleterm.nvim",      enabled = false },
  { "goolord/alpha-nvim",           enabled = false },
  { "max397574/better-escape.nvim", enabled = false },

  -- Change statusline components and disable tabline and winbar
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },
        status.component.mode {
          mode_text = { padding = { left = 1, right = 1 } },
          hl = { bold = true },
        },
        -- Add all the other components for the statusline
        status.component.git_branch(),
        status.component.file_info { filename = {}, filetype = false },
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav {
          percentage = { padding = { left = 2, right = 1 } },
          scrollbar = false,
        },
      }
      opts.tabline = nil
      opts.winbar = nil
      return opts
    end,
  },
  -- Close telescope picker with escape and exclude .git/ subfolder
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults.mappings.i = {
        ["<esc>"] = require("telescope.actions").close,
      }
      opts.defaults.file_ignore_patterns = { ".git/" }
      return opts
    end,
  },

  -- Color scheme
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    opts = function(_, opts)
      local palette = require("gruvbox").palette
      opts = {
        overrides = {
          StatusLine = {
            bg = palette.dark1,
            fg = palette.light0,
            reverse = false,
          },
          GitSignsChange = { link = "GruvboxOrangeSign" },
          Directory = { fg = "#729fcf" },
        },
      }
      return opts
    end,
  },
  -- Surround
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup() end,
  },
  -- Improved movement
  {
    "ggandor/leap.nvim",
    event = "UIEnter",
    config = function()
      local leap = require "leap"

      leap.setup {
        safe_labels = {
          "a",
          "i",
          "e",
          "t",
          "n",
          "s",
          "o",
          "u",
          "g",
          "h",
          "f",
          "j",
          "ü",
          "b",
          "ä",
          "q",
          "ö",
        },
        labels = {
          "a",
          "e",
          "i",
          "t",
          "n",
          "s",
          "o",
          "u",
          "g",
          "h",
          "c",
          "r",
          "l",
          "y",
          "d",
          "w",
          "m",
          "k",
          "f",
          "j",
          "ü",
          "b",
          "ä",
          "q",
          "ö",
        },
      }
      leap.set_default_keymaps()
    end,
  },
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}
