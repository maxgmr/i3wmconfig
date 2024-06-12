local status_ok, conform = pcall(require, "conform")
if not status_ok then
	vim.notify("ERROR: Failed to load Conform.")
	return
end

vim.b.disable_autoformat = false
vim.g.disable_autoformat = false

conform.setup({
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 10000, lsp_fallback = true }
	end,

	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		json = { "prettierd" },
		java = { "google-java-format" },
		markdown = { "prettierd" },
		html = { "prettierd" },
		bash = { "shfmt" },
		toml = { "taplo" },
		css = { "prettierd" },
		scss = { "prettierd" },
		rust = { "rustfmt" },
		python = { "black" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		cs = { "csharpier" },
		xml = { "xmllint" },
		sql = { "sqlfluff" },
		yaml = { "yamlfmt" },
	},
})

conform.formatters.csharpier = {
	inherit = false,
	command = "dotnet",
	args = { "csharpier" },
}

conform.formatters.clang_format = {
	args = { "--style={BasedOnStyle: llvm, IndentWidth: 4}" },
}

-- command to disable format on save
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		vim.g.disable_autoformat = true
	else
		vim.b.disable_autoformat = true
	end
end, {
	desc = "Disable format on save",
	bang = true,
})

-- command to enable format on save
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Enable format on save",
})
