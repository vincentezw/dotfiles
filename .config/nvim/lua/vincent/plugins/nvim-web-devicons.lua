return {
  "DaikyXendo/nvim-material-icon",
  config = function()
    require("nvim-web-devicons").setup({
      default = true,
      override = {
        gql = {
          icon = "",
          color = "#e535ab",
          cterm_color = "199",
          name = "GraphQL",
        },
      },
    })
  end,
}
