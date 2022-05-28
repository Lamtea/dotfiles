local m = {}

m.setup = function(use)
    -- 部分実行できるコードランナー
    use({
        "michaelb/sniprun",
        run = "bash ./install.sh",
    })

    m.setup_sniprun()
end

m.setup_sniprun = function()
    require("sniprun").setup()
end

-- 選択範囲を実行する
vim.api.nvim_set_keymap("n", "<leader>rr", [[<Cmd>lua require('sniprun').run()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "x",
    "<leader>rr",
    [[<Cmd>lua require('sniprun').run('v')<CR>]],
    { noremap = true, silent = true }
)
-- 実行結果をリセット
vim.api.nvim_set_keymap(
    "n",
    "<leader>rd",
    [[<Cmd>lua require('sniprun').reset()<CR>]],
    { noremap = true, silent = true }
)
-- すべての実行結果をクローズ
vim.api.nvim_set_keymap(
    "n",
    "<leader>rc",
    [[<Cmd>lua require('sniprun.display').close_all()<CR>]],
    { noremap = true, silent = true }
)

return m
