local builtin = require('telescope.builtin')

local function find_files_from_project_git_root()
    local function is_git_repo()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        return vim.v.shell_error == 0
    end
    local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", ".;")
        return vim.fn.fnamemodify(dot_git_path, ":h")
    end
    local opts = {}
    if is_git_repo() then
        opts = {
            cwd = get_git_root(),
        }
    end
    builtin.find_files(opts)
end


vim.keymap.set('n', '<leader>pf', function()
    if vim.fn.isdirectory(".git") == 1 then
        builtin.git_files()
    else
        builtin.find_files()
    end
end, {})

vim.keymap.set('n', '<leader>ff', function()
    find_files_from_project_git_root()
end, {})

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("GREP > ") });
end)

local actions = require("telescope.actions")
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
    }
}
