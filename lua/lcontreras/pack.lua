vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end

        local spec = ev.data.spec
        if spec and spec.name == 'telescope-fzf-native.nvim' and
            (kind == 'install' or kind == 'update') then
            -- Run manually:
            -- cd ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
            -- cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release
            -- cmake --build build --config Release --target install

            -- Rebuild automatically
            local path = ev.data.path or vim.fn.stdpath('data') .. '/site/pack/core/opt/telescope-fzf-native.nvim'
            vim.notify('Building telescope-fzf-native.nvim...', vim.log.levels.INFO)
            vim.system({ 'make' }, { cwd = path }, function(obj)
                if obj.code == 0 then
                    vim.notify('telescope-fzf-native build succeeded!', vim.log.levels.INFO)
                else
                    vim.notify('telescope-fzf-native build failed!', vim.log.levels.ERROR)
                end
            end)
        end

        if name == "LuaSnip" and (kind == 'install' or kind == 'update') then
            vim.notify("Building jsregexp for LuaSnip...", vim.log.levels.INFO)
                vim.system({ 'make' }, {})

            -- Run the build synchronously (add :wait() if you want to block)
            local path = ev.data.path or vim.fn.stdpath('data')
            local result = vim.system({ "make", "install_jsregexp" }, {
                cwd = path, -- important: run in the plugin's directory
                text = true,
            }):wait()

            if result.code == 0 then
                vim.notify("LuaSnip jsregexp compiled successfully!", vim.log.levels.INFO)
            else
                vim.notify(
                    "Failed to build jsregexp for LuaSnip:\n" .. (result.stderr or result.stdout or "unknown error"),
                    vim.log.levels.ERROR
                )
            end
        end

    end
})

local plugins = {
    -- Dependency
    'gh:nvim-lua/plenary.nvim',

    -- File Finder
    'gh:nvim-telescope/telescope-fzf-native.nvim',
    {
        src = 'gh:nvim-telescope/telescope.nvim',
        version = 'f7c673b8e46e8f233ff581d3624a517d33a7e264',
		-- setup = function()
		-- 	require("mini.files").setup({})
		-- 	vim.keymap.set({ "n", "x" }, "<leader>e", "<cmd>lua MiniFiles.open()<cr>")
		-- end,
    },

    -- Colorscheme
    { src = "gh:catppuccin/nvim",               name = "catppuccin" },

    -- Text Highlighting
    { src = 'gh:nvim-treesitter/nvim-treesitter', version = 'main' },
    'gh:nvim-treesitter/nvim-treesitter-textobjects',

    -- Highlight TODO comments
    'gh:folke/todo-comments.nvim',

    -- Harpoon
    { src = 'gh:ThePrimeagen/harpoon',        version = 'harpoon2' },

    -- Better VIM undo
    -- 'gh:mbbill/undotree',

    -- Better GIT integration
    'gh:tpope/vim-fugitive',

    -- Better Commenting
    {
        src = 'gh:numToStr/Comment.nvim',
        setup = function()
            require('Comment').setup({
                toggler = {
                    line = ' /',
                },
                opleader = {
                    line = ' /',
                }
            })
        end,
    },

    -- LSP Manager
    'gh:stevearc/conform.nvim', -- Better LSP Formatting
    'gh:neovim/nvim-lspconfig',
    'gh:williamboman/mason.nvim',
    'gh:williamboman/mason-lspconfig.nvim',

    -- Snippet support
    'gh:L3MON4D3/LuaSnip',

    -- Auto-Completion
    'gh:onsails/lspkind.nvim',
    'gh:hrsh7th/cmp-nvim-lsp',
    'gh:hrsh7th/cmp-path',
    'gh:hrsh7th/cmp-cmdline',
    'gh:hrsh7th/cmp-buffer',
    'gh:hrsh7th/cmp-nvim-lsp',
    'gh:hrsh7th/nvim-cmp',

    -- UFO
    'gh:kevinhwang91/promise-async',
    'gh:kevinhwang91/nvim-ufo',


    -- Docstring Annotation Inserter
    'gh:danymat/neogen',

    -- Add indentation markers
    {
        src = 'gh:lukas-reineke/indent-blankline.nvim',
        setup = function()
            require("ibl").setup({
                scope = {
                    enabled = false
                },
            })
        end
    },

    -- Auto Closing HTML tags
    {
        src = 'gh:windwp/nvim-ts-autotag',
        setup = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = false, -- Auto close on trailing </
                },
            })
        end
    },

    -- CSV Viewer
    {
        src = 'gh:hat0uma/csvview.nvim',
        setup = function()
            require('csvview').setup()
        end
    },

    -- Better wrapping
    'gh:rickhowe/wrapwidth',

    -- Add Git Info in Gutter
    'gh:lewis6991/gitsigns.nvim',

    -- Better Status Line
    'gh:nvim-tree/nvim-web-devicons',
    'gh:nvim-lualine/lualine.nvim',

    -- Obsidian Integration
    { src = "gh:obsidian-nvim/obsidian.nvim", version = vim.version.range('*') },
}

vim.pack.add(vim.tbl_map(
    function(p)
        if type(p) == "string" then
            return {
                src = p:gsub("gh:", "https://github.com/"):gsub("^cb:", "https://codeberg.org/"),
            }
        end
        return {
            src = (p.src:gsub("gh:", "https://github.com/"):gsub("^cb:", "https://codeberg.org/")),
            version = p.version,
            name = p.name,
        }
    end, plugins))
vim.cmd("packadd nvim.undotree") -- undotree is built in

for _, p in ipairs(plugins) do
	_ = p.setup and p.setup()
end

-- To remove packages run the following after commenting it out from plugins table
-- vim.pack.del({'undotree'})

vim.api.nvim_create_user_command('PackSync', function ()
    vim.pack.update()
end, {})
