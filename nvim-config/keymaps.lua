-- options
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- keymap shorthand
local keymap = vim.api.nvim_set_keymap

-- BASE VIM KEYMAPS
-- remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- (visual) remain in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- (visual) stop yank rewrite on paste
keymap("v", "p", '"_dP', opts)
