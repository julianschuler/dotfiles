return {
  formatting = {
    format_on_save = {
      enabled = true,
      ignore_filetypes = {
        "markdown",
      },
    },
  },
  config = {
    typst_lsp = {
      settings = {
        exportPdf = "never",
      },
    },
  },
  handlers = {
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
    v = {
      ["<leader>a"] = {
        function() vim.lsp.buf.code_action() end,
        desc = "LSP code action",
      },
    },
  },
  servers = {
    "rust_analyzer",
    "clangd",
  },
}
