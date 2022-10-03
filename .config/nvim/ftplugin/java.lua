local home_path = require("os").getenv("HOME")
local jdtls_path = home_path .. "/dev/lsp/jdtls"
local jdtls_jar_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local jdtls_config_path = jdtls_path .. "/config_linux"
local lombok_path = home_path .. "/dev/lsp/lombok/lombok.jar"

local function get_install_path(package_name)
    return require("mason-registry").get_package(package_name):get_install_path()
end

local java_debug_paths =
    vim.fn.glob(get_install_path("java-debug-adapter") .. "/extension/server/com.microsoft.java.debug.plugin-*.jar")
local java_test_paths = vim.fn.glob(get_install_path("java-test") .. "/extension/server/*.jar")
local bundles = {
    java_debug_paths,
}
vim.list_extend(bundles, vim.split(java_test_paths, "\n"))

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls_data_path = require("os").getenv("JAVA_WORKSPACE") .. "/" .. project_name

local cmd = {
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
    "-javaagent:" .. lombok_path,
    "-Xbootclasspath/a:" .. lombok_path,
    "-jar",
    jdtls_jar_path,
    "-configuration",
    jdtls_config_path,
    "-data",
    jdtls_data_path,
}

local root_markers = { "mvnw", "gradlew", "pom.xml" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local capabilities = require("plugins.lsp").get_capabilities()

local function on_attach(client, bufnr)
    require("plugins.lsp").on_attach(client, bufnr)
    require("jdtls").setup_dap({
        hotcodereplace = "auto",
        config_overrides = {
            console = "internalConsole",
        },
    })
    require("jdtls.setup").add_commands()

    -- Define commands.
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
end

local config = {
    cmd = cmd,
    root_dir = root_dir,
    settings = {
        java = {},
    },
    init_options = {
        bundles = bundles,
    },
    capabilities = capabilities,
    on_attach = on_attach,
}

require("jdtls").start_or_attach(config)

-- For code action.
vim.cmd([[nnoremap <space>i <Cmd>lua require'jdtls'.organize_imports()<CR>]])
vim.cmd([[nnoremap <space>v <Cmd>lua require('jdtls').extract_variable()<CR>]])
vim.cmd([[vnoremap <space>v <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]])
vim.cmd([[nnoremap <space>c <Cmd>lua require('jdtls').extract_constant()<CR>]])
vim.cmd([[vnoremap <space>c <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>]])
vim.cmd([[vnoremap <space>m <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]])
-- For test.
vim.cmd([[nnoremap <space>t <Cmd>lua require'jdtls'.test_nearest_method()<CR>]])
vim.cmd([[nnoremap <space>T <Cmd>lua require'jdtls'.test_class()<CR>]])
-- For debug.
vim.cmd([[nnoremap <space>C <Cmd>JdtRefreshDebugConfigs<CR>]])
