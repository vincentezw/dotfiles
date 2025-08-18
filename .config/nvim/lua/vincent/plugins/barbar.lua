return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "DaikyXendo/nvim-material-icon",
  },
  init = function()
    vim.g.barbar_auto_setup = false
    vim.cmd([[
      function! CloseOrQuit(force) abort
        let buffer_count = len(split(execute(':ls'), "\n")) - 2
        if a:force && buffer_count >= 1
          silent! BufferClose!
        elseif !a:force && buffer_count >= 1
          silent! BufferClose
        elseif a:force && buffer_count < 1 
          Neotree close
          quit!
        elseif !a:force && buffer_count < 1
          if !&modified
            Neotree close
          endif
          quit
        endif
      endfunction
    ]])
    vim.cmd("command! -bar -nargs=0 WQ w | call CloseOrQuit(v:false)")
    vim.cmd("command! -bar -nargs=0 Wq WQ")
    vim.cmd("cabbrev wq WQ")
    vim.cmd([[
      command! -bang -nargs=0 Q :if "<bang>" == "!" | call CloseOrQuit(v:true) | else | call CloseOrQuit(v:false) | endif
    ]])
    vim.cmd("cnoreabbrev q Q")

    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    opts.desc = "Previous buffer"
    map("n", "<leader>,", "<Cmd>BufferPrevious<CR>", opts)
    opts.desc = "Next buffer"
    map("n", "<leader>.", "<Cmd>BufferNext<CR>", opts)
    opts.desc = "Move buffer left"
    map("n", "<leader><", "<Cmd>BufferMovePrevious<CR>", opts)
    opts.desc = "Move buffer right"
    map("n", "<leader>>", "<Cmd>BufferMoveNext<CR>", opts)
    opts.desc = "Close buffer"
    map("n", "<leader>x", "<Cmd>BufferClose<CR>", opts)
    opts.desc = "Close all but current"
    map("n", "<leader>X", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
    opts.desc = "Sort buffers by name"
    map("n", "<leader>bn", "<Cmd>BufferOrderByName<CR>", opts)
    opts.desc = "Sort buffers by number"
    map("n", "<leader>bb", "<Cmd>BufferOrderByName<CR>", opts)
    opts.desc = "Pick buffer"
    map("n", "<leader>p", "<Cmd>BufferPick<CR>", opts)
    map("n", "<leader><leader>", "<Cmd>BufferPick<CR>", opts)
    opts.desc = "Delete buffer"
    map("n", "<leader>bx", "<Cmd>BufferDelete<CR>", opts)
 end,
  opts = {
    animation = true,
    icons = {
      separator_at_end = true,
      preset = "slanted",
      modified = { button = "󰏫" },
    },
    -- sidebar_filetypes = {
    --   ["neo-tree"] = { event = "BufWipeout" },
    -- },
  },
}
