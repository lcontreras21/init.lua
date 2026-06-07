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
        'stylua',

        'ruff', -- need python3-venv installed
        'pyright',

        'clangd',

        'dockerls',
        'docker_compose_language_service',

        'html',
        'cssls',

        'gopls',
    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config("*", {
    capabilities = capabilities
})


local mr = require("mason-registry")
-- Set up Mason to install specified Formatters on install
local packages = {
    'prettier',
    'prettierd',
    'gopls',
}
for _, pkg in ipairs(packages) do
    local p = mr.get_package(pkg)
    if not p:is_installed() then
        p:install()
    end
end
