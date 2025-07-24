return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {},
  config = function()
    -- defining some hidden keymaps here
    local wk = require("which-key")
    for i = 1, 9 do
      wk.add({
        "<leader>" .. i,
        function()
          vim.cmd("BufferGoto " .. i)
        end,
        hidden = true,
      })
    end

    wk.add({
      "<leader>0",
      function()
        vim.cmd("BufferLast")
      end,
      hidden = true,
    })
  end,
}
