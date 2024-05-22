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

require("lazy").setup({
    "nvim-lua/plenary.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
    },
    "lewis6991/gitsigns.nvim",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6"
    },
    {
        "willothy/nvim-cokeline",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "stevearc/resession.nvim"
        },
        config = true
    },
    {"ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ...},
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "mrcjkb/rustaceanvim", 
        version = "^4", 
        lazy = false,
        init = function()
            vim.g.rustaceanvim = {}
        end,
        ft = { "rust" }
    },
    {"nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}},
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/vim-vsnip",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "rust", "toml", "json", "yaml", "html"},
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    "voldikss/vim-floaterm",
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup {
                config = {
                    header = {
[[   _   _     U _____ u    U  ___ u  __     __                   __  __   ]], 
[[  | \ |"|    \| ___"|/     \/"_ \/  \ \   /"/u       ___      U|' \/ '|u ]], 
[[ <|  \| |>    |  _|"       | | | |   \ \ / //       |_"_|     \| |\/| |/ ]], 
[[ U| |\  |u    | |___   .-,_| |_| |   /\ V /_,-.      | |       | |  | |  ]], 
[[  |_| \_|     |_____|   \_)-\___/   U  \_/-(_/     U/| |\u     |_|  |_|  ]], 
[[  ||   \\,-.  <<   >>        \\       //        .-,_|___|_,-. <<,-,,-.   ]], 
[[  (_")  (_/  (__) (__)      (__)     (__)        \_)-' '-(_/   (./  \.)  ]], 
                    },
shortcut = {
        { desc = '󰚰 Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
          desc = ' Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
      },
                    footer = {
                        [[]],
                        [[]],
                        [[]],
                        [[~Max 's Michayla~]]
                    }
                }
            }
        end,
        dependencies = { {"nvim-tree/nvim-web-devicons"} }
    },
    {"windwp/nvim-autopairs", event = "InsertEnter", config = true},
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "neovim/nvim-lspconfig"
        },
        config = function()
            local lsp = require("lsp-zero").preset({})
            lsp.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ["rust-analyzer"] = { "rust" },
                }
            })
        end
    }
})
