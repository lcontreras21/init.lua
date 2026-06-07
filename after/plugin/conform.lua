-- https://github.com/stevearc/conform.nvim

require("conform").setup({
    default_format_opts = {
        lsp_format = "never",
    },
    formatters_by_ft = {
        go = { "gopls" },
        javascript = { "prettierd", "prettier" },
        lua = { "stylua" },
        python = { "isort" },
        -- Use the "*" filetype to run formatters on all filetypes.
        -- ["*"] = { "codespell" },
    },

    formatters = {
        isort = {
            -- Inherit the default isort config from conform, then append your args
            append_args = {
                "--multi-line",
                "VERTICAL_HANGING_INDENT", -- or -m VERTICAL_HANGING_INDENT
                "--skip",
                "seed/models/__init__.py", -- note: fixed typo (__init__.py)
                "--filter-files",
            },
        },
    },
})

require("conform").formatters.autopep8 = {
    inherit = false,
    command = "autopep8",
    args = { "-", "--max-line-length", "12", "--experimental" },
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

vim.keymap.set("n", "<leader>f", function()
    vim.print("Formatting")
    vim.cmd.Format()
end, { desc = "" })
