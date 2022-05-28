local m = {}

m.setup = function(use)
    -- キーを一覧表示
    use("folke/which-key.nvim")

    m.setup_which_key()
end

m.setup_which_key = function()
    require("which-key").setup()
end

-- `or'でマーク, "(normal)or<C-r>(insert)でレジスタ, <leader>kでキー
vim.api.nvim_set_keymap("n", "<leader>k", "<Cmd>WhichKey<CR>", { noremap = true, silent = true })

return m
