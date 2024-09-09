return {
  'mistweaverco/kulala.nvim',
  config = function()
    require('kulala').setup()

    vim.filetype.add({
      extension = {
        ['http'] = 'http',
      },
    })

    local opts = { noremap = true, silent = true }
    opts.desc = 'Fire request with kulala'
    -- vim.api.nvim_set_keymap("n", "<C-j>", ":lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>k", ":lua require('kulala').run()<CR>", opts)
  end
}
