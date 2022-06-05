local g = vim.g

-- Enable python support.
g.python3_host_prog = require("os").getenv("HOME") .. "/.pyenv/shims/python"

-- Disable perl support.
g.loaded_perl_provider = 0
