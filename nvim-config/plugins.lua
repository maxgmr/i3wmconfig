-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- use a protected call so no errors on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	vim.notify("ERROR: Failed to load Lazy.nvim.")
	return
end

local fzf_native_build =
	"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"

-- install/load plugins
lazy.setup({
	"folke/lazy.nvim", -- self-maintain

	"nvim-lua/plenary.nvim", -- standard helpers

	"ellisonleao/gruvbox.nvim", -- colour scheme

	{
		"vhyrro/luarocks.nvim", -- luarocks
		priority = 1000, -- very high priority required; luarocks.nvim must be first plugin in config
		config = true, -- auto setup config
	},
	{
		"nvim-neorg/neorg",
		dependencies = { "luarocks.nvim" },
		lazy = false,
		version = "*", -- pin neorg to latest stable release
	},

	"hrsh7th/nvim-cmp", -- completion plugin
	"hrsh7th/cmp-nvim-lsp", -- lsp completion
	"hrsh7th/cmp-buffer", -- buffer completion
	"hrsh7th/cmp-path", -- path completion
	-- "hrsh7th/cmp-cmdline", -- snippet completion
	"hrsh7th/cmp-nvim-lua", -- nvim's lua api

	"saecki/crates.nvim", -- crates.io deps completion
	"David-Kunz/cmp-npm", -- npm packages completion
	"saadparwaiz1/cmp_luasnip", -- luasnip completion
	"zjp-CN/nvim-cmp-lsp-rs", -- rust analyzer completion
	"L3MON4D3/LuaSnip", -- snippet engine
	"rafamadriz/friendly-snippets", -- large collection of snippets

	"williamboman/mason.nvim", -- lsp manager/installer
	"williamboman/mason-lspconfig.nvim", -- connector btwn mason & lspconfig
	"neovim/nvim-lspconfig", -- enable lsp
	{
		"stevearc/conform.nvim", -- formatting
		opts = {},
	},

	"nvim-telescope/telescope.nvim", -- enable telescope
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = fzf_native_build,
	},

	{
		"nvim-treesitter/nvim-treesitter", -- enable syntax highlighting
		build = ":TSUpdate",
	},

	"windwp/nvim-autopairs", -- enable autopairing

	"numToStr/Comment.nvim", -- easily comment stuff
	"JoosepAlviste/nvim-ts-context-commentstring", -- context-aware comments

	"nvim-tree/nvim-web-devicons", -- misc icons
	"nvim-tree/nvim-tree.lua", -- file tree browser

	"willothy/nvim-cokeline", -- buffer line
	"nvim-lualine/lualine.nvim", -- bottom status line

	{
		"akinsho/toggleterm.nvim", -- terminal
		version = "*",
		config = true,
	},

	"lewis6991/gitsigns.nvim", -- git line decorations

	"goolord/alpha-nvim", -- start screen

	"uga-rosa/utf8.nvim", -- utf-8 support
	"cosmicboots/unicode_picker.nvim", -- unicode character picker
})
