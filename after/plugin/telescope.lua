local builtin = require('telescope.builtin')


vim.keymap.set('n', '<leader>pf', function()
    if vim.fn.isdirectory(".git") == 1 then
        builtin.git_files()
    else
        builtin.find_files()
    end
end, {})

vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("GREP > ") });
end)
