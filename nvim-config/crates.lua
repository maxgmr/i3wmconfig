local status_ok, crates = pcall(require, "crates")
if not status_ok then
	vim.notify("ERROR: Failed to load crates.nvim.")
	return
end

crates.setup({})
