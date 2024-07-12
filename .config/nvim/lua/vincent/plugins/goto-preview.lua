return {
  "rmagatti/goto-preview",
  config = function()
    require("goto-preview").setup({
      default_mappings = true,
      -- border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
      border = { "󰁛", "─", "┐", "│", "┘", "─", "└", "│" },
      opacity = 0,
      preview_window_title = { enable = true, position = "center" },
      post_open_hook = function(buffer, window)
        -- Disable LSP for this buffer
        -- vim.api.nvim_buf_set_option(buffer, 'buftype', 'nofile')
        -- vim.lsp.diagnostic.set_virtual_text({}, 0, {publishDiagnostics = false})
        -- Override the highlight group for the title text
        vim.api.nvim_set_option_value("winhighlight", "FloatTitle:GotoPreviewTitle", {win = window})
        vim.keymap.set('n', 'q', function()
          require('goto-preview').close_all_win()
        end, { buffer = true, remap = true })
      end,
    })
  end,
}
