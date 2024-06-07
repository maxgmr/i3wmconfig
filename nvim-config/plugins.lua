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
    vim.notify("ERROR: Failed to load Lazy.nvim")
    return
end

-- install/load plugins
lazy.setup({
    "lazy/lazy.nvim",
    "nvim-lua/plenary.nvim",
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true
    }
})
