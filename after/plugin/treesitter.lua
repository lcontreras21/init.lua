local treesitter = require('nvim-treesitter')

treesitter.setup()

-- A list of parser names, or "all" (the five listed parsers should always be installed)
local parsers = {
        "c",
        "cpp",
        "css",
        "dockerfile",
        "gitcommit",
        "html",
        "htmldjango",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "python",
        "query",
        "tiger",
        "vim",
        "vimdoc",
        "yaml",
        "markdown",
        "markdown_inline",
}

for _, parser in ipairs(parsers) do
	treesitter.install(parser)
end

local patterns = {}
for _, parser in ipairs(parsers) do
	local parser_patterns = vim.treesitter.language.get_filetypes(parser)
	for _, pp in pairs(parser_patterns) do
		table.insert(patterns, pp)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = patterns,
	callback = function()
		vim.treesitter.start()
	end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
