local globals = require("globals")

local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	vim.notify("ERROR: Failed to load gitsigns.")
	return
end

-- keybindings for gitsigns
local gitsigns_bindings = function(bufnr)
	-- jump to next hunk
	vim.keymap.set("n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end)

	-- jump to prev hunk
	vim.keymap.set("n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end)
end

gitsigns.setup({
	signs = {
		add = { text = globals.git_add_symbol },
		change = { text = globals.git_change_symbol },
		delete = { text = globals.git_delete_symbol },
		topdelete = { text = globals.git_topdelete_symbol },
		changedelete = { text = globals.git_changedelete_symbol },
		untracked = { text = globals.git_untracked_symbol },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	auto_attach = true,
	attach_to_untracked = false,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	current_line_blame_formatter_opts = {
		relative_time = false,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 131072, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	on_attach = gitsigns_bindings,
})
