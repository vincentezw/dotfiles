return {
  "rmagatti/goto-preview",
  config = function()
    require("goto-preview").setup({
      default_mappings = true,
      border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
      opacity = 20,
    })
  end,
}
