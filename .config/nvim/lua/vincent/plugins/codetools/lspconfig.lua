return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
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

    -- Set up LspAttach autocommand for keybindings
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf

        -- Attach navic if supported
        local attach_navic = true
        if client.name == "sorbet" or client.name == "graphql" then
          attach_navic = false
        end
        if attach_navic and client.server_capabilities["documentSymbolProvider"] then
          require("nvim-navic").attach(client, bufnr)
        end

        -- Set keybinds
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        keymap.set("n", "gR", "<cmd>lua require('fzf-lua').lsp_references()<CR>", vim.tbl_extend("force", bufopts, { desc = "Show LSP references" }))
        keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "Go to declaration" }))
        keymap.set("n", "gd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", vim.tbl_extend("force", bufopts, { desc = "Show LSP definitions" }))
        keymap.set("n", "gI", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", vim.tbl_extend("force", bufopts, { desc = "Show LSP implementations" }))
        keymap.set("n", "gt", "<cmd>lua require('fzf-lua').lsp_type_definitions()<CR>", vim.tbl_extend("force", bufopts, { desc = "Show LSP type definitions" }))
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "See available code actions" }))
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "Smart rename" }))
        keymap.set("n", "[d", function() vim.diagnostic.jump({count=-1, float=true}) end, vim.tbl_extend("force", bufopts, { desc = "󰒮 diagnostic" }))
        keymap.set("n", "]d", function() vim.diagnostic.jump({count=1, float=true}) end, vim.tbl_extend("force", bufopts, { desc = "󰒭 diagnostic" }))
        keymap.set("n", "K", function() vim.lsp.buf.hover { border = 'rounded' } end, vim.tbl_extend("force", bufopts, { desc = "Show documentation for what is under cursor" }))
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", vim.tbl_extend("force", bufopts, { desc = "Restart LSP" }))
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local util = require 'lspconfig.util'

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

      local root = util.root_pattern("manifest.xml") or vim.fn.getcwd()
      local project_root = (util.root_pattern("manifest.xml"))(vim.fn.getcwd()) or vim.fn.getcwd()

      vim.lsp.config('monkeyc_ls', {
        cmd = {
          "java",
          "-Dapple.awt.UIElement=true",
          "-classpath",
          monkeyc_lsp_jar,
          "com.garmin.monkeybrains.languageserver.LSLauncher",
        },
        filetypes = { "monkeyc", "jungle", "mss" },
        root_markers = { "manifest.xml" },
        capabilities = monkeycLspCapabilities,
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
      })
    end

    -- Shopify's ruby lsp
    local enabled_features = {
      "documentHighlights",
      "documentSymbols",
      "foldingRanges",
      "selectionRanges",
      "formatting",
      "codeActions",
    }

    vim.lsp.config('ruby_lsp', {
      cmd = { "sh", "-c", 'GEM_HOME="${GEM_PATH%%:*}" exec ruby-lsp' },
      filetypes = { "ruby" },
      root_markers = { "Gemfile", ".git" },
      capabilities = capabilities,
      init_options = {
        enabledFeatures = enabled_features,
      },
      settings = {},
    })

    vim.api.nvim_create_user_command('FormatRuby', function()
      vim.lsp.buf.format({
        name = "ruby_lsp",
        async = true,
      })
    end, { desc = "Format using ruby-lsp" })

    -- Configure standard LSP servers
    vim.lsp.config('html', { capabilities = capabilities })
    vim.lsp.config('ts_ls', { capabilities = capabilities })
    vim.lsp.config('cssls', { capabilities = capabilities })
    vim.lsp.config('tailwindcss', { capabilities = capabilities })
    vim.lsp.config('pyright', { capabilities = capabilities })
    vim.lsp.config('gopls', { capabilities = capabilities })
    vim.lsp.config('rust_analyzer', { capabilities = capabilities })
    vim.lsp.config('svelte', { capabilities = capabilities })

    vim.lsp.config('graphql', {
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    vim.lsp.config('emmet_ls', {
      capabilities = capabilities,
      filetypes = { "html", "svelte", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    })

    vim.lsp.config('sorbet', {
      capabilities = capabilities,
    })

    vim.lsp.config('starpls', {
      capabilities = capabilities,
      filetypes = { "starlark" },
    })

    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- Enable all configured LSP servers
    vim.lsp.enable({'html', 'ts_ls', 'cssls', 'tailwindcss', 'graphql', 'emmet_ls',
                    'pyright', 'sorbet', 'gopls', 'rust_analyzer', 'starpls',
                    'svelte', 'lua_ls', 'ruby_lsp'})

    if monkeyc_lsp_jar then
      vim.lsp.enable('monkeyc_ls')
    end
  end,
}
