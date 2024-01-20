local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({
    settings = {
        save_on_toggle = true,
    }
})
-- REQUIRED

-- Add item to Harpoon List
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)

-- Remove item from Harpoon List
vim.keymap.set("n", "<leader><leader>d", function() harpoon:list():remove() end)

-- Open Harpoon List
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "[b", function()
    harpoon:list():prev()
end, {
    desc = "Prev buffer",
})
vim.keymap.set("n", "]b", function()
    harpoon:list():next()
end, {
    desc = "Next buffer",
})

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
