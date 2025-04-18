-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]


-- Bootstrap Packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()


return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    if packer_bootstrap then
        require('packer').sync()
    end

    -- Fuzzy Finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        }
    }

    -- Colorscheme 
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Abstract Syntax Tree support for everything else
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-textobjects')

    -- todo Highlighter
    use('folke/todo-comments.nvim')

    -- Harpoon2
    -- Nuff said
    -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- Undo like Git
    use('mbbill/undotree')

    -- Git Integration
    use('tpope/vim-fugitive')

    -- Better Commenting Integration
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                toggler = {
                    line = ' /',
                },
                opleader = {
                    line = ' /',
                }
            })
        end
    }

    -- LSP Integration
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'L3MON4D3/LuaSnip' },
        }
    }

    -- Auto-Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
        }
    }

    -- Better Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Markdown Preview in Browser
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }

    -- Add Git Info in Gutter (sidebar)
    use('lewis6991/gitsigns.nvim')

    -- Better Folding
    use {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async'
    }

    -- Obsidian Integration
    use {
        "epwalsh/obsidian.nvim",
        tag = "*", -- recommended, use latest release instead of latest commit
        requires = {
            -- Required.
            "nvim-lua/plenary.nvim",
        }
    }

<<<<<<< Updated upstream
    -- Better LSP Formatter
    -- TODO: Still need to learn to use it
=======
    -- Better Vim Marks
    use('chentoast/marks.nvim')

    -- Better LSP Formatting
>>>>>>> Stashed changes
    use('stevearc/conform.nvim')

    -- Docstring Annotation Inserter
    use('danymat/neogen')

    -- Add indentation markers
    use('lukas-reineke/indent-blankline.nvim')

    -- Train more vim macros 
    use {
        'm4xshen/hardtime.nvim',
        requires = { { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' } }
    }


    -- Auto Closing HTML tags
    use('windwp/nvim-ts-autotag')
end)
