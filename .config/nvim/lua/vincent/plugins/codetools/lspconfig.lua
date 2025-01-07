return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = "rounded"
      }
    )

    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)
      local attach_navic = true
      if client.name == "sorbet" or client.name == "graphql"then
        attach_navic = false
      end
      if attach_navic and client.server_capabilities["documentSymbolProvider"] then
        require("nvim-navic").attach(client, bufnr)
      end

      opts.buffer = bufnr
      -- set keybinds
      opts.desc = "Show LSP references"
      -- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
      keymap.set("n", "gR", "<cmd>lua require('fzf-lua').lsp_references()<CR>", opts) -- show definition, references
      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
      opts.desc = "Show LSP definitions"
      -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
      keymap.set("n", "gd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", opts) -- show lsp definitions
      opts.desc = "Show LSP implementations"
      -- keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
      keymap.set("n", "gI", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts) -- show lsp implementations
      opts.desc = "Show LSP type definitions"
      -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
      keymap.set("n", "gt", "<cmd>lua require('fzf-lua').lsp_type_definitions()<CR>", opts) -- show lsp type definitions
      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", function() vim.diagnostic.open_float({border = 'rounded'}) end, opts)
      opts.desc = "󰒮 diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
      opts.desc = "󰒭 diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
      -- opts.desc = "Show documentation for what is under cursor"
      -- keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    -- comment out for ufo using LSP as fold provider
    -- don't forget to disable treeseitter in the ufo config then
    -- capabilities.textDocument.foldingRange = {
    --   dynamicRegistration = false,
    --   lineFoldingOnly = true
    -- }

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Shopify's ruby lsp
    local configs = require("lspconfig.configs")
    local util = require 'lspconfig/util'

    if not configs.ruby_lsp then
      local enabled_features = {
        "documentHighlights",
        "documentSymbols",
        "foldingRanges",
        "selectionRanges",
        "formatting",
        "codeActions",
      }

      configs.ruby_lsp = {
        default_config = {
          cmd = { "ruby-lsp" },
          filetypes = { "ruby" },
          root_dir = util.root_pattern("Gemfile", ".git"),
          init_options = {
            enabledFeatures = enabled_features,
          },
          settings = {},
        },
        commands = {
          FormatRuby = {
            function()
              vim.lsp.buf.format({
                name = "ruby_lsp",
                async = true,
              })
            end,
            description = "Format using ruby-lsp",
          },
        },
      }
    end

    local lsp_servers = {
      'ruby_lsp',
      'html',
      'ts_ls',
      'cssls',
      'tailwindcss',
      'graphql',
      'emmet_ls',
      'graphql',
      'pyright',
      'sorbet',
      'gopls',
      'rust_analyzer',
      'starpls',
    }

    for _, lsp_server in pairs(lsp_servers) do
      local filetypes
      local root_dir
      if lsp_server == 'graphql' then
        filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" }
      elseif lsp_server == 'ruby_lsp' then
        filetypes = { "ruby" }
      elseif lsp_server == 'starpls' then
        filetypes = { "starlark" }
        root_dir = function(fname)
          return util.path.dirname(fname)
        end
      elseif lsp_server == 'emmet_ls' then
        filetypes = { "html", "svelte", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" }
      end

      lspconfig[lsp_server].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = filetypes or lspconfig[lsp_server].document_config.default_config.filetypes,
        root_dir = root_dir or lspconfig[lsp_server].document_config.default_config.root_dir,
      })
    end

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
}
