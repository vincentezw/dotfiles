return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim", -- optional
    -- "ibhagwan/fzf-lua", -- optional
  },
  config = function()
    require("neogit").setup({
      integrations = {
        diffview = true,
        telescope = true,
      },
    })
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ng", "<cmd>Neogit<cr>", { desc = "Neogit" })
    keymap.set("n", "<leader>nc", "<cmd>Neogit commit<cr>", { desc = "Neogit commit" })
  end,
}
