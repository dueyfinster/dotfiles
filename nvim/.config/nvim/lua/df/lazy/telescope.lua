return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  keys = function()
    local builtin = require('telescope.builtin')

    return {
      {
        '<leader>pf',
        function() builtin.find_files() end,
        desc = "Find files in Project"
      },
      {
        '<leader>pm',
        function() builtin.git_status() end,
        desc = "Find Git files modified in Project"
      },
      {
        '<leader>pg',
        function() builtin.git_files() end,
        desc = "Find Git files in Project"
      },
      {
        '<leader>ph',
        function() builtin.git_bcommits() end,
        desc = "Show Git current buffer history"
      },
      {
        '<leader>pc',
        function() builtin.git_bcommits() end,
        desc = "Show Git commits in current folder"
      },
      {
        '<C-p>',
        function() builtin.git_files() end,
        desc = "Search Git files"
      },
      {
        '<leader>pws',
        function()
          local word = vim.fn.expand("<cword>")
          builtin.grep_string({ search = word })
        end,
        desc = "Find word under cursor"
      },
      {
        '<leader>pWs',
        function()
          local word = vim.fn.expand("<cWORD>")
          builtin.grep_string({ search = word })
        end,
        desc = "Find word under cursor"
      },
      {
        '<leader>pg',
        function() builtin:live_grep() end,
        desc = "Live Grep for a string"
      },
      {
        '<leader>ps',
        function()
          builtin:grep_string({ search = vim.fn.input("Grep > ") })
        end,
        desc = "Grep for a string"
      },
      {
        '<space>/',
        function()
          builtin:current_buffer_fuzzy_find()
        end,
        desc = "Current Buffer Fuzzy Find"
      },

      {
        '<leader>vb',
        function() builtin.buffers() end,
        desc = "Search buffers"
      },
      {
        '<leader>vj',
        function() builtin.jumplist() end,
        desc = "Search Jumplist"
      },
      {
        '<leader>vk',
        function() builtin.keymaps() end,
        desc = "Search keymaps"
      },
      {
        '<leader>vm',
        function() builtin.marks() end,
        desc = "Search marks"
      },
      {
        '<leader>vo',
        function() builtin.oldfiles() end,
        desc = "Search recent files"
      },
      {
        '<leader>vr',
        function() builtin:registers() end,
        desc = "Search registers"
      },
      {
        '<leader>vh',
        function() builtin:help_tags() end,
        desc = "Search help tags"
      },
    }
  end,
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".docker",
          "^.git/",
          "^./.git/",
          "^node_modules/",
          "^build/",
          "^dist/",
          "^target/",
          "^vendor/",
          "^lazy%-lock%.json$",
          "^package%-lock%.json$",
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--hidden",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })
  end,
}
