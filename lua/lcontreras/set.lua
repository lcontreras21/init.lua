-- Set a block cursor
vim.opt.guicursor = ""

-- Turn on line numbers and make them relative
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab Settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


vim.opt.smartindent = true

vim.opt.wrap = false

-- Use UndoTree instead of VIM for file backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Highlight all and Highlight while searching
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Set Column limit indicator
-- TODO find plugin to do this better or make one
vim.cmd('highlight ColorColumn guifg=green')
vim.opt.colorcolumn = "80"

-- Disable mouse in vim 
vim.opt.mouse = ""

-- Set Info at bottom of screen
vim.opt.ruler  = true

vim.g.mapleader = " "
