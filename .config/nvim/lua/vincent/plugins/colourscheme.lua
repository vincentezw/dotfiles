return {
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd("colorscheme oxocarbon")
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },
  -- {
  --   "navarasu/onedark.nvim",
  --   config = function()
  --     require("onedark").setup({
  --       commentStyle = "italic",
  --       keywordStyle = "italic",
  --       functionStyle = "italic",
  --       variableStyle = "italic",
  --       transparent = true,
  --       sidebars = { "qf", "vista_kind", "terminal", "packer" },
  --     })
  --     -- loadhi the colorscheme here
  --     -- vim.cmd([[colorscheme onedark]])
  --   end,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       integrations = {
  --         barbar = true,
  --         barbecue = {
  --           dim_dirname = true, -- directory name is dimmed by default
  --           bold_basename = true,
  --           dim_context = false,
  --           alt_background = false,
  --         },
  --         cmp = true,
  --         mason = true,
  --         neotree = true,
  --         native_lsp = {
  --           enabled = true,
  --           virtual_text = {
  --             errors = { "italic" },
  --             hints = { "italic" },
  --             warnings = { "italic" },
  --             information = { "italic" },
  --           },
  --           underlines = {
  --             errors = { "underline" },
  --             hints = { "underline" },
  --             warnings = { "underline" },
  --             information = { "underline" },
  --           },
  --           inlay_hints = {
  --             background = true,
  --           },
  --         },
  --         treesitter = true,
  --         telescope = {
  --           enabled = true,
  --         },
  --         which_key = true,
  --       },
  --     })
  --     -- loadhi the colorscheme here
  --     vim.cmd([[colorscheme catppuccin-frappe]])
  --   end,
  -- },
}
