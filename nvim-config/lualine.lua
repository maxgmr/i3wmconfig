local globals = require("globals")

local ok_status, lualine = pcall(require, "lualine")
if not ok_status then
	vim.notify("ERROR: Failed to load lualine.")
	return
end

local the_eye = function()
	local bufnr = vim.api.nvim_get_current_buf()
	if vim.g.disable_autoformat ~= nil then
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return globals.the_not_so_all_seeing_eye
		else
			return globals.the_all_seeing_eye
		end
	else
		return ""
	end
end

the_eye()

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "gruvbox",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			{
				the_eye,
				component_separators = {
					left = "",
					right = "",
				},
				padding = {
					left = 1,
					right = 0,
				},
			},
			"mode",
		},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				file_status = true,
				newfile_status = true,
				path = 1, -- relative path
				shorting_target = 30,
				symbols = {
					modified = globals.modified_symbol,
					readonly = globals.readonly_symbol,
					unnamed = globals.unnamed_symbol,
					newfile = globals.newfile_symbol,
				},
			},
		},
		lualine_x = {
			"encoding",
			"filesize",
			{
				"filetype",
				colored = true,
				icon_only = true,
				padding = {
					left = 1,
					right = 0,
				},
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
