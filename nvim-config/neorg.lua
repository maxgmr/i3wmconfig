local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
	vim.notify("ERROR: Failed to load neorg.")
	return
end

neorg.setup({
	load = {
		-- load modules
		-- default options
		["core.defaults"] = {},
		-- beautified plaintext w icons
		["core.concealer"] = {
			config = {
				folds = false,
				icon_preset = "basic",
			},
		},
	},
})
