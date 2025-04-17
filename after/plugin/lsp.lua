-- https://github.com/VonHeikemen/lsp-zero.nvim
local lsp = require('lsp-zero')

-- ----------------------------------------------------------------
-- Set up Mason to install specified LSPs on install
require('mason').setup()
require('mason-lspconfig').setup({
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
    handlers = {
        lsp.default_setup,
    },
})
-- ----------------------------------------------------------------

lsp.preset('recommended')

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local diagnostic_goto = function(next, severity)
    severity = severity and vim.diagnostic.severity[severity] or nil
    local settings = {
        count = next and 1 or -1,
        float = true,
        severity = severity
    }
    return function()
        vim.diagnostic.jump(settings)
    end
end


---@diagnostic disable-next-line: unused-local
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

    vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
    vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
    vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
    vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

-- --------------------------------------------

-- Enable Virtual Text and Virtual Lines
local diagnostic_config_norm = {
    virtual_text = {
        severity = {
            max = vim.diagnostic.severity.WARN,
        },
    },
    virtual_lines = {
        severity = {
            min = vim.diagnostic.severity.ERROR,
        },
    },
}
local diagnostic_config_hide = {
    virtual_text = true,
    virtual_lines = false,
}
vim.diagnostic.config(diagnostic_config_norm)
local diag_config_basic = false
vim.keymap.set("n", "gK", function()
    diag_config_basic = not diag_config_basic
    if diag_config_basic then
        vim.diagnostic.config(diagnostic_config_hide)
    else
        vim.diagnostic.config(diagnostic_config_norm)
    end
end, { desc = "Toggle diagnostic virtual_lines" })

-- --------------------------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local lspconfig = require('lspconfig')

-- Fix vim warning
local lua_opts = lsp.nvim_lua_ls()
lspconfig.lua_ls.setup(lua_opts)

local on_attach = function(client)
    if client.name == 'ruff' then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.eslint.setup {
  capabilities = lsp_capabilities,
}

-- Configure `ruff`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
lspconfig.ruff.setup {
    on_attach = on_attach,
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}

lspconfig.pyright.setup {
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { '*' },
            },
        },
    },
}
