-- https://github.com/epwalsh/obsidian.nvim

local config = {
    workspaces = {
        {
            name = "Work",
            path = "~/windows/desktop/obsidian/Work",
        },
        {
            name = "Personal",
            path = "~/windows/desktop/obsidian/Personal",
        },
    },
    notes_subdir = "Notes",
    daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Notes/Daily",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
    },

    -- Where to put new notes created from completion. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "Notes_subdir",

    -- Optional, customize how note IDs are generated given an optional title.
    note_id_func = function(title)
        -- Create note IDs 
        local suffix = ""
        if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
            end
        end
        return suffix
    end,

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
    },

    -- Optional, by default commands like `:ObsidianSearch` will attempt to use
    -- telescope.nvim, fzf-lua, fzf.vim, or mini.pick (in that order), and use the
    -- first one they find. You can set this option to tell obsidian.nvim to always use this
    -- finder.
    finder = "telescope.nvim",
}
local obsidian = require('obsidian')
obsidian.setup(config)

vim.opt.conceallevel = 1

-- https://www.reddit.com/r/neovim/comments/zolylk/new_to_neovim_wanting_to_use_it_for_notes/j0o9nhz/
vim.keymap.set("n", "<leader>or", ":b#<cr>") -- Open previous buffer
vim.keymap.set("n", "<leader>ot", ":ObsidianToday<cr>")
vim.keymap.set("n", "<leader>oy", ":ObsidianYesterday<cr>")
vim.keymap.set("n", "<leader>of", ":ObsidianFollowLink<cr>")
vim.keymap.set("n", "<leader>os", ":ObsidianSearch<cr>")
vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<cr>")
vim.keymap.set("n", "<leader>ob", ":ObsidianBacklinks<cr>")
vim.keymap.set("n", "<leader>on", ":ObsidianNew<cr>")
vim.keymap.set("v", "<leader>om", ":obsidianlink<cr>")
vim.keymap.set("v", "<leader>ol", ":ObsidianLinkNew<cr>")

-- Set Word Wrap on .md files
local group = vim.api.nvim_create_augroup("Markdown Wrap Settings", { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { '*.md' },
    group = group,
    command = 'setlocal wrap | setlocal linebreak'
})
