local light_mode = vim.env.LIGHT_NVIM == "1"
if light_mode then
  return {}
end

return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    {
      "williamboman/mason.nvim",
      config = function()
        local mason = require("mason")
        mason.setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        })
      end,
    },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  event = "VeryLazy",
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "graphql",
        "emmet_ls",
        -- "prismals",
        -- "pyright",
        -- "gopls",
        "rust_analyzer",
        "ruby_lsp",
        "sorbet",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = { exclude = {"starpls", "gopls"}},
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        -- "isort", -- python formatter
        -- "black", -- python formatter
        -- "pylint", -- python linter
        "eslint_d", -- js linter
      },
    })
  end,
}
