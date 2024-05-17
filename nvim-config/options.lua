vim.opt.clipboard = 'unnamedplus'                           -- use system clipboard
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'nv'                                        -- allow mouse

-- Tab
vim.opt.tabstop = 4		                    				-- num visual spaces per TAB
vim.opt.softtabstop = 4						                -- num spaces in tab whilst editing
vim.opt.shiftwidth = 4						                -- num spaces inserted on a tab
vim.opt.expandtab = true					                -- tabs are spaces

-- UI Config
vim.opt.number = true                                       -- show absolute number
vim.opt.relativenumber = true                               -- show relative numbers
vim.opt.cursorline = true                                   -- highlight cursor line
vim.opt.splitbelow = true                                   -- open new vertical split bottom
vim.opt.splitright = true                                   -- open new horiz splits right
vim.opt.termguicolors = true                                -- enable 24-bit RGB colour in TUI

-- Searching
vim.opt.incsearch = true                                    -- search as chars entered
vim.opt.ignorecase = true                                   -- ignore case by default
vim.opt.smartcase = true                                    -- case sensitive if uppercase
