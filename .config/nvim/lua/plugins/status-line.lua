local m = {}

m.setup = function(use)
    -- lua製のステータスライン
    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true,
        },
    })
    -- ステータスバーにカーソル位置のコンテキストを表示
    use({
        "SmiteshP/nvim-gps",
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
    })

    m.setup_lualine()
    m.setup_gps()
end

m.setup_lualine = function()
    local gps = require("nvim-gps")
    require("lualine").setup({
        options = {
            theme = "nightfox",
        },
        sections = {
            lualine_a = {
                "mode",
            },
            lualine_b = {
                "branch",
                "diff",
                "diagnostics",
            },
            lualine_c = {
                "filename",
                { gps.get_location, cond = gps.is_available },
            },
            lualine_x = {
                "encoding",
                "fileformat",
                "filetype",
            },
            lualine_y = {
                "progress",
            },
            lualine_z = {
                "location",
            },
        },
    })
end

m.setup_gps = function()
    require("nvim-gps").setup()
end

return m
