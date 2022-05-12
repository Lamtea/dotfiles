local api = vim.api

-- Variables.
local vars = {
    python3_host_prog = '/usr/bin/python3',
}

for key, val in pairs(vars) do
    api.nvim_set_var(key, val)
end

-- Options.
vim.o.autoindent=true
vim.o.expandtab=true
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.backspace=indent,eol,start

-- Commands.
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
vim.cmd('colorscheme murphy')
