local function git_co_authors()
  -- Get all author names and keep unique ones
  local authors = {}
  local seen_authors = {}
  local all_authors =
    vim.api.nvim_call_function("system", { 'git log --format="%aN <%aE>"' })
  for _, author in ipairs(vim.split(all_authors, "\n", {})) do
    if not seen_authors[author] then
      seen_authors[author] = true
      authors[#authors + 1] = author
    end
  end
  -- Select co-author using telescope and insert it at current line
  vim.ui.select(authors, { prompt = "Co-Authors" }, function(author, _)
    if author then
      local msg = "Co-authored-by: " .. author
      local line = vim.api.nvim_win_get_cursor(0)[1]
      vim.api.nvim_buf_set_lines(0, line, line, true, { msg })
      vim.api.nvim_win_set_cursor(0, { line + 1, 0 })
    end
  end)
end

local config = {
  -- Configure AstroNvim updates
  updater = {
    version = "latest",
    channel = "stable",
    skip_prompts = true,
    show_changelog = true,
  },

  -- Set vim options
  options = {
    opt = {
      gdefault = true,
      linebreak = true,
      relativenumber = false,
      showtabline = 0,
      signcolumn = "auto",
      modeline = false,
      wrap = true,
    },
    g = {
      mapleader = " ",
      maplocalleader = " ",
      mkdp_page_title = "${name}",
      vimtex_view_method = "zathura",
      vimtex_compiler_latexmk = { build_dir = "/tmp" },
    },
  },

  -- Set colorscheme
  colorscheme = "gruvbox",

  -- LSP settings
  lsp = {
    formatting = {
      disabled = {
        "lua_ls",
      },
    },
    setup_handlers = {
      rust_analyzer = function(_, opts)
        require("rust-tools").setup { server = opts }
      end,
    },
    mappings = {
      n = {
        ["<leader>a"] = {
          function() vim.lsp.buf.code_action() end,
          desc = "LSP code action",
        },
      },
    },
  },

  -- Configure plugins
  plugins = {
    -- Disable unused plugins
    { "AstroNvim/astrotheme", enabled = false },
    { "akinsho/toggleterm.nvim", enabled = false },
    { "goolord/alpha-nvim", enabled = false },
    { "max397574/better-escape.nvim", enabled = false },

    -- Set completion source priorities
    {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        local cmp = require "cmp"
        opts.sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }
        return opts
      end,
    },
    -- Change statusline components and disable tabline and winbar
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require "astronvim.utils.status"
        opts.statusline = {
          hl = { fg = "fg", bg = "bg" },
          status.component.mode {
            mode_text = { padding = { left = 1, right = 1 } },
            hl = { bold = true },
          },
          -- Add all the other components for the statusline
          status.component.git_branch(),
          status.component.file_info(),
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
    -- Change mappings for commenting above, below and at end of line
    {
      "numToStr/Comment.nvim",
      opts = {
        extra = {
          above = "gco",
          below = "gce",
          eol = "gcw",
        },
      },
    },
    -- Close telescope picker with escape
    {
      "nvim-telescope/telescope.nvim",
      opts = function(_, opts)
        opts.defaults.mappings.i = {
          ["<esc>"] = require("telescope.actions").close,
        }
        return opts
      end,
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
    -- Color scheme
    {
      "ellisonleao/gruvbox.nvim",
      name = "gruvbox",
      opts = function(_, opts)
        local C = require("gruvbox.palette").colors
        opts = {
          overrides = {
            StatusLine = { bg = C.dark1, fg = C.light0, reverse = false },
            GitSignsChange = { link = "GruvboxOrangeSign" },
            Directory = { fg = "#729fcf" },
          },
        }
        return opts
      end,
    },
    -- Rust tools integration
    {
      "simrat39/rust-tools.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = { "rust_analyzer" },
        },
      },
    },
    -- Smooth scrolling
    {
      "declancm/cinnamon.nvim",
      event = "UIEnter",
      config = function() require("cinnamon").setup() end,
    },
    -- LaTeX and markdown integrations
    { "lervag/vimtex", ft = { "tex", "bib" }, cmd = "VimtexInverseSearch" },
    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      build = function() vim.fn["mkdp#util#install"]() end,
    },
  },

  -- The following keybindings are adapted to a modified VOU layout
  -- and mostly won't make sense on a default QWERTY/QWERTZ keyboard
  mappings = {
    -- Normal mode mappings
    n = {
      -- Disable unused default bindings
      ["<leader>h"] = false,
      ["<leader>w"] = false,
      ["<leader>/"] = false,
      ["<leader>b"] = false,
      ["<leader>bb"] = false,
      ["<leader>bd"] = false,
      ["<leader>b\\"] = false,
      ["<leader>b|"] = false,

      -- Replacing and redo
      ["ü"] = { "r", desc = "Replace character" },
      ["ä"] = { "<c-r>", desc = "Redo" },

      -- Switching to insert mode
      ["r"] = { "<cmd>noh<cr>i", desc = "Insert before cursor" },
      ["w"] = { "<cmd>noh<cr>A", desc = "Append at end of line" },
      ["l"] = { "<cmd>noh<cr>o", desc = "Begin new line below" },
      ["L"] = { "<cmd>noh<cr>O", desc = "Begin new line above" },

      -- Movement
      ["A"] = { "b", desc = "Move a word backwards" },
      ["I"] = { "w", desc = "Move a word forwards" },
      ["O"] = {
        "<cmd>lua Scroll('<c-u>', 1, 1)<cr>",
        desc = "Scroll up half a page",
      },
      ["E"] = {
        "<cmd>lua Scroll('<c-d>', 1, 1)<cr>",
        desc = "Scroll up half a page",
      },
      ["a"] = { "h", desc = "Move left" },
      ["e"] = { "gj", desc = "Move down" },
      ["o"] = { "gk", desc = "Move up" },
      ["i"] = { "l", desc = "Move right" },
      ["<c-a>"] = {
        "<cmd>lua require('smart-splits').move_cursor_left()<cr>",
        desc = "Go to the left window",
      },
      ["<c-e>"] = {
        "<cmd>lua require('smart-splits').move_cursor_down()<cr>",
        desc = "Go to the down window",
      },
      ["<c-o>"] = {
        "<cmd>lua require('smart-splits').move_cursor_up()<cr>",
        desc = "Go to the up window",
      },
      ["<c-i>"] = {
        "<cmd>lua require('smart-splits').move_cursor_right()<cr>",
        desc = "Go to the right window",
      },

      -- Macros
      ["Q"] = { "q", desc = "Record macro" },

      -- Saving and quitting
      ["<leader>s"] = { "<cmd>update<cr>", desc = "Save" },
      ["q"] = { "<cmd>confirm q<cr>", desc = "Quit" },
      ["<leader>q"] = { "<cmd>qa<cr>", desc = "Quit all" },

      -- Searching and substituting
      ["j"] = { "/", desc = "Search" },
      ["h"] = { "*", desc = "Search word under cursor" },
      ["H"] = { ":%s/", desc = "Substitute" },
      ["<leader>j"] = { "<cmd>noh<cr>", desc = "Disable search highlight" },

      -- Jumping and command-line mode
      ["k"] = { "'", desc = "Jump to mark" },
      ["kk"] = { "''", desc = "Jump to position before last jump" },
      ["_"] = { ":", desc = "Enter command-line mode" },

      -- Yanking
      ["Y"] = { "y$", desc = "Yank to end of line" },
      ["<leader>y"] = { "<cmd>%y<cr>", desc = "Yank buffer" },

      -- Spell checking
      ["<leader>z"] = {
        "<cmd>setl invspell<cr>",
        desc = "Toggle spell checking",
      },

      -- Adding git co-authors to commit
      ["<leader>ga"] = {
        function() git_co_authors() end,
        desc = "Add git co-authors",
      },

      -- Telescope bindings
      ["t"] = { name = "Search with telescope" },
      ["b"] = {
        "<cmd>Telescope buffers sort_mru=true ignore_current_buffer=true<cr>",
        desc = "Switch between buffers",
      },
      ["f"] = { "<cmd>Telescope git_files<cr>", desc = "Search git files" },
      ["F"] = { "<cmd>Telescope find_files<cr>", desc = "Search files" },
      ["J"] = { "<cmd>Telescope live_grep<cr>", desc = "Search word in files" },
      ["T"] = { "<cmd>Telescope<cr>", desc = "Search Telescope builtins" },
      ["tc"] = { "<cmd>Telescope commands<cr>", desc = "Search commands" },
      ["td"] = { "<cmd>Telescope diagnostics<cr>", desc = "Search diagnostics" },
      ["tf"] = { "<cmd>Telescope oldfiles<cr>", desc = "Search file history" },
      ["th"] = { "<cmd>Telescope help_tags<cr>", desc = "Search help" },
      ["ti"] = {
        "<cmd>Telescope lsp_implementations<cr>",
        desc = "Search implementations",
      },
      ["tj"] = {
        "<cmd>Telescope search_history<cr>",
        desc = "Search search history",
      },
      ["tk"] = { "<cmd>Telescope jumplist<cr>", desc = "Search jumplist" },
      ["tm"] = { "<cmd>Telescope man_pages<cr>", desc = "Search man" },
      ["tn"] = {
        "<cmd>Telescope lsp_definitions<cr>",
        desc = "Search definitions",
      },
      ["tr"] = {
        "<cmd>Telescope lsp_references<cr>",
        desc = "Search references",
      },
      ["ts"] = {
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Search document symbols",
      },
      ["tS"] = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "Search workspace symbols",
      },
      ["tt"] = {
        "<cmd>Telescope lsp_type_definitions<cr>",
        desc = "Search definitions",
      },
      ["tz"] = {
        "<cmd>Telescope spell_suggest<cr>",
        desc = "Search spell suggestions",
      },
      ["t_"] = {
        "<cmd>Telescope command_history<cr>",
        desc = "Search command history",
      },
    },

    -- Visual mode mappings
    v = {
      -- Replacing
      ["ü"] = { "r", desc = "Replace character" },

      -- Movement
      ["A"] = { "b", desc = "Move a word backwards" },
      ["I"] = { "w", desc = "Move a word forwards" },
      ["O"] = {
        "<cmd>lua Scroll('<c-u>', 1, 1)<cr>",
        desc = "Scroll up half a page",
      },
      ["E"] = {
        "<cmd>lua Scroll('<c-d>', 1, 1)<cr>",
        desc = "Scroll up half a page",
      },
      ["a"] = { "h", desc = "Move left" },
      ["e"] = { "gj", desc = "Move down" },
      ["o"] = { "gk", desc = "Move up" },
      ["i"] = { "l", desc = "Move right" },

      -- Changing the selection area
      ["l"] = { "o", desc = "Go to other end of selection" },
      ["L"] = { "O", desc = "Go to other end of selection or other corner" },

      -- Switching to insert mode
      ["r"] = { "<cmd>noh<cr>I", desc = "Insert before cursor" },
      ["w"] = { "<cmd>noh<cr>A", desc = "Append at end of line" },

      -- Searching and substituting
      ["j"] = { "/", desc = "Search" },
      ["h"] = { '"hy/<c-r>h<cr>', desc = "Search for selection" },
      ["H"] = { ":s/", desc = "Substitute within selection" },

      -- Jumping and command-line mode
      ["k"] = { "'", desc = "Jump to mark" },
      ["kk"] = { "''", desc = "Jump to position before last jump" },
      ["_"] = { ":", desc = "Enter command-line mode" },
    },

    -- Insert mode mappings
    i = {
      -- Deleting last word using control-backspace
      ["<c-h>"] = { "<c-w>", desc = "Delete last word" },
    },
  },

  -- Set up autocommands and custom highlight groups
  polish = function()
    -- Add additional commands for LaTeX and markdown files
    vim.api.nvim_create_augroup("bufcheck", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = "bufcheck",
      pattern = "tex",
      command = "nnoremap <leader>v <cmd>VimtexView<cr>",
    })
    vim.api.nvim_create_autocmd("FileType", {
      group = "bufcheck",
      pattern = "markdown",
      command = "nnoremap <leader>v <cmd>MarkdownPreviewToggle<cr>",
    })

    -- Reset cursor after exiting
    vim.api.nvim_create_augroup("change_cursor", { clear = true })
    vim.api.nvim_create_autocmd("VimLeave", {
      group = "change_cursor",
      command = "set guicursor=a:ver90",
    })

    -- Set highlight groups for leap
    vim.api.nvim_set_hl(0, "LeapLabelPrimary", { link = "GruvboxOrangeBold" })
    vim.api.nvim_set_hl(0, "LeapLabelSecondary", { link = "GruvboxYellowBold" })

    -- Fix mappings to special characters by defining them again explicitely
    vim.keymap.set("n", "j", "/")
    vim.keymap.set("v", "j", "/")
    vim.keymap.set("n", "k", "'")
  end,
}

return config
