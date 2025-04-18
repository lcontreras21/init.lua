-- https://github.com/stevearc/conform.nvim

require("conform").setup({
    formatters_by_ft = {
        go = { "goimports", "gofmt" },
        javascript = { { "prettierd", "prettier" } },
        lua = { "stylua" },
        python = { "isort", "autopep8" },
        -- Use the "*" filetype to run formatters on all filetypes.
        -- ["*"] = { "codespell" },
    },
})

require("conform").formatters.autopep8 = {
    inherit = false,
    command = "autopep8",
    args = { "-", "--max-line-length", "12",  "--experimental" },
}

vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })
