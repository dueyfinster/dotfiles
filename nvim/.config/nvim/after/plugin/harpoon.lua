local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", ";a", function() harpoon:list():select(1) end)
vim.keymap.set("n", ";s", function() harpoon:list():select(2) end)
vim.keymap.set("n", ";d", function() harpoon:list():select(3) end)
vim.keymap.set("n", ";f", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():prepend()
end)
vim.keymap.set("n", "<leader>hA", function()
  harpoon:list():append()
end)
vim.keymap.set("n", "<leader>hr", function()
  harpoon:list():remove()
end)
vim.keymap.set("n", "<leader>hh", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "]h", function()
  harpoon:list():next()
end)
vim.keymap.set("n", "[h", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "]H", function()
  harpoon:list():select(harpoon:list():length())
end)
vim.keymap.set("n", "[H", function()
  harpoon:list():select(1)
end)

require("telescope").load_extension("harpoon")
