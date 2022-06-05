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
    -- nvim-gps is a simple status line component that shows context of the current cursor position in file.
    -- It is similar to the statusline function provided by nvim-treesitter, but smarter.
    -- Using custom treesitter queries for each language,
    -- nvim-gps is able to show exact name of containing class, struct, function, method, etc.
    -- along with some fancy symbols!
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
