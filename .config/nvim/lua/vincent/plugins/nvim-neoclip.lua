return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    { "kkharji/sqlite.lua", module = "sqlite" },
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    require("neoclip").setup({
      enable_persistent_history = false,
    })
    require("telescope").load_extension("neoclip")
  end,
}
