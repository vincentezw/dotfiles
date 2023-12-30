return {
  "DaikyXendo/nvim-material-icon",
  -- "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-material-icon").setup({
      default = true,
    })
    -- require("nvim-web-devicons").set_icon({
    --   gql = {
    --     icon = "",
    --     color = "#e535ab",
    --     cterm_color = "199",
    --     name = "GraphQL",
    --   },
    -- })
  end,
}
