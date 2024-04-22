return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  config = function()
    vim.cmd("let test#strategy = 'vimux'")
  end,
  keys = {
    { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Test nearest" },
    { "<leader>tT", "<cmd>TestFile<cr>", desc = "Test file" },
    { "<leader>ta", "<cmd>TestSuite<cr>", desc = "Test suite" },
    { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
    { "<leader>tg", "<cmd>TestVisit<cr>", desc = "Test Visit" },
  },
}
