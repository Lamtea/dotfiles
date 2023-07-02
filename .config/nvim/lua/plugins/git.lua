local m = {}

m.setup = function(use)
    -- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
    use({
        "NeogitOrg/neogit",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    -- Vim's diff mode is pretty good,
    -- but there is no convenient way to quickly bring up all modified files in a diffsplit.
    -- This plugin aims to provide a simple,
    -- unified, single tabpage interface that lets you easily review all changed files for any git rev.
    use({
        "sindrets/diffview.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    -- Super fast git decorations implemented purely in lua/teal.
    use("lewis6991/gitsigns.nvim")

    m.setup_neogit()
    m.setup_diffview()
    m.setup_gitsigns()
end

m.setup_neogit = function()
    -- Key mappings by default.
    -- Tab		Toggle diff
    -- 1, 2, 3, 4	Set a foldlevel
    -- $		Command history
    -- b		Branch popup
    -- s		Stage (also supports staging selection/hunk)
    -- S		Stage unstaged changes
    -- <C-s>		Stage Everything
    -- u		Unstage (also supports staging selection/hunk)
    -- U		Unstage staged changes
    -- c		Open commit popup
    -- r		Open rebase popup
    -- L		Open log popup
    -- p		Open pull popup
    -- P		Open push popup
    -- Z		Open stash popup
    -- ?		Open help popup
    -- x		Discard changes (also supports discarding hunks)
    -- <enter>		Go to file
    -- <C-r>		Refresh Buffer
    -- d		Open diffview.nvim at hovered file
    -- D(TODO)		Open diff popup
    require("neogit").setup({
        disable_commit_confirmation = true,
        kind = "tab",
        commit_popup = {
            kind = "split",
        },
        integrations = {
            diffview = true,
        },
    })
end

m.setup_diffview = function()
    require("diffview").setup()
end

m.setup_gitsigns = function()
    require("gitsigns").setup({
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]h", function()
                if vim.wo.diff then
                    return "]h"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Gitsigns next_hunk" })

            map("n", "[h", function()
                if vim.wo.diff then
                    return "[h"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "GitSigns prev_hunk" })

            -- Actions
            map({ "n", "v" }, "<leader><leader>gs", ":Gitsigns stage_hunk<CR>")
            map({ "n", "v" }, "<leader><leader>gr", ":Gitsigns reset_hunk<CR>")
            map("n", "<leader><leader>gS", gs.stage_buffer, { desc = "Gitsigns stage_buffer" })
            map("n", "<leader><leader>gu", gs.undo_stage_hunk, { desc = "GitSigns undo_stage_hunk" })
            map("n", "<leader><leader>gR", gs.reset_buffer, { desc = "GitSigns reset_buffer" })
            map("n", "<leader><leader>gg", gs.preview_hunk, { desc = "GitSigns preview_hunk" })
            map("n", "<leader><leader>gb", function()
                gs.blame_line({ full = true })
            end, { desc = "Gitsigns blame_line" })
            map(
                "n",
                "<leader><leader>gB",
                gs.toggle_current_line_blame,
                { desc = "Gitsigns toggle_current_line_blame" }
            )
            -- diffview
            -- map("n", "<leader><leader>gd", gs.diffthis)
            -- map("n", "<leader><leader>gD", function()
            -- 	   gs.diffthis("~")
            -- end)
            map("n", "<leader><leader>gD", gs.toggle_deleted, { desc = "Gitsigns toggle_deleted" })

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
    })
end

vim.api.nvim_set_keymap("n", "<leader><leader>gc", "<Cmd>Neogit kind=tab<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>gC", "<Cmd>Neogit commit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>gd", "<Cmd>DiffviewOpen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>gh", "<Cmd>DiffviewFileHistory<CR>", { noremap = true, silent = true })

return m
