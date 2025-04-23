local usercmds = {
    {
        'W',
        function()
            vim.cmd("write")
        end,
        { desc = "copy :w for fat-fingering" },
    },

    {
        'Q',
        function()
            vim.cmd("quit")
        end,
        { desc = "copy :q for fat-fingering" },
    }
}


for _, usercmd in pairs(usercmds) do
	local opts = usercmd[3] or {}
	opts.force = true

	vim.api.nvim_create_user_command(usercmd[1], usercmd[2], opts)
end
