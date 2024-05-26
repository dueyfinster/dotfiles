local set = vim.keymap.set

vim.g.mapleader = " "
set("n", "<leader>pv", vim.cmd.Ex)

-- Visually move blocks
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines but keep cursor posit.
set("n", "J", "mzJ`z")
-- Center page up/down
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
-- Center search resulls
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- greatest remap ever
set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])

set({ "n", "v" }, "<leader>d", [["_d]])

-- Map CTRL-C to ESC
set("i", "<C-c>", "<Esc>")

-- Turn off Q
set("n", "Q", "<nop>")
-- call new session
set("n", "<C-f>", "<cmd>silent !tmux neww tm<CR>")
-- format buffer
set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix window navigation
set("n", "<C-k>", "<cmd>cnext<CR>zz")
set("n", "<C-j>", "<cmd>cprev<CR>zz")
set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next Quickfix" })
set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous Quickfix" })
--
-- Location list navigation
set("n", "<leader>k", "<cmd>lnext<CR>zz")
set("n", "<leader>j", "<cmd>lprev<CR>zz")


-- replace word you have selected
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- make executable
set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/df/lazy<CR>");

set("n", "<leader><leader>", function()
  vim.cmd("so")
end)


-- These mappings control the size of splits (height/width)
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")
