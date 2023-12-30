return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    local status_ok, neo_tree = pcall(require, "neo-tree")
    if not status_ok then
      vim.notify("Neotree not found")
      return
    end
    neo_tree.setup({
      popup_border_style = "solid",
      -- closes neotree automatically when it's the last **WINDOW** in the view
      auto_close = true,
      open_on_setup = false,
      -- if true, the neotree will resize itself based on the number of entries
      -- if false, the neotree will always have a fixed width
      auto_resize = true,
      disable_on_buf_enter = false,
      hijack_cursor = true,
      follow_current_file = {
        enabled = true,
      },
      add_trailing = true,
      group_empty = true,
      lsp_diagnostics = true,
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem" },
          { source = "buffers" },
          { source = "git_status" },
          -- { source = "document_symbols" },
        },
      },
      window = {
        mappings = {
          ["e"] = function()
            vim.api.nvim_exec("Neotree focus filesystem left", true)
          end,
          ["b"] = function()
            vim.api.nvim_exec("Neotree focus buffers left", true)
          end,
          ["g"] = function()
            vim.api.nvim_exec("Neotree focus git_status left", true)
          end,
          ["s"] = function()
            vim.api.nvim_exec("Neotree focus document_symbols left", true)
          end,
        },
      },
    })

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })
    keymap.set("n", "<leader>er", "<cmd>Neotree git_base=HEAD<CR>", { desc = "Go to git base" })
    keymap.set("n", "<leader>eb", "<cmd>Neotree float buffers<CR>", { desc = "Go to git base" })
    keymap.set("n", "<leader>eg", "<cmd>Neotree float git_status git_base=main<CR>", { desc = "Go to git base" })
    keymap.set("n", "<leader>es", "<cmd>Neotree float document_symbols<CR>", { desc = "Go to git base" })
  end,
}
