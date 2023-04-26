local m = {}

m.setup = function(use)
    -- A simple statusline/winbar component that uses LSP to show your current code context.
    -- Named after the Indian satellite navigation system.
    use({
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
    })
    -- A blazing fast and easy to configure Neovim statusline written in Lua.
    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true,
        },
    })

    m.setup_navic()
    m.setup_lualine()
end

m.setup_navic = function()
    require("nvim-navic").setup({
        lsp = {
            auto_attach = true,
        },
        highlight = true,
    })
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
                "navic",
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
