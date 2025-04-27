local harpoon = require("harpoon")

local config = {
    settings = {
        save_on_toggle = true,

    },
}

harpoon:setup(config)

local keymaps = {
    { "n", "<leader>a", function() harpoon:list():add() end,                         { desc = "Add file to Harpoon List", } },
    { "n", "<C-e>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open Harpoon Menu", } },
}

for _, key in pairs(keymaps) do
    local opts = key[4] or {}
    opts.silent = true

    vim.keymap.set(key[1], key[2], key[3])
end

-----------------------------------------------------------------------
----------------------------- Extensions ------------------------------
-----------------------------------------------------------------------

-- Highlight current file in list
local harpoon_extensions = require("harpoon.extensions")
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

-- Open item in vertical split to the right
harpoon:extend({
    UI_CREATE = function(cx)
        vim.keymap.set("n", "<S-CR>", function()
            vim.opt.splitright = true
            harpoon.ui:select_menu_item({ vsplit = true })
            vim.opt.splitright = false
        end, { buffer = cx.bufnr })
    end,
})
