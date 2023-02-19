local function git_co_authors()
  -- Get all author names and keep unique ones
  local authors = {}
  local seen_authors = {}
  local all_authors = vim.api.nvim_call_function("system", { 'git log --format="%aN <%aE>"' })
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
    remote = "origin",
    channel = "stable",
    version = "latest",
    branch = "main",
    commit = nil,
    pin_plugins = nil,
    skip_prompts = true,
    show_changelog = true,
  },

  -- Set colorscheme
  colorscheme = "gruvbox",

  -- Set vim options
  options = {
    opt = {
      cmdheight = 1,
      gdefault = true,
      linebreak = true,
      relativenumber = false,
      showtabline = 1,
      signcolumn = "auto",
      modeline = false,
      wrap = true,
    },
    g = {
      mapleader = " ",
      maplocalleader = " ",
      vimtex_view_method = "zathura",
      vimtex_compiler_latexmk = { build_dir = "/tmp" },
    },
  },

  -- Configure plugins
  plugins = {
    -- Add plugins
    init = {
      -- Color sheme
      ["ellisonleao/gruvbox.nvim"] = {
        as = "gruvbox",
        config = function()
          local C = require("gruvbox.palette").colors
          require("gruvbox").setup {
            overrides = {
              StatusLine = { bg = C.dark1, fg = C.light0, reverse = false },
              GitSignsChange = { link = "GruvboxOrangeSign" },
              Directory = { fg = "#729fcf" },
            },
          }
        end,
      },
      -- Improved movement
      ["ggandor/leap.nvim"] = {
        config = function()
          local leap = require "leap"

          leap.setup {
            safe_labels = { "a", "i", "e", "t", "n", "s", "o", "u", "g", "h", "f", "j", "ü", "b", "ä", "q", "ö" },
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
      -- Rust tools
      ["simrat39/rust-tools.nvim"] = {
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          require("rust-tools").setup {
            server = astronvim.lsp.server_settings "rust_analyzer",
          }
        end,
      },
      -- Smooth scrolling
      ["declancm/cinnamon.nvim"] = { config = function() require("cinnamon").setup() end },
      -- LaTeX and markdown integrations
      ["lervag/vimtex"] = {},
      ["iamcco/markdown-preview.nvim"] = { run = function() vim.fn["mkdp#util#install"]() end },
      -- Disable unused plugins
      ["akinsho/bufferline.nvim"] = { disable = true },
      ["goolord/alpha-nvim"] = { disable = true },
      ["max397574/better-escape.nvim"] = { disable = true },
    },
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      config.sources = {
        -- Set linters
        null_ls.builtins.diagnostics.flake8,
        -- Set formatters
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua,
      }
      return config
    end,
    treesitter = {
      ensure_installed = { "lua" },
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },
    heirline = function(config)
      -- The first element of the default configuration table is the statusline
      config[1] = {
        -- Set the fg/bg of the statusline
        hl = { fg = "fg", bg = "bg" },
        -- When adding the mode component, enable the mode text with padding to the left/right of it
        astronvim.status.component.mode {
          mode_text = { padding = { left = 1, right = 1 } },
          hl = { fg = "bg", bold = true },
        },
        -- Add all the other components for the statusline
        astronvim.status.component.git_branch(),
        astronvim.status.component.file_info(),
        astronvim.status.component.git_diff(),
        astronvim.status.component.diagnostics(),
        astronvim.status.component.fill(),
        astronvim.status.component.lsp(),
        astronvim.status.component.treesitter(),
        astronvim.status.component.nav { percentage = { padding = { left = 1, right = 1 } }, scrollbar = false },
      }
      config[2] = nil
      -- Return the final configuration table
      return config
    end,
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- CMP Source Priorities
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      buffer = 750,
      luasnip = 500,
      path = 250,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- The following keybindings are adapted to a modified VOU layout
  -- and mostly won't make sense on a default QWERTY/QWERTZ keyboard
  mappings = {
    -- Normal mode mappings
    n = {
      -- Disable default bindings
      ["<leader>c"] = false,
      ["<leader>e"] = false,
      ["<leader>h"] = false,
      ["<leader>o"] = false,
      ["<leader>w"] = false,
      ["<leader>/"] = false,
      ["<leader>fb"] = false,
      ["<leader>fc"] = false,
      ["<leader>ff"] = false,
      ["<leader>fF"] = false,
      ["<leader>fh"] = false,
      ["<leader>fm"] = false,
      ["<leader>fn"] = false,
      ["<leader>fo"] = false,
      ["<leader>fw"] = false,
      ["<leader>fW"] = false,
      ["<leader>sb"] = false,
      ["<leader>sc"] = false,
      ["<leader>sh"] = false,
      ["<leader>sk"] = false,
      ["<leader>sm"] = false,
      ["<leader>sn"] = false,
      ["<leader>sr"] = false,

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
      ["O"] = { "<cmd>lua Scroll('<c-u>', 1, 1)<cr>", desc = "Scroll up half a page" },
      ["E"] = { "<cmd>lua Scroll('<c-d>', 1, 1)<cr>", desc = "Scroll up half a page" },
      ["a"] = { "h", desc = "Move left" },
      ["e"] = { "gj", desc = "Move down" },
      ["o"] = { "gk", desc = "Move up" },
      ["i"] = { "l", desc = "Move right" },
      ["<c-a>"] = { "<cmd>lua require('smart-splits').move_cursor_left()<cr>", desc = "Go to the left window" },
      ["<c-e>"] = { "<cmd>lua require('smart-splits').move_cursor_down()<cr>", desc = "Go to the down window" },
      ["<c-o>"] = { "<cmd>lua require('smart-splits').move_cursor_up()<cr>", desc = "Go to the up window" },
      ["<c-i>"] = { "<cmd>lua require('smart-splits').move_cursor_right()<cr>", desc = "Go to the right window" },

      -- Macros
      ["Q"] = { "q", desc = "Record macro" },

      -- Saving and quitting
      ["<leader>s"] = { "<cmd>update<cr>", desc = "Save" },
      ["q"] = { "<cmd>q<cr>", desc = "Quit" },
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
      ["Z"] = { "z=", desc = "Suggest correct word" },
      ["<leader>z"] = { "<cmd>setl invspell<cr>", desc = "Toggle spell checking" },

      -- Adding git co-authors to commit
      ["<leader>ga"] = { function() git_co_authors() end, desc = "Add git co-authors" },

      -- Telescope bindings
      ["b"] = {
        "<cmd>Telescope buffers sort_mru=true ignore_current_buffer=true<cr>",
        desc = "Switch between buffers",
      },
      ["f"] = { "<cmd>Telescope git_files<cr>", desc = "Search git files" },
      ["F"] = { "<cmd>Telescope find_files<cr>", desc = "Search files" },
      ["J"] = { "<cmd>Telescope live_grep<cr>", desc = "Search word in files" },
      ["T"] = { "<cmd>Telescope<cr>", desc = "Search Telescope builtins" },

      ["tc"] = { "<cmd>Telescope commands<cr>", desc = "Search commands" },
      ["tf"] = { "<cmd>Telescope oldfiles<cr>", desc = "Search file history" },
      ["th"] = { "<cmd>Telescope help_tags<cr>", desc = "Search help" },
      ["tj"] = { "<cmd>Telescope search_history<cr>", desc = "Search search history" },
      ["tk"] = { "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },
      ["tm"] = { "<cmd>Telescope man_pages<cr>", desc = "Search man" },
      ["tn"] = { "<cmd>Telescope diagnostics<cr>", desc = "Search notifications" },
      ["tr"] = { "<cmd>Telescope registers<cr>", desc = "Search registers" },
      ["t_"] = { "<cmd>Telescope command_history<cr>", desc = "Search command history" },

      -- Neo-tree bindings
      ["<leader>f"] = { "<cmd>Neotree focus<cr>", desc = "Focus explorer" },
      ["<leader>F"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle explorer" },
    },

    -- Visual mode mappings
    v = {
      -- Replacing
      ["ü"] = { "r", desc = "Replace character" },

      -- Movement
      ["A"] = { "b", desc = "Move a word backwards" },
      ["I"] = { "w", desc = "Move a word forwards" },
      ["O"] = { "<cmd>lua Scroll('<c-u>', 1, 1)<cr>", desc = "Scroll up half a page" },
      ["E"] = { "<cmd>lua Scroll('<c-d>', 1, 1)<cr>", desc = "Scroll up half a page" },
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

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      n = {
        ["t"] = { name = "Search" },
      },
    },
  },

  -- Set up autocommands and custom highlight groups
  polish = function()
    -- Enable number number hybrid mode
    -- vim.api.nvim_create_augroup("numbertoggle", { clear = true })
    -- vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
    --   group = "numbertoggle",
    --   command = "set relativenumber",
    -- })
    -- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    --   group = "numbertoggle",
    --   command = "set norelativenumber",
    -- })

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

    -- Set highlighting groups for leap
    vim.api.nvim_set_hl(0, "LeapLabelPrimary", { link = "GruvboxOrangeBold" })
    vim.api.nvim_set_hl(0, "LeapLabelSecondary", { link = "GruvboxYellowBold" })
  end,
}

-- Return final config table
return config
