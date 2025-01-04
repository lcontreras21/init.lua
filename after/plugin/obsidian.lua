-- https://github.com/epwalsh/obsidian.nvim

local config = {
    workspaces = {
        {
            name = "Database",
            path = "~/Obsidian/Database", -- symlink to actual vault dir
        },
    },
    daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "5. Daily",
        -- Optional, default tags to add to each new daily note created.
        default_tags = {},
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "Daily.md"
    },

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
            note:add_alias(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = "", project = "" }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
                out[k] = v
            end
        end

        return out
    end,

    -- Optional, for templates (see below).
    templates = {
        folder = "Templates",
    },
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
