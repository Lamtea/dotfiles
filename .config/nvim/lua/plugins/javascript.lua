local m = {}

m.setup = function(use)
    -- package.jsonの補完やnpm/yarn/pnpmのコマンドを発行してくれる
    use({
        "vuki656/package-info.nvim",
        requires = "MunifTanjim/nui.nvim",
    })
    -- javascript/typescriptの正規表現を解説してくれる
    use({
        "bennypowers/nvim-regexplainer",
        requires = {
            "nvim-treesitter/nvim-treesitter",
            "MunifTanjim/nui.nvim",
        },
    })

    m.setup_package_info()
    m.setup_regexplainer()
end

m.setup_package_info = function()
    require("package-info").setup({
        colors = {
            -- Text color for up to date package virtual text
            up_to_date = "#3C4048",
            -- Text color for outdated package virtual text
            outdated = "#d19a66",
        },
        icons = {
            -- Whether to display icons
            enable = true,
            style = {
                -- Icon for up to date packages
                up_to_date = "|  ",
                -- Icon for outdated packages
                outdated = "|  ",
            },
        },
        -- Whether to autostart when `package.json` is opened
        autostart = true,
        -- It hides up to date versions when displaying virtual text
        hide_up_to_date = true,
        -- It hides unstable versions from version list e.g next-11.1.3-canary3
        hide_unstable_versions = false,
        package_manager = "npm",
    })
end

m.setup_regexplainer = function()
    require("regexplainer").setup({
        mode = "narrative",
        -- automatically show the explainer when the cursor enters a regexp
        auto = true,
        -- filetypes (i.e. extensions) in which to run the autocommand
        filetypes = {
            "html",
            "js",
            "cjs",
            "mjs",
            "ts",
            "jsx",
            "tsx",
            "cjsx",
            "mjsx",
        },
        -- Whether to log debug messages
        debug = false,
        -- 'split', 'popup', 'pasteboard'
        display = "popup",
        mappings = {
            toggle = "gR",
            -- examples, not defaults:
            -- show = 'gS',
            -- hide = 'gH',
            -- show_split = 'gP',
            -- show_popup = 'gU',
        },
        narrative = {
            separator = "\n",
        },
    })
end

-- Show package versions
vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nn",
    ":lua require('package-info').show()<CR>",
    { silent = true, noremap = true }
)

-- Hide package versions
vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nc",
    ":lua require('package-info').hide()<CR>",
    { silent = true, noremap = true }
)

-- Update package on line
vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nu",
    ":lua require('package-info').update()<CR>",
    { silent = true, noremap = true }
)

-- Delete package on line
vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nd",
    ":lua require('package-info').delete()",
    { silent = true, noremap = true }
)

-- Install a new package
vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>ni",
    ":lua require('package-info').install()<CR>",
    { silent = true, noremap = true }
)

-- Reinstall dependencies
vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>nr",
    ":lua require('package-info').reinstall()<CR>",
    { silent = true, noremap = true }
)

-- Install a different package version
vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>np",
    ":lua require('package-info').change_version()",
    { silent = true, noremap = true }
)

return m
