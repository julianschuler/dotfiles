-- The following keybindings are adapted to a modified VOU layout
-- and mostly won't make sense on a default QWERTY/QWERTZ keyboard
return {
  -- Normal mode mappings
  n = {
    -- Disable unused default bindings
    ["<leader>w"] = false,
    ["<leader>/"] = false,

    -- Joining, replacing and redoing
    ["ö"] = { "J", desc = "Join lines" },
    ["ü"] = { "r", desc = "Replace character" },
    ["ä"] = { "<c-r>", desc = "Redo" },

    -- Switching to insert mode
    ["r"] = { "<cmd>noh<cr>i", desc = "Insert before cursor" },
    ["w"] = { "<cmd>noh<cr>A", desc = "Append at end of line" },
    ["W"] = { "<cmd>noh<cr>I", desc = "Insert at beginning of line" },
    ["l"] = { "<cmd>noh<cr>o", desc = "Begin new line below" },
    ["L"] = { "<cmd>noh<cr>O", desc = "Begin new line above" },

    -- Navigating the jump list
    ["<c-k>"] = { "<c-o>", desc = "Jump to previous position in jumplist" },
    ["<c-m>"] = { "<c-i>", desc = "Jump to next position in jumplist" },

    -- Movement
    ["A"] = { "b", desc = "Move a word backwards" },
    ["I"] = { "w", desc = "Move a word forwards" },
    ["E"] = { "<c-d>", desc = "Move half page down" },
    ["O"] = { "<c-u>", desc = "Move half page up" },
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
    ["<leader>y"] = { "<cmd>sil %y<cr>", desc = "Yank buffer" },

    -- Spell checking
    ["<leader>z"] = {
      "<cmd>setl invspell<cr>",
      desc = "Toggle spell checking",
    },

    -- Adding git co-authors to commit
    ["<leader>ga"] = {
      function() require "git_co_authors" end,
      desc = "Add git co-authors",
    },

    -- Telescope bindings
    ["t"] = { name = "Search with telescope" },
    ["b"] = {
      "<cmd>Telescope buffers sort_mru=true ignore_current_buffer=true<cr>",
      desc = "Switch between buffers",
    },
    ["f"] = { "<cmd>Telescope find_files<cr>", desc = "Search files" },
    ["F"] = {
      "<cmd>Telescope find_files hidden=true<cr>",
      desc = "Search all files",
    },
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
    -- Joining and replacing
    ["ö"] = { "J", desc = "Join lines" },
    ["ü"] = { "r", desc = "Replace character" },

    -- Movement
    ["A"] = { "b", desc = "Move a word backwards" },
    ["I"] = { "w", desc = "Move a word forwards" },
    ["E"] = { "gjzz", desc = "Move down and center window" },
    ["O"] = { "gkzz", desc = "Move down and center window" },
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
    ["<c-backspace>"] = { "<c-w>", desc = "Delete last word" },
  },
}
