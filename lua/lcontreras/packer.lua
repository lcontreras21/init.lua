return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

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

    -- LSP Manager
    use {
        'williamboman/mason-lspconfig.nvim',
        requires = {
            { 'williamboman/mason.nvim' },
            { 'neovim/nvim-lspconfig' },
        }
    }

    -- Snippet support
    use { 'L3MON4D3/LuaSnip' }

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

    -- Better Vim Marks
    use('chentoast/marks.nvim')

    -- Better LSP Formatting
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
