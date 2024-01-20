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
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Theme
    use({
        "zanglg/nova.nvim",
        as = 'nova',
        opts = {
            theme = 'dark'
        },
        config = function()
            vim.cmd('colorscheme nova')
        end
    })

    -- Theme
    use({
        "savq/melange-nvim",
        as = 'melange',
    })

    -- Abstract Syntax Tree support for everything else
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-textobjects')

    -- todo Highligher
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
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    -- Better Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Markdown Support
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }
end)
