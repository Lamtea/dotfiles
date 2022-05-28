local m = {}

m.setup = function(use)
    -- スタート画面に履歴等表示
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
