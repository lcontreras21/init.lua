-- https://github.com/danymat/neogen?tab=readme-ov-file

local neogen = require('neogen')
local i = require("neogen.types.template").item

local reST_without_types = {
    { nil, '"""$1"""', { no_results = true, type = { "class", "func" } } },
    { nil, '"""$1', { no_results = true, type = { "file" } } },
    { nil, "", { no_results = true, type = { "file" } } },
    { nil, "$1", { no_results = true, type = { "file" } } },
    { nil, '"""', { no_results = true, type = { "file" } } },
    { nil, "", { no_results = true, type = { "file" } } },
    { nil, "#$1", { no_results = true, type = { "type" } } },
    { nil, '"""' },
    { nil, "$1" },
    { i.Parameter, ":param %s:$1", { type = { "func" } } },
    { { i.Parameter, i.Type }, ":param %s: %s,$1", { required = i.Tparam, type = { "class", "func" } } },
    { i.ClassAttribute, ":param %s:$1" },
    { i.Throw, ":raises %s:$1", { type = { "func" } } },
    { i.Return, ":return:$1", { type = { "func" } } },
    { i.ReturnTypeHint, ":return: %s$1", { type = { "func" } } },
    { nil, '"""' },
}

local jsdoc = {
    { nil, "/** $1 */", { no_results = true, type = { "func", "class" } } },
    { nil, "/** @type $1 */", { no_results = true, type = { "type" } } },

    { nil, "/**", { no_results = true, type = { "file" } } },
    { nil, " * @module $1", { no_results = true, type = { "file" } } },
    { nil, " */", { no_results = true, type = { "file" } } },

    { nil, "/**", { type = { "class", "func" } } },
    { i.ClassName, " * @classdesc $1", { before_first_item = { " * ", " * @class" }, type = { "class" } } },
    { i.Parameter, " * @param {any} %s $1", { type = { "func" } } },
    {
        { i.Type, i.Parameter },
        " * @param {%s} %s $1",
        { required = i.Tparam, type = { "func" } },
    },
    { i.Return, " * @returns {$1} $1", { type = { "func" } } },
    { nil, " */", { type = { "class", "func" } } },
}

local config = {
    enabled = true,
    languages = {
        python = {
            template = {
                annotation_convention = "reST",
                reST = reST_without_types
            }
        },
        javascript = {
            template = {
                jsdoc = jsdoc
            }
        }
    }
}
neogen.setup(config)

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ds", ":lua require('neogen').generate()<CR>", opts)
