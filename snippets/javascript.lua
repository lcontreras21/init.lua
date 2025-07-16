-- TODO: fill in angularjs snippets

local function_get_string = [[
function ${1:name} (${2:args}) {
	return \$http.get('${3:endpoint}', {
		params: {
			${4:params}
		}
	}).then(function (response) {
		return response.data;
	});
}
]]

local angular_snippets = {
	{ trigger = 'function_get', body = function_get_string },
}

local js_snippets = {
    { trigger = 'controller', body = '' },
    { trigger = 'service', body = '' },
}

local snippets = vim.list_extend(
    angular_snippets,
    js_snippets
)

return snippets
