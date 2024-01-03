return {
  "rmagatti/goto-preview",
  config = function()
    require("goto-preview").setup({
      default_mappings = true,
      -- border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
      border = { "󰁛", "─", "┐", "│", "┘", "─", "└", "│" },
      opacity = 10,
      preview_window_title = { enable = true, position = "center" },
      post_open_hook = function(buffer, window)
        -- Override the highlight group for the title text
        vim.api.nvim_win_set_option(window, "winhighlight", "Title:GotoPreviewTitle")
      end,
    })
  end,
}
