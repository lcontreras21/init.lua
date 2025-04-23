local function augroup(name)
	return vim.api.nvim_create_augroup("lcontreras_" .. name, { clear = true })
end

local autocmds = {
	{
		"TextYankPost",
		{
			group = augroup("highlight_yank"),
			callback = function()
				vim.hl.on_yank()
			end,
            desc = "Flash the text that was yanked",
		},
	},
	{
		"VimResized",
		{
			group = augroup("resize_splits"),
			callback = function()
				local current_tab = vim.fn.tabpagenr()

				vim.cmd.tabdo("wincmd =")
				vim.cmd.tabnext(current_tab)
			end,
            desc = "Resize splits if Terminal window changes size",
		},
	},
}

for _, autocmd in pairs(autocmds) do
	vim.api.nvim_create_autocmd(autocmd[1], autocmd[2])
end
