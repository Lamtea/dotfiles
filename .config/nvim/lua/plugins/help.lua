local m = {}

m.setup = function(use)
    -- WhichKey is a lua plugin for Neovim 0.5
    -- that displays a popup with possible key bindings of the command you started typing.
    -- Heavily inspired by the original emacs-which-key and vim-which-key.
    use("folke/which-key.nvim")

    m.setup_which_key()
end

m.setup_which_key = function()
    require("which-key").setup()
end

-- `or' show marks, "(normal)or<C-r>(insert) show registers, <leader>k show key mappings.
vim.api.nvim_set_keymap("n", "<leader>k", "<Cmd>WhichKey<CR>", { noremap = true, silent = true })

return m
