-- https://github.com/nvim-lualine/lualine.nvim

-- local client = obsidian.get_client()
-- local name = client:vault_name()
--

local function obsidian()
    local client = require('obsidian').get_client()
    local name = client:vault_name()
    return name
end

local function pomo_timer()
    local pomo = require("pomo")

    local timer = pomo.get_first_to_finish()
    if timer == nil then
        return ""
    end

    return "󰄉 " .. tostring(timer)
end

local config = {
    options = {
        theme = 'catppuccin'
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename', obsidian },
        lualine_x = { pomo_timer, 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}

require('lualine').setup(config)
