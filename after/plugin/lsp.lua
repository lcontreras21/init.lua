-- TODO: include mason, mason-lspconfig Github links
--
-- https://github.com/williamboman/mason-lspconfig.nvim

require('mason').setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    -- Set up Mason to install specified LSPs on install
    ensure_installed = {
        'eslint',
        'ts_ls',
        'lua_ls',
        'ruff', -- need python3-venv installed
        'pyright',
        'clangd',
        'cssls',
        'dockerls',
        'docker_compose_language_service',
        'html',
        'gopls',
    },
})

-- Neovim 0.11 change, enable any LSP Mason has installed
mason_lspconfig.setup_handlers({
    function(server_name)
        vim.lsp.enable(server_name)
    end
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config("*", {
    capabilities = capabilities
})

