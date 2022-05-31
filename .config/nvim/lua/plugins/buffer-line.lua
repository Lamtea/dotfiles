local m = {}

m.setup = function(use)
    -- バッファをタブ表示
    use({
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
    })

    m.setup_bufferline()
end

m.setup_bufferline = function()
    require("bufferline").setup({
        options = {
            numbers = "both",
            diagnostics = "nvim_lsp",
            show_buffer_close_icons = false,
            show_close_icon = false,
            custom_filter = function(buf_number)
                if vim.bo[buf_number].filetype == "qf" then
                    return false
                end
                if vim.bo[buf_number].buftype == "terminal" then
                    return false
                end
                if vim.fn.bufname(buf_number) == "" or vim.fn.bufname(buf_number) == "[No Name]" then
                    return false
                end
                if vim.fn.bufname(buf_number) == "[dap-repl]" then
                    return false
                end

                return true
            end,
        },
    })
end

-- バッファタブの選択を移動
vim.api.nvim_set_keymap("n", "<leader>n", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>p", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
-- バッファタブを移動
vim.api.nvim_set_keymap("n", "<leader>N", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>P", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true })
-- バッファラインのソート
vim.api.nvim_set_keymap("n", "<leader>E", "<Cmd>BufferLineSortByExtension<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>D", "<Cmd>BufferLineSortByDirectory<CR>", { noremap = true, silent = true })
-- バッファタブをEasyMotion風に選択
vim.api.nvim_set_keymap("n", "<Leader>B", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })
-- バッファタブを番号指定で選択
vim.api.nvim_set_keymap("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
-- バッファタブをEasyMotion風に選択
vim.api.nvim_set_keymap("n", "<Leader>q", "<Cmd>BufferLinePickClose<CR>", { noremap = true, silent = true })
-- 現在選択されているバッファタブの左側のバッファタブを閉じる
vim.api.nvim_set_keymap("n", "<Leader>L", "<Cmd>BufferLineCloseLeft<CR>", { noremap = true, silent = true })
-- 上記の右側版
vim.api.nvim_set_keymap("n", "<Leader>R", "<Cmd>BufferLineCloseRight<CR>", { noremap = true, silent = true })

return m
