local map = vim.keymap.set

-- Utility functions
local function project_name()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function file_tag()
  local f = vim.fn.expand("%:t")
  return f ~= "" and f or "no-file"
end

local function normalize_tag(s)
  local name, ext = s:match("^(.*)(%..+)$")
  if not name then
    name, ext = s, ""
  end
  name = name:lower()
            :gsub("[^%w]+", "_")
            :gsub("^_+", "")
            :gsub("_+$", "")
  return name .. ext:lower()
end

-- New note with title and single-line tags
map("n", "<leader>nn", function()
  local zk = require("zk")
  local title = vim.fn.input("Note title: ")
  if title == "" then return end

  local tags = {
    normalize_tag(project_name()),
    normalize_tag(file_tag())
  }

  local content = string.format("#%s\n\n", table.concat(tags, " #"))

  zk.new({
    title = title,
    content = content,
    edit = true,
  })
end, { noremap = true, silent = true, desc = "Create new ZK note" })

-- Find notes
map("n", "<leader>nf", "<cmd>ZkNotes { sort = { 'modified' } }<CR>", { noremap = true, silent = true, desc = "Find ZK notes" })

-- Daily note
map("n", "<leader>nd", "<cmd>ZkToday<CR>", { noremap = true, silent = true, desc = "Open today's ZK note" })

-- Link note in insert mode
map("i", "<leader>nl", "<cmd>ZkLink<CR>", { noremap = true, silent = true, desc = "Insert ZK note link" })

-- Open preview of note under cursor
map("n", "<leader>no", "<cmd>ZkPreview<CR>", { noremap = true, silent = true, desc = "Preview ZK note under cursor" })

