
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("gitsigns").setup()

require("lualine").setup {
    options = { 
        theme = "gruvbox",
        icons_enabled = true,
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { {
            "filename",
            file_status = true,
            path = 1
        } },
        lualine_x = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", hint = " " }
            },
            "encoding",
            "filetype"
        },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    }
}

-- empty setup using defaults
require("nvim-tree").setup()

-- cokeline
local get_hex = require('cokeline.hlgroups').get_hl_attr

require('cokeline').setup({
  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and get_hex('ColorColumn', 'bg')
         or get_hex('Normal', 'fg')
    end,
    bg = function(buffer)
      return
        buffer.is_focused
        and get_hex('Normal', 'fg')
         or get_hex('ColorColumn', 'bg')
    end,
  },



sidebar = {
    filetype = {'NvimTree', 'neo-tree'},
    components = {
      {
        text = function(buf)
          return buf.filetype
        end,
        fg = yellow,
        bg = function() return get_hex('NvimTreeNormal', 'bg') end,
        bold = true,
      },
    }
  },


  components = {
    {
      text = function(buffer) return ' ' .. buffer.devicon.icon end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      text = function(buffer) return buffer.unique_prefix end,
      fg = get_hex('Comment', 'fg'),
      italic = true
    },
    {
      text = function(buffer) return buffer.filename .. ' ' end,
      underline = function(buffer)
        return buffer.is_hovered and not buffer.is_focused
      end
    },
    {
      text = '󰩈',
      on_click = function(_, _, _, _, buffer)
        buffer:delete()
      end
    },
    {
      text = ' ',
    }
  },
})
