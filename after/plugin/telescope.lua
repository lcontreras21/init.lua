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

vim.keymap.set('n', '<leader>env', function()
    builtin.find_files {
        cwd = vim.fn.stdpath('config')
    }
end)

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

vim.keymap.set('n', '<leader>rf', builtin.resume, {})

vim.keymap.set('n', '<leader>pws', function()
    local word = vim.fn.expand("<cword>>")
    builtin.grep_string({ search = word });
end)

vim.keymap.set('n', '<leader>pWs', function()
    local word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word });
end)

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("GREP > ") });
end)

-- Vim Help
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

-- local actions = require("telescope.actions")
-- local action_utils = require('telescope.actions.utils')
local action_state = require("telescope.actions.state")
local telescope_custom_actions = {}

local harpoon = require("harpoon")

-- function telescope_custom_actions.harpoon_mark(prompt_bufnr)
--     action_utils.map_entries(prompt_bufnr, function(entry)
--         -- this didn't work for me, but I think I'm close
--         mark.add_file(vim.api.nvim_buf_get_name(entry))
--     end)
-- end

function telescope_custom_actions.harpoon_mark(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 1 then
        for i, entry in ipairs(multi_selection) do
            local filename

            if entry.path or entry.filename then
                print(filename)
                filename = entry.path or entry.filename
                harpoon:list():add(entry.path .. filename);
            end
        end
    end
end

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                -- ["<esc>"] = actions.close
                ["<C-b>"] = telescope_custom_actions.harpoon_mark
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
