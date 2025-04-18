require('catppuccin').setup({
    flavor = "frappe",
    transparent_background = true,
    custom_highlights = function(colors)
        return {
            CmpBorder = { fg = colors.surface2 },
            LineNr = { fg = colors.lavender },
            CursorLineNr = { fg = colors.green },
            -- CursorLine = { bg = colors.base, blend = 100},
        }
    end,
    integrations = {
        cmp = true,
        gitsigns = true,
        harpoon = false,
        mason = false,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
        treesitter = true,
        ufo = true,
        telescope = {
            enabled = true,
        }

    }
})

function ColorMyPencils(color)
    -- color = color or "catppuccin-frappe"
    color = 'catppuccin-frappe'
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
