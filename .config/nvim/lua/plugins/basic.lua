local m = {}

m.setup = function(use)
    -- Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as possible.
    -- It does so by annotating text in your buffer with hints,
    -- short string sequences for which each character represents a key to type to jump to the annotated text.
    -- Most of the time, those sequences’ lengths will be between 1 to 3 characters,
    -- making every jump target in your document reachable in a few keystrokes.
    use("phaazon/hop.nvim")
    -- An always-on highlight for a unique character in every word on a line to help you use f, F and family.
    -- This plugin should help you get to any word on a line in two or three keystrokes with Vim's built-in f<char>
    -- (which moves your cursor to <char>).
    use("unblevable/quick-scope")
    -- This script defines motions similar to w, b, e which do not move word-wise (forward/backward),
    -- but Camel-wise; i.e. to word boundaries and uppercase letters.
    -- The motions also work on underscore notation, where words are delimited by underscore ('_') characters.
    -- From here on, both CamelCase and underscore_notation entities are referred to as "words" (in double quotes).
    -- Just like with the regular motions, a [count] can be prepended to move over multiple "words" at once.
    -- Outside of "words" (e.g. in non-keyword characters like / or ;),
    -- the new motions move just like the regular motions.
    use("bkad/CamelCaseMotion")

    -- sandwich.vim is a set of operator and textobject plugins to add/delete/replace surroundings of a sandwiched
    -- textobject, like (foo), "bar".
    -- sa(add), sd(delete), sr(replace)
    use("machakann/vim-sandwich")

    -- Smart and Powerful commenting plugin for neovim.
    use("numToStr/Comment.nvim")

    if not vim.g.vscode then
        -- neoclip is a clipboard manager for neovim inspired by for example clipmenu.
        -- It records everything that gets yanked in your vim session
        -- (up to a limit which is by default 1000 entries but can be configured).
        -- You can then select an entry in the history using telescope or fzf-lua
        -- which then gets populated in a register of your choice.
        use({
            "AckslD/nvim-neoclip.lua",
            requires = {
                { "tami5/sqlite.lua", module = "sqlite" },
                { "nvim-telescope/telescope.nvim" },
            },
        })

        -- nvim-hlslens helps you better glance at matched information, seamlessly jump between matched instances.
        use("kevinhwang91/nvim-hlslens")

        -- A super powerful autopair plugin for Neovim that supports multiple characters.
        use("windwp/nvim-autopairs")
    end

    -- quick-scope
    -- f/t is forward search, F/T is backward search, t version is cursorred before the selected character.
    vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    -- CamelCaseMotion
    -- Activate normal operation with camel case determination (<leader> + w, b, e, ge)
    vim.g.camelcasemotion_key = "<leader>"

    m.setup_hop()
    m.setup_comment()

    if not vim.g.vscode then
        m.setup_neoclip()
        m.setup_autopairs()
    end
end

m.setup_hop = function()
    require("hop").setup()
end

m.setup_neoclip = function()
    require("neoclip").setup({
        enable_persistent_history = true,
    })
    require("telescope").load_extension("neoclip")
end

m.setup_comment = function()
    require("Comment").setup({
        pre_hook = function()
            return require("ts_context_commentstring.internal").calculate_commentstring()
        end,
        post_hook = nil,
    })
end

m.setup_autopairs = function()
    require("nvim-autopairs").setup({
        map_cr = false,
    })
end

-- Jump to the beginning of the word shown.
vim.api.nvim_set_keymap("n", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {})
vim.api.nvim_set_keymap("x", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {})

if not vim.g.vscode then
    -- Search register by telescope.
    -- <CR> select
    -- p(normal) or <C-p>(insert) paste
    -- k(normal) or <C-k>(insert) paste-ehind
    -- q(normal) or <C-q>(insert) replay-macro
    -- d(normal) or <C-d>(insert) delete
    vim.api.nvim_set_keymap("n", "<leader>fr", "<Cmd>Telescope neoclip<CR>", { noremap = true, silent = true })

    -- Standard command extension (research in forward).
    vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
    )
    -- Standard command extension (research backwards).
    vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
    )
    -- Forward match search.
    vim.api.nvim_set_keymap("n", "*", [[g*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
    -- Backward match search.
    vim.api.nvim_set_keymap("n", "g*", [[g#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
end

return m
