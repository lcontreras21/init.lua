-- https://github.com/hrsh7th/nvim-cmp
local cmp = require('cmp')
local lspkind = require('lspkind')
local snippet_engine = require('lcontreras.snippets')

-- register my Snippet Engine into cmp
snippet_engine.register_cmp_source()

cmp.setup({
    expand = function(args)
        require('luasnip').lsp_expand(args.body)
    end,
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end, { "i", "s", "c", }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = snippet_engine.name },
        { name = 'buffer' },
    }
    ),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    ---@diagnostic disable-next-line: missing-fields
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            vim_item.kind = lspkind.symbolic(vim_item.kind, {
                mode = 'symbol',
                symbol_map = { Supermaven = '󰰣' },
            }) .. ' '
            local maxwidth = 50
            local ellipsis_char = '…'
            if vim.fn.strchars(vim_item.abbr) > maxwidth then vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0,
                    maxwidth) .. ellipsis_char end
            vim_item.menu = ({
                nvim_lsp = 'LSP',
                luasnip = 'Snip',
                buffer = 'Buf',
                path = 'Path',
                async_path = 'Path',
            })[entry.source.name]
            return vim_item
        end,
    },
    -- formatting = {
    --     expandable_indicator = true,
    --     fields = { 'abbr', 'kind', 'menu' },
    --     format = function(_, vim_item)
    --         return vim_item
    --     end,
    -- }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    completion = {
        autocomplete = false,
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.cmdline({
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                print(cmp.visible())
                print(cmp.get_active_entry())
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
    }),
    sources = cmp.config.sources({
        { name = 'path' },
        {
            name = "nvim_lsp",
            priority = 100,
            group_index = 1,
        },
        { name = "nvim_lsp_signature_help", priority = 100, group_index = 1 },
        {
            name = "treesitter",
            max_item_count = 5,
            priority = 90,
            group_index = 5,
            entry_filter = function(entry, vim_item)
                if entry.kind == 15 then
                    local cursor_pos = vim.api.nvim_win_get_cursor(0)
                    local line = vim.api.nvim_get_current_line()
                    local next_char = line:sub(cursor_pos[2] + 1, cursor_pos[2] + 1)
                    if next_char == '"' or next_char == "'" then
                        vim_item.abbr = vim_item.abbr:sub(1, -2)
                    end
                end
                return vim_item
            end,
        },
        {
            name = "rg",
            keyword_length = 5,
            max_item_count = 5,
            option = {
                additional_arguments = "--smart-case --hidden",
            },
            priority = 80,
            group_index = 3,
        },
        {
            name = "buffer",
            max_item_count = 5,
            keyword_length = 2,
            priority = 50,
            entry_filter = function(entry)
                return not entry.exact
            end,
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end,
            },
            group_index = 4,
        },
        { name = 'cmdline', keyword_pattern = [[\!\@<!\w*]] },
    })
})
