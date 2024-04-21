return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  config = function()
    vim.cmd("let test#strategy = 'vimux'")
  end,
  keys = {
    { "<leader>t", "<cmd>TestNearest<cr>", desc = "Test nearest" },
    { "<leader>T", "<cmd>TestFile<cr>", desc = "Test file" },
    { "<leader>a", "<cmd>TestSuite<cr>", desc = "Test suite" },
    { "<leader>l", "<cmd>TestLast<cr>", desc = "Test last" },
    { "<leader>g", "<cmd>TestVisit<cr>", desc = "Test Visit" },
  },
}
