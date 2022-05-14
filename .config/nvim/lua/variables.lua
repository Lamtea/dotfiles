local api = vim.api

-- Variables.
local vars = {
    python3_host_prog = '/usr/bin/python3',
}

for key, val in pairs(vars) do
    api.nvim_set_var(key, val)
end
