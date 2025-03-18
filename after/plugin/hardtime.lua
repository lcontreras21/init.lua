-- https://github.com/m4xshen/hardtime.nvim

local CONFIG = {
    disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason" },
}

require("hardtime").setup(CONFIG)
