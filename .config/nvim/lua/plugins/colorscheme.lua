local m = {}

m.setup = function(use)
    -- A highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.
    use("EdenEast/nightfox.nvim")

    m.setup_nightfox()
end

m.setup_nightfox = function()
    require("nightfox").setup({
        options = {
            transparent = true,
        },
    })
    vim.cmd("colorscheme nightfox")
end

return m
