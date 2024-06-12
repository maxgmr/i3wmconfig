-- :help options
local options = {
	backup = false,
	writebackup = false,
	undofile = true,

	fileencoding = "utf-8",

	clipboard = "unnamedplus",

	incsearch = true,
	hlsearch = false,
	ignorecase = true,
	smartcase = true,

	splitbelow = true,
	splitright = true,

	termguicolors = true,
	showmode = false,
	completeopt = { "menuone", "noselect" },
	pumheight = 8,

	number = true,
	relativenumber = true,
	cursorline = false,
	numberwidth = 4,
	signcolumn = "yes",

	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	scrolloff = 12,

	updatetime = 300,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end
