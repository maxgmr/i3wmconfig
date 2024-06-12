require("gruvbox").setup({
	terminal_colors = true, -- add neovim terminal colors
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	palette_overrides = {},
	overrides = {},
	dim_inactive = true,
	transparent_mode = true,
})

vim.o.background = "dark"

local colourscheme = "gruvbox"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colourscheme)

if not status_ok then
	vim.notify("ERROR: Colour scheme " .. colourscheme .. " not found.")
	return
end
