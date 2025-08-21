return {
  'mrjones2014/smart-splits.nvim',
  priority = 1,
  lazy = false,
  init = function()
    -- Set multiplexer integration before plugin loads
    vim.g.smart_splits_multiplexer_integration = 'wezterm'
  end,
  config = function()
    -- vim.g.smart_splits_multiplexer_integration = 'wezterm'
    local nvim_smart_splits = require('smart-splits')

    nvim_smart_splits.setup {
      multiplexer_integration = 'wezterm',
    }
    local keymap = vim.keymap -- for conciseness
    keymap.set('n', '<C-h>', nvim_smart_splits.move_cursor_left, { desc = 'Move to left split' })
    keymap.set('n', '<C-j>', nvim_smart_splits.move_cursor_down, { desc = 'Move to below split' })
    keymap.set('n', '<C-k>', nvim_smart_splits.move_cursor_up, { desc = 'Move to above split' })
    keymap.set('n', '<C-l>', nvim_smart_splits.move_cursor_right, { desc = 'Move to right split' })
    keymap.set('n', '<C-\\>', nvim_smart_splits.move_cursor_previous, { desc = 'Move to previous split' })
  end
}

