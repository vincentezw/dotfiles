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
        -- this used to target 'window' but I think it's fine
        -- vim.api.nvim_win_set_option(window, "winhighlight", "Title:GotoPreviewTitle")
        vim.api.nvim_set_option_value("winhighlight", "Title:GotoPreviewTitle", {})
        -- vim.api.nvim_buf_set_keymap(buffer, 'n', '1', 'lua require("goto-preview").close_all_win()', {noremap = true, silent = true})
        vim.api.nvim_buf_set_keymap(buffer, 'n', 'q', ':bd<CR>', {noremap = true, silent = true})
      end,
    })
  end,
}
