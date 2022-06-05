local m = {}

m.setup = function(use)
    -- Sniprun is a code runner plugin for neovim written in Lua and Rust.
    -- It aims to provide stupidly fast partial code testing for interpreted and compiled languages.
    -- Sniprun blurs the line between standard save/run workflow, jupyter-like notebook, and REPL/interpreters.
    -- I know that this README is exhaustively long (for the sake of clarity, bear with me),
    -- but Sniprun itself is and will remain rather simple: don't be afraid, questions are welcome too.
    use({
        "michaelb/sniprun",
        run = "bash ./install.sh",
    })
    -- Interactive Repls Over Neovim.
    use("hkupty/iron.nvim")

    m.setup_sniprun()
    -- NOTE: Doesn't work with nightly.
    -- m.setup_iron()
end

m.setup_sniprun = function()
    require("sniprun").setup()
end

m.setup_iron = function()
    local iron = require("iron.core")
    iron.setup({
        config = {
            -- Your repl definitions come here
            repl_definition = {
                sh = {
                    command = { "zsh" },
                },
            },
            -- how the REPL window will be opened, the default is opening
            -- a float window of width 50 at the right.
            repl_open_cmd = require("iron.view").curry.right(50),
        },
        -- Iron doesn't set keymaps by default anymore. Set them here
        -- or use `should_map_plug = true` and map from you vim files
        keymaps = {
            send_motion = "<leader>rs",
            visual_send = "<leader>rs",
            send_line = "<leader>rl",
            repeat_cmd = "<leader>r.",
            cr = "<leader>r<cr>",
            interrupt = "<leader>r<space>",
            exit = "<leader>rq",
            clear = "<leader>rc",
        },
    })
end

vim.api.nvim_set_keymap("n", "<leader>rr", [[<Cmd>lua require('sniprun').run()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "x",
    "<leader>cr",
    [[<Cmd>lua require('sniprun').run('v')<CR>]],
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>cc",
    [[<Cmd>lua require('sniprun').reset()<CR>]],
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>cq",
    [[<Cmd>lua require('sniprun.display').close_all()<CR>]],
    { noremap = true, silent = true }
)

return m
