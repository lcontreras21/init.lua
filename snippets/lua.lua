local function_string = [[
local function ${1:name}(${2:args})
    $0
end
]]


return {
    {
        trigger = 'function',
        body = function_string
    },
}
