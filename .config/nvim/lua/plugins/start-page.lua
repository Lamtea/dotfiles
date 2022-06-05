local m = {}

m.setup = function(use)
    -- alpha is a fast and fully customizable greeter for neovim.
    use({
        "goolord/alpha-nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
    })

    m.setup_alpha()
end

m.setup_alpha = function()
    require("alpha").setup(require("alpha.themes.startify").config)
end

return m
