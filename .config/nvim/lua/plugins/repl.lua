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

    m.setup_sniprun()
end

m.setup_sniprun = function()
    require("sniprun").setup()
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
