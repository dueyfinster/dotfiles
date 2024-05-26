local opt = vim.opt

opt.guicursor = ""

-- line numbers
opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- splits
opt.splitbelow = true
opt.splitright = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
local home = os.getenv("HOME")
opt.undodir = string.format("%s/.local/share/nundo/", home)
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.inccommand = "split"

--  search settings
opt.smartcase = true
opt.ignorecase = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

-- Don't have `o` add a comment
opt.formatoptions:remove "o"
