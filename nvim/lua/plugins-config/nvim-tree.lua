local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("没有找到 nvim-tree")
    return
end

-- 列表操作快捷键
local list_keys = require('core.keybindings').nvimTreeList

nvim_tree.setup({
    -- 不显示 git 状态图标
    git = {
        enable = true,
    },

    -- project plugin 需要这样设置
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },

    filters = {
        dotfiles = false,
        custom = { 'node_modules' },
    },

    view = {
        width = 40,
        side = 'left',
        hide_root_folder = false,

        mappings = {
            custom_only = false,
            list = list_keys,
        },

        number = false,
        relativenumber = false,

        signcolumn = 'yes',
    },
    actions = {
        open_file = {
            resize_window = true,
            quit_on_open = true,
        },
    },

    system_open = {
        cmd = 'wsl-open', -- mac 直接设置为 open
    },

})

