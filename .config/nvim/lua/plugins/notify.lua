local m = {}

m.setup = function(use)
    -- ポップアップ通知
    use("rcarriga/nvim-notify")

    m.setup_notify()
end

m.setup_notify = function()
    require("notify").setup({
        stages = "fade_in_slide_out",
        background_colour = "FloatShadow",
        timeout = 3000,
    })
    vim.notify = require("notify")
end

return m