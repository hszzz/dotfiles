return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",

  config = function()
    require("nvim-tree").setup({
      git = {
        enable = false,
      },

      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },

      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {},
        exclude = {},
      },

      view = {
        width = 26,
        side = "left",
        hide_root_folder = true,

        mappings = {
          custom_only = false,
          list = require("core.keybindings").nvimTreeList,
        },

        number = false,
        relativenumber = false,

        signcolumn = "yes",
      },

      actions = {
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "single",
            style = "minimal",
          },
        },
        open_file = {
          resize_window = false,
          quit_on_open = false,

          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },

      system_open = {
        -- cmd = 'wsl-open', -- mac 直接设置为 open
        cmd = "open",
      },
    })
  end,
}
