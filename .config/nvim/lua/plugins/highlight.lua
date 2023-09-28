local m = {}

m.setup = function(use)
    -- A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
    use("norcalli/nvim-colorizer.lua")
    -- todo-comments is a lua plugin for Neovim 0.5
    -- to highlight and search for todo comments like TODO, HACK, BUG in your code base.
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    -- numbers.vim is a plugin for intelligently toggling line numbers.
    -- This plugin alternates between relative numbering (relativenumber)
    -- and absolute numbering (number) for the active window depending on the mode you are in.
    -- In a GUI, it also functions based on whether or not the app has focus.
    -- Commands are included for toggling the line numbering method and for enabling and disabling the plugin.
    use("myusuf3/numbers.vim")
    -- This plugin adds indentation guides to Neovim. It uses Neovim's virtual text feature and no conceal
    -- To start using indent-blankline, call the ibl.setup() function.
    -- This plugin requires the latest stable version of Neovim.
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
    require("ibl").setup()
end

-- Show todos in the trouble window.
vim.api.nvim_set_keymap("n", "<Leader>xz", "<cmd>TodoTrouble<CR>", { noremap = true })
-- Show todos in the telescope window.
vim.api.nvim_set_keymap("n", "<Leader>fz", "<cmd>TodoTelescope<CR>", { noremap = true })

return m
