return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    -- "nvim-tree/nvim-web-devicons", -- optional dependency
    "DaikyXendo/nvim-material-icon",
  },
  opts = {
    theme = "auto", -- configurations go here
  },
  config = function()
    vim.opt.updatetime = 200

    require("barbecue").setup({
      create_autocmd = false, -- prevent barbecue from updating itself automatically
      exclude_filetypes = { "neo-tree", "goto-preview" },
      lead_custom_section = function()
        return " "
      end,
    })

    vim.api.nvim_create_autocmd({
      "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",

      -- include this if you have set `show_modified` to `true`
      "BufModifiedSet",
    }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
  end,
}
