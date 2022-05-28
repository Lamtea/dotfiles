local m = {}

m.setup = function(use)
    -- ターミナルをウィンドウ表示
    use({
        "akinsho/toggleterm.nvim",
        tag = "v1.*",
    })

    m.setup_toggleterm()
end

m.setup_toggleterm = function()
    require("toggleterm").setup()
end

-- floatingはlspsagaのほうを使用, ターミナルの停止は<C-\><C-n>
vim.keymap.set("n", "<M-t>", "<cmd>ToggleTerm<CR>", { silent = true, noremap = true })

return m
