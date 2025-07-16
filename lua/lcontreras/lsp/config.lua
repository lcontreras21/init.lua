local M = {}

local set_lsp_keymaps = function(bufnr)
    local diagnostic_goto = function(next, severity)
        severity = severity and vim.diagnostic.severity[severity] or nil
        local settings = {
            count = next and 1 or -1,
            float = true,
            severity = severity
        }
        return function()
            vim.diagnostic.jump(settings)
            vim.api.nvim_feedkeys("zz", "n", false) -- Keep centered in page
        end
    end

    local keymaps = {

        { "n", "gd",          function() vim.lsp.buf.definition() end },

        { "n", "]e",          diagnostic_goto(true, "ERROR"),               { desc = "Next Error" } },
        { "n", "[e",          diagnostic_goto(false, "ERROR"),              { desc = "Prev Error" } },
        { "n", "]w",          diagnostic_goto(true, "WARN"),                { desc = "Next Warning" } },
        { "n", "[w",          diagnostic_goto(false, "WARN"),               { desc = "Prev Warning" } },

        { "n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end },
        { "n", "<leader>vca", function() vim.lsp.buf.code_action() end },
        { "n", "<leader>vrr", function() vim.lsp.buf.references() end },
        { "n", "<leader>vrn", function() vim.lsp.buf.rename() end },
        { "n", "<C-h>",       function() vim.lsp.buf.signature_help() end },
    }
    for _, key in pairs(keymaps) do
        local opts = key[4] or {}
        opts.silent = true
        opts.buffer = bufnr
        opts.remap = false

        vim.keymap.set(key[1], key[2], key[3], opts)
    end
end

local document_highlight_group = vim.api.nvim_create_augroup("lcontreras_document_highlight", { clear = true })

M.on_attach = function(client, bufnr)
    set_lsp_keymaps(bufnr)

    if client:supports_method("textDocument/inlayHint", bufnr) then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    if client:supports_method("textDocument/documentHighlight", bufnr) then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = document_highlight_group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
            group = document_highlight_group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    -- Neovim native Autocompletion
    -- if client:supports_method('textDocument/completion') then
    --     vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end
end

M.on_exit = function(client, bufnr)
    if client:supports_method("textDocument/documentHighlight", bufnr) then
        vim.api.nvim_clear_autocmds({
            group = document_highlight_group,
            buffer = bufnr,
        })
    end
end

M.capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    return capabilities
end

M.diag_config_basic = false;

M.diagnostics = function()
    local icons = require("lcontreras.ui.icons")
    return {
        update_in_insert = false, -- Show errors while in insert mode
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.diagnostics.ERROR,
                [vim.diagnostic.severity.WARN] = icons.diagnostics.WARN,
                [vim.diagnostic.severity.HINT] = icons.diagnostics.HINT,
                [vim.diagnostic.severity.INFO] = icons.diagnostics.INFO,
            },
        },
        virtual_text = {
            severity = {
                max = vim.diagnostic.severity.WARN,
            },
        },
        virtual_lines = {
            severity = {
                min = vim.diagnostic.severity.ERROR,
            },
            format = function(diagnostic)
                local severity = vim.diagnostic.severity[diagnostic.severity]
                return icons.diagnostics[severity] .. " " .. diagnostic.message
            end,
        },
        severity_sort = true,
        float = {
            -- source = true,
            -- severity_sort = true,
            -- focusable = true,
            -- style = "minimal",
            -- border = "rounded",
        },
    }
end

return M
