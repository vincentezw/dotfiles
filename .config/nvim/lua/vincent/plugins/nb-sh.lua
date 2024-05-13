return {
  "vincentezw/nb-sh.nvim",
  -- dir = "/home/vincent/src/nb.nvim/",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local nb = require("nb")
    nb.setup({
      auto_sync = true,
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>nn", "<cmd>NbNew<CR>", { desc = "New note" })
    keymap.set("n", "<leader>nb", "<cmd>Nbbrowse<CR>", { desc = "Browse notes" })
  end,
}
