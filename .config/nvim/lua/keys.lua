local api = vim.api

-- Keys.
for key, val in pairs({
    ['<C-H>'] = '<C-w><C-h>',
    ['<C-J>'] = '<C-w><C-j>',
    ['<C-K>'] = '<C-w><C-k>',
    ['<C-L>'] = '<C-w><C-l>',
}) do
    api.nvim_set_keymap('n', key, val, {noremap = true})
end
