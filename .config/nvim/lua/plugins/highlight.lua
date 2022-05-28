local m = {}

m.setup = function(use)
    -- 色コードや名称をカラー表示
    use("norcalli/nvim-colorizer.lua")
    -- todo系コメントハイライトとtrouble, telecopeに表示(タグについては see:github)
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    -- insertモード時は絶対行にする(vimscript)
    use("myusuf3/numbers.vim")
    -- インデントを見やすく表示
    use("lukas-reineke/indent-blankline.nvim")

    m.setup_colorizer()
    m.setup_todo_comments()
    m.setup_indent_blankline()
end

m.setup_colorizer = function()
    require("colorizer").setup()
end

m.setup_todo_comments = function()
    require("todo-comments").setup()
end

m.setup_indent_blankline = function()
    require("indent_blankline").setup({
        space_char_blankline = " ",
        -- treesitterベースでスコープを表示
        show_current_context = true,
        -- アンダースコア表示はしない
        show_current_context_start = false,
    })
end

-- Todoをtroubleに表示
vim.api.nvim_set_keymap("n", "<Leader>xt", "<cmd>TodoTrouble<CR>", { noremap = true })
-- Todoをtelescopeに表示
vim.api.nvim_set_keymap("n", "<Leader>ft", "<cmd>TodoTelescope<CR>", { noremap = true })

return m
