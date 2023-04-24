local m = {}

m.setup = function(use)
    -- A blazing fast and easy to configure Neovim statusline written in Lua.
    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true,
        },
    })

    m.setup_lualine()
end

m.setup_lualine = function()
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

return m
