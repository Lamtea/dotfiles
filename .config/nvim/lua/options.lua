local o = vim.o
local bo = vim.bo
local wo = vim.wo

-- Options.
o.helplang = 'ja,en'
o.ignorecase = true
o.smartcase = true
o.splitright = true
o.termguicolors = true
o.hidden = true
o.updatetime = 300
o.termguicolors = true
o.backspace = 'indent,eol,start'
o.wildmenu = true
o.wildmode = 'list:longest,full'
o.clipboard = 'unnamed,unnamedplus'
bo.expandtab = true
bo.autoindent = true
bo.smartindent = true
bo.tabstop = 4
bo.shiftwidth = 4
bo.autoread = true
wo.number = true
wo.relativenumber = true
wo.signcolumn = 'yes'
wo.cursorline = true
