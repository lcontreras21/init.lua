-- https://github.com/obsidian-nvim/obsidian.nvim
local obsidian = require("obsidian")

local config = {
    workspaces = {
        {
            name = "Database",
            path = vim.env.HOME .. "/Obsidian/Database", -- symlink to actual vault dir
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
    notes_subdir = "0. Inbox",
    new_notes_location = "notes_subdir",

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

    -- Disable's legacy Obsidian commands
    legacy_commands = false,

    completion = {
        -- Enables completion using nvim_cmp
        nvim_cmp = true,
        -- Enables completion using blink.cmp
        blink = false,
        -- Trigger completion at 2 chars.
        min_chars = 2,
        -- Set to false to disable new note creation in the picker
        create_new = true,
    },

}
obsidian.setup(config)

vim.opt.conceallevel = 1


-- TODO: move to ftplugin settings

-- Set Word Wrap on .md files
-- local group = vim.api.nvim_create_augroup("Markdown Wrap Settings", { clear = true })
-- vim.api.nvim_create_autocmd('BufEnter', {
--     pattern = { '*.md' },
--     group = group,
--     command = 'setlocal wrap | setlocal linebreak'
-- })
--
