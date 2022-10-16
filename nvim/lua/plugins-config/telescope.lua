local status, telescope = pcall(require, "telescope")
if not status then
    vim.notify("没有找到 telescope")
    return
end

telescope.setup({
    defaults = {
        initial_mode = "normal",
        mappings = require("core.keybindings").telescopeList,
    },

    pickers = {
        find_files = {
            -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
            -- theme = "dropdown", 
        }
    },
    extensions = {
    },
})
