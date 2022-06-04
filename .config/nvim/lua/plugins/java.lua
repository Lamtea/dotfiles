local m = {}
local vsext_path = require("os").getenv("HOME") .. "/dev/vscode"
local jdtls_path = require("os").getenv("HOME") .. "/.local/share/nvim/lsp_servers/jdtls"

m.setup = function(use)
    -- Extensions for the built-in Language Server Protocol support in Neovim for eclipse.jdt.ls.
    use("mfussenegger/nvim-jdtls")

    -- m.setup_jdtls()
end

m.setup_jdtls = function()
    local java_debug_paths = vim.fn.glob(
        vsext_path .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
    )
    local java_test_paths = vim.fn.glob(vsext_path .. "/vscode-java-test/server/*.jar")
    local jdtls_jar_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local jdtls_config_path = jdtls_path .. "/config_linux"
    local jdtls_data_path = "/home/lamt/javatest"
    local bundles = {
        java_debug_paths,
    }
    vim.list_extend(bundles, vim.split(java_test_paths, "\n"))
    -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
    local config = {
        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            jdtls_jar_path,
            "-configuration",
            jdtls_config_path,
            "-data",
            jdtls_data_path,
        },
        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
        settings = {
            java = {},
        },
        init_options = {
            bundles = bundles,
        },
        on_attach = function()
            require("jdtls").setup_dap({ hotcodereplace = "auto" })
            vim.cmd(
                [[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)]]
            )
            vim.cmd(
                [[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)]]
            )
            vim.cmd([[command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()]])
            vim.cmd([[command! -buffer JdtJol lua require('jdtls').jol()]])
            vim.cmd([[command! -buffer JdtBytecode lua require('jdtls').javap()]])
            vim.cmd([[command! -buffer JdtJshell lua require('jdtls').jshell()]])
        end,
    }
    require("jdtls").start_or_attach(config)
end

vim.cmd([[nnoremap <leader><leader>ji <Cmd>lua require'jdtls'.organize_imports()<CR>]])
vim.cmd([[nnoremap <leader><leader>jv <Cmd>lua require('jdtls').extract_variable()<CR>]])
vim.cmd([[vnoremap <leader><leader>jv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]])
vim.cmd([[nnoremap <leader><leader>jc <Cmd>lua require('jdtls').extract_constant()<CR>]])
vim.cmd([[vnoremap <leader><leader>jc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>]])
vim.cmd([[vnoremap <leader><leader>jm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]])
vim.cmd([[nnoremap <leader><leader>jt <Cmd>lua require'jdtls'.test_class()<CR>]])
vim.cmd([[nnoremap <leader><leader>jj <Cmd>lua require'jdtls'.test_nearest_method()<CR>]])

return m
