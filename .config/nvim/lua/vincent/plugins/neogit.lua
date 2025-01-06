return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional
    "ibhagwan/fzf-lua",
  },
  event = "VeryLazy",
  config = function()
    require("neogit").setup({
      integrations = {
        diffview = true,
        fzf_lua = true,
      },
    })
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ng", "<cmd>Neogit<cr>", { desc = "Neogit" })
    keymap.set("n", "<leader>nc", "<cmd>Neogit commit<cr>", { desc = "Neogit commit" })
  end,
}
