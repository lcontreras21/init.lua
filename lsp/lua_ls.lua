-- vim.print(vim.lsp.config['lua_ls'])

return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            }
        }
    }
}
