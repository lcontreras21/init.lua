local modules = {
    "options",
    "pack",
    "keymaps",
    "autocmds",
    "usercmds",
    "lsp",
}

for _, module in pairs(modules) do
	require("lcontreras." .. module)
end
