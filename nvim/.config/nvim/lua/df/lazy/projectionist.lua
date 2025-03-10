return {
  "tpope/vim-projectionist",
  dependencies = { "folke/which-key.nvim" },
  lazy = false,
  config = function()
    require("which-key").add({ "<leader>A", group = "Alternate" })
  end,
  -- event = "BufRead",
  keys = {
    { "<leader>Aa", "<Cmd>A<CR>", desc = "Alternate file" },
    { "<leader>Av", "<Cmd>AV<CR>", desc = "Alternate vsplit" },
    { "<leader>As", "<Cmd>AS<CR>", desc = "Alternate split" },
    { "<leader>At", "<Cmd>AT<CR>", desc = "Alternate tab" },
  },
}
