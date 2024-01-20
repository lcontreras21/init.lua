require('todo-comments').setup()

-- Navigation for todos
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end)
vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end)
