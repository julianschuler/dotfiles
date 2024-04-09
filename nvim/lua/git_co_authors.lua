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
