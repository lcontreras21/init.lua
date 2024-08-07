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

vim.opt.fileformat = 'unix'

vim.opt.smartindent = false

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
-- vim.opt.colorcolumn = "80"
vim.opt.colorcolumn = ""

-- Disable mouse in vim 
vim.opt.mouse = ""

-- Set Info at bottom of screen
vim.opt.ruler  = true

vim.g.mapleader = " "

-- Don't know where else to put this, maybe in globals file?
-- Make sure nvim doesn't create python specific mappings
vim.g.no_python_maps = true

-- Disable nvim making maps for any filetype (just in case, hasn't been an issue besides python)
-- vim.g.no_plugin_maps = true
