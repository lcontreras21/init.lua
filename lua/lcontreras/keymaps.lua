local config = require("lcontreras.lsp.config")
local diagnostic_config_hide = {
    virtual_text = true,
    virtual_lines = false,
}
local diag_config_basic = false

local keymaps = {
    { "n",          "<leader>or", "<C-^>",                                                { desc = "Open previous buffer" } },
    { "n",          "<leader>pd", vim.cmd.Ex,                                             { desc = "" } },
    { "v",          "J",          ":m '>+1<CR>gv=gv",                                     { desc = "Move highlighted down" } },
    { "v",          "K",          ":m '<-2<CR>gv=gv",                                     { desc = "Move highlighted down" } },
    { "n",          "J",          "mzJ`z",                                                { desc = "Move the next most line to the end of the current line, keeping cursor in place" } },
    { "n",          "<C-d>",      "<C-d>zz",                                              { desc = "Half Page Moves keep cursor in place" } },
    { "n",          "<C-u>",      "<C-u>zz",                                              { desc = "Half Page Moves keep cursor in place" } },
    { "n",          "n",          "nzzzv",                                                { desc = "When searching, search terms stay in the middle of the page" } },
    { "n",          "N",          "Nzzzv",                                                { desc = "When searching, search terms stay in the middle of the page" } },
    { "x",          "<leader>p",  "\"_dP",                                                { desc = "when copy/pasting onto a highlighted word, preserve the element being copied" } },
    { { "n", "v" }, "<leader>y",  "\"+y",                                                 { desc = "Copies text into the plus register Does not work in wsl2" } },
    { "n",          "<leader>p",  "\"+p",                                                 { desc = "Pastes from the plus register" } },
    { "i",          "<C-c>",      "<Esc>",                                                { desc = "Remap Ctrl-C to ESC" } },
    { "n",          "<C-s>",      "<cmd>w<CR>",                                           { desc = "Remap CTRL-S to Save" } },
    { "n",          "<leader>q",  "<cmd>wq<CR>",                                          { desc = "Save and Quit" } },
    { "n",          "Q",          "<nop>",                                                { desc = "Unprogram Q in normal mode" } },
    { "n",          "<leader>s",  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Find and replace the current selected word" } },
    { "n",          "<leader>x",  "<cmd>!chmod +x %<CR>",                                 { desc = "Modify a bash file to be executable" } },
    { { "n", "v" }, "gh",         "^",                                                    { desc = "Go to first character" } },
    { { "n", "v" }, "gl",         "$",                                                    { desc = "Go to last character in line" } },
    { "n",          "$",          "<nop>",                                                { desc = "Stop relying on $" } },
    { "n",          "^",          "<nop>",                                                { desc = "Stop relying on ^" } },
    { "n",          "<leader>ch", "<cmd>noh<CR>",                                         { desc = "Clear highlighted" } },
    { "n",          "<leader>u",  vim.cmd.UndotreeToggle,                                 { desc = "Open better undo history" } },  -- WARN: plugin specific
    { "x",          "/",          "<Esc>/\\%V",                                           { desc = "search within visual selection" } },
    {
        "n",
        "<leader>gs",
        function()
            vim.cmd("vertical Git")
        end,
        { desc = "Open Git Status in left vertical split" }
    },
    {
        "n",
        "<leader>f",
        function()
            vim.lsp.buf.format()
        end,
        { desc = "Run LSP to auto format file" }
    },
    {
        "v",
        "<leader>f",
        function()
            vim.lsp.buf.format({
                range = {
                    ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
                    ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
                }
            })
        end,
        { desc = "Run LSP to auto format highlighted" }
    },
    {
        "n",
        "<leader>vsp",
        function()
            vim.opt.splitright = true
            vim.cmd("vsp | Ex")
            vim.opt.splitright = false
        end,
        { desc = "Open new Pane on the right" }
    },
    {
        "n",
        "gK",
        function()
            diag_config_basic = not diag_config_basic
            if diag_config_basic then
                vim.diagnostic.config(diagnostic_config_hide)
            else
                vim.diagnostic.config(config.diagnostics())
            end
        end,
        { desc = "Toggle diagnostic virtual_lines" } },
}

for _, key in pairs(keymaps) do
    local opts = key[4] or {}
    opts.silent = true

    vim.keymap.set(key[1], key[2], key[3])
end
