local globals = require("globals")

local status_ok, cokeline = pcall(require, "cokeline")
if not status_ok then
    vim.notify("ERROR: Failed to load cokeline.")
    return
end
local hlgroups_ok, hlgroups = pcall(require, "cokeline.hlgroups")
if not hlgroups_ok then
    vim.notify("ERROR: Failed to load cokeline.hlgroups.")
    return
end
local utils_ok, cokeline_utils = pcall(require, "cokeline/utils")
if not utils_ok then
    vim.notify("ERROR: Failed to load cokeline/utils.")
    return
end
local mappings_ok, mappings = pcall(require, "cokeline/mappings")
if not mappings_ok then
    vim.notify("ERROR: Failed to load cokeline/mappings.")
    return
end

local get_hl_attr = hlgroups.get_hl_attr

local comments_fg = get_hl_attr("Comment", "fg")
local errors_fg = get_hl_attr("DiagnosticError", "fg")
local warnings_fg = get_hl_attr("DiagnosticWarn", "fg")

local red = vim.g.terminal_color_1
local green = vim.g.terminal_color_2
local yellow = vim.g.terminal_color_3

local components_old = {
    space = {
        text = " ",
        truncation = { priority = 1 }
    },
    two_spaces = {
        text = "  ",
        truncation = { priority = 1 }
    },
    separator = {
        text = function(buffer)
            return buffer.index ~= 1 and "▏" or ""
        end,
        truncation = { priority = 1 }
    },
    devicon = {
        text = function(buffer)
            return
                (mappings.is_picking_focus() or mappings.is_picking_close())
                and buffer.pick_letter .. " "
                or buffer.devicon.icon
        end,
        fg = function(buffer)
            return
                (mappings.is_picking_focus() and yellow)
                or (mappings.is_picking_close() and red)
                or buffer.devicon.color
        end,
        style = function(_)
            return
                (mappings.is_picking_focus() or mappings.is_picking_close())
                and "italic,bold"
                or nil
        end,
        truncation = { priority = 1 }
    },
    index = {
        text = function(buffer)
            return buffer.index .. ": "
        end,
        truncation = { priority = 1 }
    },
    unique_prefix = {
        text = function(buffer)
            return buffer.unique_prefix
        end,
        fg = comments_fg,
        style = "italic",
        truncation = {
            priority = 3,
            direction = "left",
        }
    },
    filename = {
        text = function(buffer)
            return buffer.filename
        end,
        style = function(buffer)
            return
                ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
                    and "bold,underline")
                or (buffer.is_focused and "bold")
                or (buffer.diagnostics.errors ~= 0 and "underline")
                or nil
        end,
        truncation = {
            priority = 2,
            direction = "left",
        }
    },
    diagnostics = {
        text = function(buffer)
            return
                (buffer.diagnostics.errors ~= 0 and globals.error_symbol .. buffer.diagnostics.errors .. " ")
                or (buffer.diagnostics.warnings ~= 0 and globals.warning_symbol .. buffer.diagnostics.warnings .. " ")
                or ""
        end,
        fg = function(buffer)
            return
                (buffer.diagnostics.errors ~= 0 and red)
                or (buffer.diagnostics.warnings ~= 0 and yellow)
                or nil
        end,
        truncation = { priority = 1 },
    },
    unsaved = {
        text = function(buffer)
            return buffer.is_modified and globals.modified_symbol .. " " or ""
        end,
        fg = function(buffer)
            return buffer.is_modified and green or nil
        end,
        truncation = { priority = 1 }
    }
}

