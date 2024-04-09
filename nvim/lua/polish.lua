-- Add additional commands for Typst and Markdown files
vim.api.nvim_create_augroup("bufcheck", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "bufcheck",
  pattern = "typst",
  command = "nnoremap <leader>v <cmd>sil !pdf %:r.pdf<cr>",
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
