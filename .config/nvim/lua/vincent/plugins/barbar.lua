return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
    vim.cmd([[
    function! CloseOrQuit() abort
      let buffer_count = len(split(execute(':ls'), "\n")) - 2
      if buffer_count >= 0  
        silent! BufferClose
      else
        Neotree close
        quit
      endif
    endfunction
    ]])
    vim.cmd("command! -bar -nargs=0 WQ w | call CloseOrQuit()")
    vim.cmd("command! -bar -nargs=0 Wq WQ")
    vim.cmd("cabbrev wq WQ")
    vim.cmd("command! -bar -nargs=0 Q call CloseOrQuit()")
    vim.cmd("cnoreabbrev q Q")

    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Move to previous/next
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
    -- Re-order to previous/next
    map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
    map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
    -- Goto buffer in position...
    map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
    map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 4<CR>", opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 5<CR>", opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 6<CR>", opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 7<CR>", opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 8<CR>", opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 9<CR>", opts)
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
  end,
  opts = {
    animation = true,
    sidebar_filetypes = {
      ["neo-tree"] = { event = "BufWipeout" },
    },
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
