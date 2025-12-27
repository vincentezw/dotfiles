local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.showmode = false
opt.cmdheight = 0

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
opt.smoothscroll = true

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"

-- opt.foldexpr = "v:lua.require'vincent.core.folding'.foldexpr()"
-- opt.foldtext = "v:lua.require'vincent.core.folding'.foldtext()"
-- opt.foldmethod = "expr"
-- opt.foldlevelstart = 99
-- opt.foldenable = true
-- opt.foldcolumn = '1'
-- vim.opt.foldlevel = 99

-- vim.cmd([[set noshowmode]])
vim.cmd([[set noshowmode noruler]])
vim.filetype.add({
  extension = {
    mc = "monkeyc",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "monkeyc",
  callback = function()
    vim.cmd([[set syntax=java]])
    vim.opt_local.iskeyword:append(":")
    vim.opt_local.iskeyword:append("_")
  end,
})

