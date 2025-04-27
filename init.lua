-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Bootstrap Packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

ensure_packer()


local modules = {
    "options",
    "packer",
    "keymaps",
    "autocmds",
    "usercmds",
    "lsp",
}

for _, module in pairs(modules) do
	require("lcontreras." .. module)
end
