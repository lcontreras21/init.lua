local function augroup(name)
	return vim.api.nvim_create_augroup("lcontreras_" .. name, { clear = true })
end

-- Shift numbered registers up (1 becomes 2, etc.)
-- local prev_reg0_content = vim.fn.getreg("0")
-- local function yank_shift()
--     for i = 9, 1, -1 do
--         vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
--     end
--     vim.fn.setreg("1", prev_reg0_content)
--     prev_reg0_content = vim.fn.getreg("0")
-- end


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
    -- {
    --     -- Simple Yank-Ring to imitate how Delete works
    --     -- Inspired by: https://old.reddit.com/r/neovim/comments/1jv03t1/simple_yankring/
    --     "TextYankPost",
    --     {
    --         group = augroup("yank_ring"),
    --         callback = function()
    --             local event = vim.v.event
    --             if event.operator == "y" then
    --                 yank_shift()
    --             end
    --         end,
    --     }
    -- }
}

for _, autocmd in pairs(autocmds) do
	vim.api.nvim_create_autocmd(autocmd[1], autocmd[2])
end