cokeline.setup({
  -- Only show the bufferline when there are at least this many visible buffers.
  -- default: `1`.
  -- type: integer
  show_if_buffers_are_at_least = 2,

  buffers = {
    -- A function to filter out unwanted buffers. Takes a buffer table as a
    -- parameter (see the following section for more infos) and has to return
    -- either `true` or `false`.
    -- default: `false`.
    -- type: false | fun(buf: Buffer):boolean
    filter_valid = false,

    -- A looser version of `filter_valid`, use this function if you still
    -- want the `cokeline-{switch,focus}-{prev,next}` mappings to work for
    -- these buffers without displaying them in your bufferline.
    -- default: `false`.
    -- type: false | fun(buf: Buffer):boolean
    filter_visible = false,

    -- Which buffer to focus when a buffer is deleted, `prev` focuses the
    -- buffer to the left of the deleted one while `next` focuses the one the
    -- right.
    -- default: 'next'.
    -- type: 'prev' | 'next'
    focus_on_delete = 'next',

    -- If set to `last` new buffers are added to the end of the bufferline,
    -- if `next` they are added next to the current buffer.
    -- if set to `directory` buffers are sorted by their full path.
    -- if set to `number` buffers are sorted by bufnr, as in default Neovim
    -- default: 'last'.
    -- type: 'last' | 'next' | 'directory' | 'number' | fun(a: Buffer, b: Buffer):boolean
    new_buffers_position = 'directory',

    -- If true, right clicking a buffer will close it
    -- The close button will still work normally
    -- Default: true
    -- type: boolean
    delete_on_right_click = false,
  },

  mappings = {
    -- Controls what happens when the first (last) buffer is focused and you
    -- try to focus/switch the previous (next) buffer. If `true` the last
    -- (first) buffers gets focused/switched, if `false` nothing happens.
    -- default: `true`.
    -- type: boolean
    cycle_prev_next = true,

    -- Disables mouse mappings
    -- default: `false`.
    -- type: boolean
    disable_mouse = true,
  },

  -- Maintains a history of focused buffers using a ringbuffer
  history = {
    -- type: boolean
    enabled = true,
    ---The number of buffers to save in the history
    -- type: integer
    size = 2
  },

  rendering = {
    -- The maximum number of characters a rendered buffer is allowed to take
    -- up. The buffer will be truncated if its width is bigger than this
    -- value.
    -- default: `999`.
    -- type: integer
    max_buffer_width = 999,
  },

  pick = {
    -- Whether to use the filename's first letter first before
    -- picking a letter from the valid letters list in order.
    -- default: `true`
    -- type: boolean
    use_filename = true,

    -- The list of letters that are valid as pick letters. Sorted by
    -- keyboard reachability by default, but may require tweaking for
    -- non-QWERTY keyboard layouts.
    -- default: `'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP'`
    -- type: string
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP',
  },

  -- The default highlight group values.
  -- The `fg`, `bg`, and `sp` keys are either colors in hexadecimal format or
  -- functions taking a `buffer` parameter and returning a color in
  -- hexadecimal format. Style attributes work the same way, but functions
  -- should return boolean values.
  default_hl = {
    -- default: `ColorColumn`'s background color for focused buffers,
    -- `Normal`'s foreground color for unfocused ones.
    -- type: nil | string | fun(buffer: Buffer): string
    fg = function(buffer)
      return
        buffer.is_focused
            and get_hl_attr("ColorColumn", "bg")        -- old = Normal fg
            or get_hl_attr("Normal", "fg")              -- old = Comment fg
    end,

    -- default: `Normal`'s foreground color for focused buffers,
    -- `ColorColumn`'s background color for unfocused ones.
    -- default: `Normal`'s foreground color.
    -- type: nil | string | function(buffer: Buffer): string,
    bg = function(buffer)
        return
            buffer.is_focused
                and get_hl_attr("Normal", "fg")
                or get_hl_attr("ColorColumn", "bg")
    end,
    --[[ bg = get_hl_attr("ColorColumn", "bg"), ]]      -- old
    -- default: unset.
    -- type: nil | string | function(buffer): string,
    sp = nil,

    -- type: nil | boolean | fun(buf: Buffer):boolean
    bold = nil,
    -- type: nil | boolean | fun(buf: Buffer):boolean
    italic = nil,
    -- type: nil | boolean | fun(buf: Buffer):boolean
    underline = nil,
    -- type: nil | boolean | fun(buf: Buffer):boolean
    undercurl = nil,
    -- type: nil | boolean | fun(buf: Buffer):boolean
    strikethrough = nil,
  },

  -- The highlight group used to fill the tabline space
  fill_hl = 'TabLineFill',

  -- A list of components to be rendered for each buffer. Check out the section
  -- below explaining what this value can be set to.
  -- default: see `/lua/cokeline/config.lua`
  -- type: Component[]
  components = {
      {
          text = function(buffer) return " " .. buffer.devicon.icon end,
          fg = function(buffer) return buffer.devicon.color end
      },
      {
          text = function(buffer) return buffer.unique_prefix end,
          fg = get_hl_attr("Comment", "fg"),
          italic = true
      },
      {
          text = function(buffer) return buffer.filename .. " " end,
          underline = function(buffer)
              return buffer.is_hovered and not buffer.is_focused
          end
      },
      components_old.diagnostics,
      components_old.unsaved,
      --[[ components.space, ]]
      --[[ components.separator, ]]
      --[[ components.devicon, ]]
      --[[ components.unique_prefix, ]]
      --[[ components.filename, ]]
      --[[ components.diagnostics, ]]
      --[[ components.space, ]]
      --[[ components.unsaved, ]]
      --[[ components.space, ]]
  },

  -- Custom areas can be displayed on the right hand side of the bufferline.
  -- They act identically to buffer components, except their methods don't take a Buffer object.
  -- If you want a rhs component to be stateful, you can wrap it in a closure containing state.
  -- type: Component[] | false
  rhs = {},

  -- Tabpages can be displayed on either the left or right of the bufferline.
  -- They act the same as other components, except they are passed TabPage objects instead of
  -- buffer objects.
  -- type: table | false
  tabs = {
    placement = "left",
    -- type: Component[]
    components = {}
  },

  -- Left sidebar to integrate nicely with file explorer plugins.
  -- This is a table containing a `filetype` key and a list of `components` to
  -- be rendered in the sidebar.
  -- The last component will be automatically space padded if necessary
  -- to ensure the sidebar and the window below it have the same width.
  -- type: table | false
  sidebar = {
    -- type: string | string[]
    filetype = { "NvimTree" },
    -- type: Component[]
    components = {},
  },
})
