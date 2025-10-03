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

    vim.diagnostic.config({
      -- virtual_text = {
      --   prefix = "●",
      --   spacing = 1,
      -- },
      virtual_lines = {
        current_line = true,
        prefix = "●",
        spacing = 1,
      },
    })

    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true }

    -- Set global diagnostic keybindings (available even without LSP attached)
    keymap.set("n", "<leader>D", "<cmd>lua require('fzf-lua').diagnostics_document()<CR>", { noremap = true, silent = true, desc = "Show buffer diagnostics" })
    keymap.set("n", "<leader>d", function()
      vim.diagnostic.open_float({
        border = 'rounded',
        focus = false,
        source = 'always',
      })
    end, { noremap = true, silent = true, desc = "Show line diagnostics" })
    keymap.set("n", "<leader>dy", function()
      local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
      if #diagnostics > 0 then
        local messages = {}
        for _, diagnostic in ipairs(diagnostics) do
          table.insert(messages, diagnostic.message)
        end
        local text = table.concat(messages, ' | ')
        vim.fn.setreg('+', text)
        vim.notify('Diagnostic yanked: ' .. text, vim.log.levels.INFO)
      else
        vim.notify('No diagnostics on this line', vim.log.levels.WARN)
      end
    end, { noremap = true, silent = true, desc = "Yank diagnostic message to clipboard" })

    -- Monkey C stuff
    local function get_monkey_language_server_path()
      local cfg_path
      local os_name = vim.loop.os_uname().sysname:lower()

      if os_name == "linux" then
        cfg_path = vim.fn.expand("~/.Garmin/ConnectIQ/current-sdk.cfg") -- Linux path
      else
        -- Default to Mac path for other OS (primarily macOS)
        cfg_path = vim.fn.expand("~/Library/Application Support/Garmin/ConnectIQ/current-sdk.cfg")
      end

      if vim.fn.filereadable(cfg_path) ~= 1 then
        return nil
      end

      local workspace_dir = table.concat(vim.fn.readfile(cfg_path), "\n")
      local jar_path = workspace_dir .. "/bin/LanguageServer.jar"

      if vim.fn.filereadable(jar_path) == 1 then
        return jar_path
      end

      return nil
    end

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
      keymap.set("n", "gR", "<cmd>lua require('fzf-lua').lsp_references()<CR>", opts) -- show definition, references
      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", opts) -- show lsp definitions
      opts.desc = "Show LSP implementations"
      keymap.set("n", "gI", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts) -- show lsp implementations
      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>lua require('fzf-lua').lsp_type_definitions()<CR>", opts) -- show lsp type definitions
      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
      -- Diagnostic keybindings are now set globally above
      opts.desc = "󰒮 diagnostic"
      keymap.set("n", "[d", function() vim.diagnostic.jump({count=-1, float=true}) end, opts) -- jump to previous diagnostic in buffer
      opts.desc = "󰒭 diagnostic"
      keymap.set("n", "]d", function() vim.diagnostic.jump({count=1, float=true}) end, opts) -- jump to next diagnostic in buffer
      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", function() vim.lsp.buf.hover { border = 'rounded' } end, opts) -- show documentation for what is under cursor
      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local configs = require("lspconfig.configs")

    -- Monkey C
    local monkeyc_lsp_jar = get_monkey_language_server_path()
    local monkeycLspCapabilities = nil
    if monkeyc_lsp_jar then
      monkeycLspCapabilities = vim.lsp.protocol.make_client_capabilities()
      -- Need to set some variables in the client capabilities to prevent the
      -- LanguageServer from raising exceptions
      monkeycLspCapabilities.textDocument.declaration.dynamicRegistration = true
      monkeycLspCapabilities.textDocument.implementation.dynamicRegistration = true
      monkeycLspCapabilities.textDocument.typeDefinition.dynamicRegistration = true
      monkeycLspCapabilities.textDocument.documentHighlight.dynamicRegistration = true
      monkeycLspCapabilities.workspace = {
        didChangeWorkspaceFolders = {
          dynamicRegistration = true,
        },
      }
      monkeycLspCapabilities.textDocument.foldingRange = {
        lineFoldingOnly = true,
        dynamicRegistration = true,
      }
    end

    if monkeyc_lsp_jar and not configs.monkeyc_ls then
      local root = lspconfig.util.root_pattern("manifest.xml") or vim.fn.getcwd()
      local project_root = (lspconfig.util.root_pattern("manifest.xml"))(vim.fn.getcwd()) or vim.fn.getcwd()
      configs.monkeyc_ls = {
        default_config = {
          cmd = {
            "java",
            "-Dapple.awt.UIElement=true",
            "-classpath",
            monkeyc_lsp_jar,
            "com.garmin.monkeybrains.languageserver.LSLauncher",
          },
          filetypes = { "monkeyc", "jungle", "mss" },
          root_dir = root,
          settings = {
            {
              developerKeyPath = vim.g.monkeyc_connect_iq_dev_key_path
                or vim.fn.expand("~/garmin-apps/"),
              compilerWarnings = true,
              compilerOptions = vim.g.monkeyc_compiler_options or "",
              developerId = "",
              jungleFiles = "monkey.jungle",
              javaPath = "",
              typeCheckLevel = "Default",
              optimizationLevel = "Default",
              testDevices = {
                "venu3", -- get this dynamically from the manifest file
              },
              debugLogLevel = "Default",
            },
          },
          capabilities = monkeycLspCapabilities,
          init_options = {
            publishWarnings = vim.g.monkeyc_publish_warnings or true,
            compilerOptions = vim.g.monkeyc_compiler_options or "",
            typeCheckMsgDisplayed = true,
            workspaceSettings = {
              {
                path = root(vim.fn.getcwd()),
                jungleFiles = {
                  project_root .. "/monkey.jungle",
                  -- root(vim.fn.getcwd()) .. "/monkey.jungle",
                },
              },
            },
          },
        },
      }
    end

    -- Shopify's ruby lsp
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
          cmd = { "bundle", "exec", "ruby-lsp" },
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
      'svelte',
    }

    -- Only add monkeyc_ls if the language server JAR is available
    if monkeyc_lsp_jar then
      table.insert(lsp_servers, 'monkeyc_ls')
    end

    for _, lsp_server in pairs(lsp_servers) do
      -- Skip if the server doesn't exist in lspconfig
      if lspconfig[lsp_server] then
        local config = {
          capabilities = capabilities,
          on_attach = on_attach,
        }

        -- Custom configurations for specific servers
        if lsp_server == 'graphql' then
          config.filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" }
        elseif lsp_server == 'ruby_lsp' then
          config.filetypes = { "ruby" }
        elseif lsp_server == 'starpls' then
          config.filetypes = { "starlark" }
          config.root_dir = function(fname)
            return util.path.dirname(fname)
          end
        elseif lsp_server == 'emmet_ls' then
          config.filetypes = { "html", "svelte", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" }
        end

        -- Only try to access document_config if we haven't set custom filetypes or root_dir
        if not config.filetypes and lspconfig[lsp_server].document_config and lspconfig[lsp_server].document_config.default_config then
          config.filetypes = lspconfig[lsp_server].document_config.default_config.filetypes
        end

        if not config.root_dir and lspconfig[lsp_server].document_config and lspconfig[lsp_server].document_config.default_config then
          config.root_dir = lspconfig[lsp_server].document_config.default_config.root_dir
        end

        lspconfig[lsp_server].setup(config)
      else
        print("LSP server not found: " .. lsp_server)
      end
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
