local m = {}

m.setup = function(use)
    -- All the lua functions I don't want to write twice.
    use("nvim-lua/plenary.nvim")
    -- [WIP] An implementation of the Popup API from vim in Neovim. Hope to upstream when complete.
    use("nvim-lua/popup.nvim")
    -- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
    use("kyazdani42/nvim-web-devicons")
    -- UI Component Library for Neovim.
    use("MunifTanjim/nui.nvim")
    -- SQLite/LuaJIT binding and a highly opinionated wrapper for storing, retrieving, caching,
    -- and persisting SQLite databases.
    -- sqlite.lua present new possibilities for plugin development and while it's primarily created for neovim,
    -- it support all luajit environments.
    use("tami5/sqlite.lua")
    -- If you've ever tried using the . command after a plugin map,
    -- you were likely disappointed to discover it only repeated the last native command inside that map,
    -- rather than the map as a whole.
    -- That disappointment ends today. Repeat.vim remaps . in a way that plugins can tap into it.
    use("tpope/vim-repeat")
end

return m
