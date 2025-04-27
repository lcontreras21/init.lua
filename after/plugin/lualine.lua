-- https://github.com/nvim-lualine/lualine.nvim

local config = {
    options = {
        theme = 'catppuccin'
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}

require('lualine').setup(config)
