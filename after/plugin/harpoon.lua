local harpoon = require("harpoon")

local config = {
    settings = {
        save_on_toggle = true,

    },
}

harpoon:setup(config)

-- Highlight current file in list
local harpoon_extensions = require("harpoon.extensions")
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

-- Add item to Harpoon List
vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end, {
    desc = "Add file to Harpoon List",
})

-- Open Harpoon List
vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, {
    desc = "Open Harpoon Menu",
})

vim.keymap.set("n", "[b", function()
    harpoon:list():prev()
end, {
    desc = "Open Previous Listed Harpoon item",
})
vim.keymap.set("n", "]b", function()
    harpoon:list():next()
end, {
    desc = "Open Next Listed Harpoon item",
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
