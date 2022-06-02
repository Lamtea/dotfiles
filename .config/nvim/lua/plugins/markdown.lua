local m = {}

m.setup = function(use)
    -- Preview markdown on your modern browser with synchronised scrolling and flexible configuration.
    use({
        "iamcco/markdown-preview.nvim",
        -- Install without yarn or npm.
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })
    -- An awesome automatic table creator & formatter allowing one to create neat tables as you type.
    -- Default key mappings.
    -- :TableModeToggle     <Leader>tm
    -- :TableModeRealign    <Leader>tr
    -- :Tableize            <Leader>tt
    -- :Tableize/{pattern}  <Leader>T
    -- [| , ]| , {| , }|    to move left | right | up | down cells
    -- i| , a|              for the inner and around the table cell
    -- <Leader>tdd          mapping to delete the current table row
    -- <Leader>tdc          mapping to delete the entire current column
    -- <Leader>tic          mapping to insert a column after the cursor
    -- See github for table formulas.
    use("dhruvasagar/vim-table-mode")

    -- Set default theme (dark or light).
    -- By default the theme is define according to the preferences of the system.
    vim.g.mkdp_theme = "dark"
end

-- Toggle show/close of markdown preview.
vim.api.nvim_set_keymap("n", "gm", "<Cmd>MarkdownPreviewToggle<CR>", { noremap = true, silent = true })

return m
