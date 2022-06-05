local api = vim.api

if not vim.g.vscode then
    -- Move window.
    api.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", { noremap = true, silent = true })
    api.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", { noremap = true, silent = true })
    api.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", { noremap = true, silent = true })
    api.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", { noremap = true, silent = true })
    -- Close tab.
    api.nvim_set_keymap("n", "<M-q>", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
end

-- No highlight.
api.nvim_set_keymap("n", "<Leader>h", ":noh<CR>", { noremap = true, silent = true })
