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

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config("*", {
    capabilities = capabilities
})

