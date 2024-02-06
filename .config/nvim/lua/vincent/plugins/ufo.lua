return {
  "kevinhwang91/nvim-ufo",
  config = function()
    vim.opt.foldcolumn = '1'
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true

    require("ufo").setup({
      -- provider_selector = function(bufnr, filetype, buftype)
      --   return {'treesitter', 'indent'}
      -- end,
    })
  end,
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-telescope/telescope.nvim", -- optional
  },
}
