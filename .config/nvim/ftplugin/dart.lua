-- telescope.
-- Show flutter commands.
vim.api.nvim_set_keymap(
    "n",
    "<space>c",
    "<Cmd>lua require('telescope').extensions.flutter.commands()<CR>",
    { noremap = true, silent = true }
)
