local M = {}

function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    -- as long as we don't have a filetype, don't bother
    -- checking if treesitter is available (it won't)
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    if vim.bo[buf].filetype:find("dashboard") then
      vim.b[buf].ts_folds = false
    else
      vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

function M.foldtext()
  local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  local ret = ok and vim.treesitter.foldtext and vim.treesitter.foldtext()
  local use = {}
  if not ret or type(ret) == "string" then
    use = { { vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1], {} } }
  else
    use = ret
  end
  local num_lines = "  [" .. vim.v.foldend - vim.v.foldstart .. " lines]"
  table.insert(use, { " 󰇘" .. num_lines, { "CursorColumn" }})

  if not vim.treesitter.foldtext then
    return table.concat(
      vim.tbl_map(function(line)
        return line[1]
      end, use),
      " "
    )
  end
  return ret
end

return M
