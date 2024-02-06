local spin_fqdn = os.getenv("SPIN_FQDN")
if not spin_fqdn then
  return {}
end

return {
  "Shopify/spin-nvim",
  -- dir = "/Users/vincent/src/github.com/Shopify/spin-nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
}
