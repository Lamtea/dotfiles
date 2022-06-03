local m = {}

m.setup = function(use)
    -- Many people follow the convention of writing SQL keywords in upper case.
    -- Few people enjoy using shift or caps lock to do it. This plugin fixes that.
    use("jsborjesson/vim-uppercase-sql")
end

return m
