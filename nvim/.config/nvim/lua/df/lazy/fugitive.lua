return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

    local DF_Fugitive = vim.api.nvim_create_augroup("DF_Fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      group = DF_Fugitive,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>p", function()
          vim.cmd.Git('push')
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
          vim.cmd.Git({ 'pull', '--rebase' })
        end, opts)


        vim.keymap.set("n", "<Leader>gap", ":Git add % -p<CR>", { desc = "Git add" })
        vim.keymap.set("n", "<Leader>gc", ":Git commit<CR>", { desc = "Git commit" })
        vim.keymap.set("n", "<Leader>gco", ":Git checkout<CR>", { desc = "Git checkout" })
        vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
        vim.keymap.set("n", "<leader>gpl", ":Git pull<CR>", { desc = "Git pull" })
        vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git" })

        vim.api.nvim_command("augroup FugitiveToggle")
        vim.api.nvim_command("au!")
        vim.api.nvim_command("au Filetype fugitive nnoremap <buffer> <space>gs <C-w>q")
        vim.api.nvim_command("augroup END")

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
      end,
    })


    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
  end
}
