local todo = require('todo-comments')

local config = {
}

todo.setup(config)

--- Higher-Order-Function (aka decorator) to call todo-comments jump and
--- keep it centered in the page
---@param fn function todo-comments function
---@return function
local function goto_todo(fn)
    return function()
        fn()
        vim.api.nvim_feedkeys("zz", "n", false) -- Keep centered in page
    end
end

-- Navigation for todos
local keymaps = {
    { "n", "]t", goto_todo(todo.jump_next), { desc = "" } },
    { "n", "[t", goto_todo(todo.jump_prev), { desc = "" } },
}

for _, key in pairs(keymaps) do
    local opts = key[4] or {}
    opts.silent = true

    vim.keymap.set(key[1], key[2], key[3])
end
