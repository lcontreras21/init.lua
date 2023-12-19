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

-- Open pooned items 1-4 using hotkeys
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)


---It basically takes in one of the harpoon mark numbers and opens it up in a split
---@param harp_mark integer
local function harpoon_split(harp_mark)
    vim.opt.splitright = true
    vim.cmd(string.format("lua require('harpoon').ui:close_menu()"))
    vim.cmd(string.format("vsplit | lua require('harpoon'):list():select(%d)", harp_mark))
    vim.opt.splitright = false
end

-- Open selected list item in right split 
vim.keymap.set("n", "<S-CR>", function()
    local harp_mark = vim.fn.line(".")
    harpoon_split(harp_mark)
end)
