require('catppuccin').setup({
    flavor = "frappe",
    transparent_background = true,
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
    -- color = color or "catppuccin-frappe"  -- Use nova as default
    color = 'catppuccin-frappe'
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
