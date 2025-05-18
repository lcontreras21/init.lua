-- are these still needed?
vim.opt.isfname:append("@-@")
vim.cmd('highlight ColorColumn guifg=green')

local options = {
    vim = {
        -- Set a block cursor
        guicursor = "",

        -- Turn on line numbers and make them relative
        nu = true,
        relativenumber = true,

        -- Tab Settings
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
        expandtab = true,

        fileformat = 'unix',

        smartindent = false,

        wrap = false,

        -- Use UndoTree instead of VIM for file backups
        swapfile = false,
        backup = false,
        undodir = os.getenv("HOME") .. "/.vim/undodir",
        undofile = true,

        -- Highlight all and Highlight while searching
        hlsearch = true,
        incsearch = true,

        termguicolors = true,

        scrolloff = 8,
        signcolumn = "yes",

        updatetime = 50,

        -- Set Column limit indicator
        -- TODO find plugin to do this better or make one
        -- colorcolumn = "80",
        colorcolumn = "",

        -- Disable mouse in vim
        mouse = "",

        -- Set Info at bottom of screen
        ruler = true,

        showmode = false,
        cursorline = true,
    },
    global = {
        mapleader = " ",

        -- Don't know where else to put this, maybe in globals file?
        -- Make sure nvim doesn't create python specific mappings
        no_python_maps = true,
    }
}

for option, value in pairs(options.vim) do
	vim.o[option] = value
end

for option, value in pairs(options.global) do
	vim.g[option] = value
end

require('csvview').setup()
