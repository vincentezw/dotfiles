local light_mode = vim.env.LIGHT_NVIM == "1"

local deps = {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/nui.nvim",
  "kevinhwang91/nvim-ufo",
}

if not light_mode then
  table.insert(deps, "3rd/image.nvim")
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("load_neo_tree", {}),
  desc = "Loads neo-tree when openning a directory",
  callback = function(args)
    local stats = vim.uv.fs_stat(args.file)
    if not stats or stats.type ~= "directory" then
      return
    end
    require "neo-tree"
    return true
  end,
})

return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VeryLazy",
  branch = "v3.x",
  dependencies = deps,
  config = function()
    local status_ok, neo_tree = pcall(require, "neo-tree")
    if not status_ok then
      vim.notify("Neotree not found")
      return
    end
    neo_tree.setup({
      enable_diagnostics = true,
      enable_git_status = true,
      popup_border_style = "rounded",
      auto_close = true,
      open_on_setup = false,
      -- if {output: true}, the neotree will resize itself based on the number of entries
      -- if false, the neotree will always have a fixed width
      auto_resize = true,
      disable_on_buf_enter = false,
      hijack_cursor = true,
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
      add_trailing = true,
      group_empty = true,
      -- lsp_diagnostics = true,
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      source_selector = {
        statusline = true,
        content_layout = "center",
        separator = "",
        sources = {
          { source = "filesystem" },
          { source = "buffers" },
          { source = "git_status" },
        },
      },
      window = {
        mappings = {
          ["e"] = function()
            vim.api.nvim_exec2("Neotree focus filesystem left", {output = true})
          end,
          ["b"] = function()
            vim.api.nvim_exec2("Neotree focus buffers left", {output = true})
          end,
          ["g"] = function()
            vim.api.nvim_exec2("Neotree focus git_status left", {output = true})
          end,
          ["s"] = function()
            vim.api.nvim_exec2("Neotree focus document_symbols left", {output = true})
          end,
          ["P"] = function(state)
            local node = state.tree:get_node()
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
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
  priority = 51,
}
