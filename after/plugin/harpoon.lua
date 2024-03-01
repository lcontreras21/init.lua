local harpoon = require("harpoon")

local config = {
    settings = {
        save_on_toggle = true,
    },
    -- display = function(item)
    --     local t = {}
    --     local str = item.context.name
    --     for s in string.gmatch(str, "([^" .. "/" .. "]+)") do
    --         table.insert(t, s)
    --     end
    --     if #t <= 5 then
    --         return str
    --     end
    --     return ".../" .. t[#t - 3] .. "/" .. t[#t - 2] .. "/" .. t[#t - 1] .. "/" .. t[#t]
    -- end,
}

-- START REQUIRED
harpoon:setup(config)
-- END REQUIRED

-- Add item to Harpoon List
vim.keymap.set("n", "<leader>a", function()
    harpoon:list():append()
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
