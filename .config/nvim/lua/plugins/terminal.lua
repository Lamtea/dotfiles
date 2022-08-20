local m = {}

m.setup = function(use)
    -- A neovim plugin to persist and toggle multiple terminals during an editing session.
    use({
        "akinsho/toggleterm.nvim",
        tag = "v2.*",
    })

    m.setup_toggleterm()
end

m.setup_toggleterm = function()
    require("toggleterm").setup()
end

-- terminal stop is <C-\> <C-n>.
vim.keymap.set("n", "<M-t>", "<cmd>ToggleTerm<CR>", { silent = true, noremap = true })

return m
