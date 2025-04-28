-- Framework inspired by this post:
-- https://old.reddit.com/r/neovim/comments/1cxfhom/builtin_snippets_so_good_i_removed_luasnip/

--- Configure Snippets similar to Neovim 0.11 LSP framework
--- by having a snippets folder in Neovim root directory.
---@return table snippets_by_filetype Snippets by filetype, if available in 'snippets/*.lua'
local function get_filetype_snippets()
    local snippets_by_filetype = {}

    for _, f in pairs(vim.api.nvim_get_runtime_file('snippets/*.lua', true)) do
        local filetype = vim.fn.fnamemodify(f, ':t:r')
        if (filetype ~= 'global') then
            -- local snippets = dofile('snippets.' .. filetype)
            local snippets = dofile(f)
            snippets_by_filetype[filetype] = snippets
        end
    end
    return snippets_by_filetype
end

---@return table global_snippets Snippets made available in all filetypes
local function get_global_snippets()
    local global_snippets = {}

    if (vim.loop.fs_stat('snippets/global.lua')) then
        local f =vim.api.nvim_get_runtime_file('snippets/global.lua', true)[1]
        -- global_snippets = dofile('snippets.global')
        global_snippets = dofile(f)
    end
    return global_snippets
end

local function get_buf_snips()
    local ft = vim.bo.filetype
    local snips = vim.list_slice(get_global_snippets())

    local snippets_by_filetype = get_filetype_snippets()
    if ft and snippets_by_filetype[ft] then
        vim.list_extend(snips, snippets_by_filetype[ft])
    end

    return snips
end


-- NOTE: cmp.core reaches into cmp internals and might break later(?)
local function is_source_registered(cmp, name)
    for _, src in ipairs(cmp.core.sources) do
        if src.name == name then
            return true
        end
    end
    return false
end

local M = {}

M.name = 'lcontreras_snippets'

-- cmp source for snippets to show up in completion menu
function M.register_cmp_source()
    local cmp_source = {}
    local cache = {}
    function cmp_source.complete(_, _, callback)
        local bufnr = vim.api.nvim_get_current_buf()
        if not cache[bufnr] then
            local completion_items = vim.tbl_map(function(s)
                local item = {
                    word = s.trigger,
                    label = s.trigger,
                    kind = vim.lsp.protocol.CompletionItemKind.Snippet,
                    insertText = s.body,
                    insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
                }
                return item
            end, get_buf_snips())

            cache[bufnr] = completion_items
        end

        callback(cache[bufnr])
    end

    local cmp = require('cmp')
    if not is_source_registered(cmp, M.name) then
        cmp.register_source(M.name, cmp_source)
    end
end

-- NOTE: cmp.core reaches into cmp internals and might break later(?)
function M.unregister_cmp_source()
    local cmp = require('cmp')
    local remove = true
    if remove then
        cmp.core.sources = vim.tbl_filter(function(src)
            return src.name ~= M.name
        end, cmp.core.sources)
    end
end

return M
