return {
  "ojroques/nvim-osc52",
  config = function()
    local copy = function()
      if vim.v.event.operator == "y" and vim.fn.has("clipboard") == 0 then
        vim.api.nvim_out_write("woofwoofn")
        require("osc52").copy_register("+")
      end
    end

    vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
  end,
}
