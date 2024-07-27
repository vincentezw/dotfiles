return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    -- "nvim-tree/nvim-web-devicons",
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
    opts.desc = "Move to previous buffer"
    map("n", "<leader><", "<Cmd>BufferMovePrevious<CR>", opts)
    opts.desc = "Move to next buffer"
    map("n", "<leader>>", "<Cmd>BufferMoveNext<CR>", opts)
    map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
    map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
    map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
    map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
    map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
    map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
    map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
    map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
    map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
    map("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)
    opts.desc = "Close buffer"
    map("n", "<leader>bx", "<Cmd>BufferClose<CR>", opts)
    opts.desc = "Close all but current"
    map("n", "<leader>ba", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
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
