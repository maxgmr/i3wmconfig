local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
  -- add mapping
  local function edit_or_open()
        local node = api.tree.get_node_under_cursor()

         if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
          else
            -- open file
            api.node.open.edit()
            -- Close the tree if file was opened
            api.tree.close()
          end
  end

  vim.keymap.set('n', "<CR>", edit_or_open, opts("Open Then Close"))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  ---
  on_attach = my_on_attach,
  ---
}

vim.keymap.set('n', "<leader>f", ":NvimTreeToggle <CR>")
vim.keymap.set('n', "<S-Tab>", "<Plug>(cokeline-focus-prev)", {silent = true})
vim.keymap.set('n', "<Tab>", "<Plug>(cokeline-focus-next)", {silent = true})
vim.keymap.set('n', "<leader>w", function()
    local curbuf = require("cokeline.buffers").get_current()
    curbuf:delete()
end, {desc = 'close buffer' })
vim.keymap.set('n', "<leader>t", ":FloatermNew <CR>")

local map = vim.api.nvim_set_keymap
for i = 1, 9 do
  map(
    "n",
    ("<F%s>"):format(i),
    ("<Plug>(cokeline-focus-%s)"):format(i),
    { silent = true }
  )
  map(
    "n",
    ("<Leader>%s"):format(i),
    ("<Plug>(cokeline-switch-%s)"):format(i),
    { silent = true }
  )
end
