local servers = {
	"awk_ls", -- awk
	"asm_lsp", -- assembly
	"bashls", -- bash
	"clangd", -- c, c++
	"csharp_ls", -- c#
	"cmake", -- cmake
	"cssls", -- css
	"dockerls", -- docker
	"golangci_lint_ls", -- go
	"html", -- html
	"jsonls", -- json
	"jdtls", -- java
	"tsserver", -- js, typescript
	-- "ltex",                   -- latex
	"lua_ls", -- lua
	"markdown_oxide", -- markdown
	"intelephense", -- php
	"pyright", -- python
	"ruby_lsp", -- ruby
	"rust_analyzer", -- rust
	"sqlls", -- sql
	"somesass_ls", -- sass
	"taplo", -- toml
	"lemminx", -- xml
	-- "gitlab_ci_ls", -- yaml
	"yamlls", -- yaml
}

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	vim.notify("ERROR: Failed to load mason.")
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local mason_lspconfig_status_ok, masonlspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	vim.notify("ERROR: Failed to load mason-lspconfig.")
	return
end

masonlspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("maxgmr.lsp.handlers").on_attach,
		capabilities = require("maxgmr.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "maxgmr.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
