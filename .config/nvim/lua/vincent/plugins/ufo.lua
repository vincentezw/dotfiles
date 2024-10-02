return {
  "kevinhwang91/nvim-ufo",
  config = function()
    vim.opt.foldcolumn = '1'
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
    require("ufo").setup({
      preview = {
        win_config = {
          winblend = 0,
        }
      },
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    })
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    local opts = {
      noremap = true,
      silent = true,
      desc = "Show documentation for what is under cursor",
    }
    vim.keymap.set('n', 'K', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, opts)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'neo-tree', 'NeogitStatus' },
      callback = function()
        require('ufo').detach()
        -- vim.opt_local.foldenable = false
        -- vim.opt_local.foldcolumn = '0'
      end,
    })
  end,
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-telescope/telescope.nvim", -- optional
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          relculright = true,
          bt_ignore = { "nofile", "prompt" },
          ft_ignore = {
            "neo-tree",
            "TelescopePrompt",
            "TelescopeResults",
            "help",
            "dashboard",
            "lazy",
            "toggleterm",
          },
          segments = {
            {
              text = { builtin.foldfunc },
              colwidth = 2,
              click = "v:lua.ScFa",
            },
            { text = { " %s" }, click = "v:lua.ScSa" },
            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          },
        })
        vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#b0b0b0" })
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      end,
    },
  },
  event = "BufReadPost",
}
