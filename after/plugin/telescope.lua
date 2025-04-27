-- https://github.com/nvim-telescope/telescope.nvim
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

local keymaps = {
    { 'n', '<leader>ff', find_files_from_project_git_root, { desc = "Open a Picker for all files" } },
    { 'n', '<leader>rf', builtin.resume,                   { desc = "Re-open the previously opened Picker" } },
    { 'n', '<leader>vh', builtin.help_tags,                { desc = "Vim Help" } },
    {
        'n',
        '<leader>pws',
        function()
            builtin.grep_string({ search = vim.fn.expand("<cword>>") })
        end,
        { desc = "Open a Picker for files containing this `word`, case-sensitve" }
    },
    {
        'n',
        '<leader>pWs',
        function()
            builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
        end,
        { desc = "Open a Picker for files containing this `word`, case-insensitve" } },
    {
        'n',
        '<leader>ps',
        function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end,
        { desc = "" }
    },
    {
        'n',
        '<leader>env',
        function()
            builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end,
        { desc = "Open a Picker containing files from nvim config directory" }
    },
    {
        'n',
        '<leader>pf',
        function()
            local fn = vim.fn.isdirectory(".git") and builtin.git_files or builtin.find_files
            fn()
        end,
        { desc = "Open a Picker for Git files" }
    }
}

for _, key in pairs(keymaps) do
    local opts = key[4] or {}
    opts.silent = true

    vim.keymap.set(key[1], key[2], key[3])
end


-- local actions = require("telescope.actions")
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                -- ["<esc>"] = actions.close
            },
        },
        file_ignore_patterns = { 'ashp/lib/', 'ashp/bin/', 'charts/', 'static/vendors/bower_components', }
    },
    extensions = {
        fzf = {}
    },
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
