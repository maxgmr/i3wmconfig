require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        }
    }
})


require('mason-lspconfig').setup({
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'pylsp', 'lua_ls', 'rust_analyzer'},
})

