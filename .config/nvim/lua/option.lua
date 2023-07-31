local o = vim.o
local bo = vim.bo
local wo = vim.wo

o.ignorecase = true
o.smartcase = true
o.updatetime = 300
o.wildmode = "list:longest,full"
o.clipboard = o.clipboard .. "unnamedplus"
bo.expandtab = true
bo.smartindent = true
bo.tabstop = 4
bo.shiftwidth = 4
if not vim.g.vscode then
    o.splitright = true
    o.termguicolors = true
    wo.number = true
    wo.relativenumber = true
    wo.signcolumn = "yes"
    wo.cursorline = true
end
