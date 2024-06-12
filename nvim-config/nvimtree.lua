local globals = require("globals")

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    vim.notify("ERROR: Failed to load nvim-tree.")
    return
end

local function nvim_tree_on_attach(bufnr)
    local attach_status_ok, api = pcall (require, "nvim-tree.api")
    if not attach_status_ok then
        vim.notify("ERROR: Failed to load nvim-tree API.")
        return
    end

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    local function edit_or_open()
        local node = api.tree.get_node_under_cursor()
        if node.nodes ~= nil then
            api.node.open.edit()
        else
            api.node.open.edit()
            api.tree.close()
        end
    end

    local function vsplit_preview()
        local node = api.tree.get_node_under_cursor()
        if node.nodes ~= nil then
            api.node.open.edit()
        else
            api.node.open.vertical()
        end
        api.tree.focus()
    end

    -- my control mappings
    vim.keymap.set("n", "<CR>", edit_or_open, opts("Edit Or Open"))
    vim.keymap.set("n", "l", edit_or_open, opts("Edit or Open"))
    vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
    vim.keymap.set("n", "h", api.tree.close, opts("Close"))
    vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
end

nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = globals.hint_symbol,
            info = globals.info_symbol,
            warning = globals.warning_symbol,
            error = globals.error_symbol,
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 30,
        side = "left",
        number = true,
        relativenumber = true,
    },
    renderer = {
        highlight_git = true,
        root_folder_modifier = ":t",
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            }
        }
    },
    on_attach = nvim_tree_on_attach,
}
