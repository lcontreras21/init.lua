-- Remaps inspired by ThePrimeagen

vim.keymap.set("n", "<leader>pd", vim.cmd.Ex)

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeShow<CR>")

-- Move highlighted up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Move the next most line to the end of the current line, keeping cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- Half Page Moves keep cursor in place
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- When searching, search terms stay in the middle of the page
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- "greatest remap ever"
-- when copy/pasting onto a highlighted word, preserve the element being copied
-- Ex: have foo in clipboard. highlight bar and paste using remap
-- continuing to paste preserves foo instead of becoming bar
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Copies text into the plus register Does not work in wsl2
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>p", "\"+p")

-- Delete to Void Register Does not work in wsl2?
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Remap Ctrl-C to ESC
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Remap CTRL-S to Save
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save" })

vim.keymap.set("n", "<leader>q", "<cmd>wq<CR>", { desc = "Save and Quit" })

-- Unprogram Q in normal mode
vim.keymap.set("n", "Q", "<nop>")

-- Run LSP to auto format file
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Run LSP to auto format highlighted
vim.keymap.set("v", "<leader>f", function()
    vim.lsp.buf.format({
        range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
        }
    })
end)

-- Navigation with QuickFix Lists
-- https://freshman.tech/vim-quickfix-and-location-list/
vim.keymap.set("i", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("i", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Find and replace the current selected word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Modify a bash file to be executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Open new Pane on the right
vim.keymap.set("n", "<leader>vsp", function()
    vim.opt.splitright = true
    vim.cmd("vsp | Ex")
    vim.opt.splitright = false
end)

-- Run Go on main
vim.keymap.set("n", "<leader><leader>go", "<cmd>!go run main.go<CR>")

-- Clear highlighted
vim.keymap.set("n", "<leader>ch", "<cmd>noh<CR>")

-- Create command so that :W mimics :w
vim.api.nvim_create_user_command('W', function()
    vim.cmd("write")
end, {})

vim.api.nvim_create_user_command('Q', function()
    vim.cmd("quit")
end, {})

-- Go to first and last character in line and stop relying on $ and ^
vim.keymap.set({ 'n', 'v' }, "gh", "^")
vim.keymap.set({ 'n', 'v' }, "gl", "$")
vim.keymap.set('n', "$", "<nop>")
vim.keymap.set('n', "^", "<nop>")
