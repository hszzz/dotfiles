vim.g.mapleader      = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = {
  noremap = true,
  silent = true,
}

map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
map("n", "sc", "<C-w>c", opt)

map("n", "<A-h>", "<C-w>h", opt)

map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

map('n', '<A-m>', ':NvimTreeToggle<CR>', opt)

local pluginKeysMapping = {}

-- nvim-tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>m", ":NvimTreeToggle<CR>", opt)

pluginKeysMapping.nvimTreeList = { -- 打开文件或文件夹
  { key = { "o", "<2-LeftMouse>" }, action = "edit" },
  { key = "<CR>", action = "system_open" },

  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },

  -- Ignore (node_modules)
  { key = "i", action = "toggle_ignored" },

  -- Hide (dotfiles)
  { key = ".", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },

  -- 文件操作
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "y", action = "copy_name" },
  { key = "Y", action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  { key = "I", action = "toggle_file_info" },
  { key = "n", action = "tabnew" },

  -- 目录
  { key = { "]" }, action = "cd" },
  { key = { "[" }, action = "dir_up" },
}

-- bufferline
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
map("n", "<C-w>", ":Bdelete!<CR>", opt)

-- telescope
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

pluginKeysMapping.telescopeList = {
  i = {
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<Down>"] = "move_selection_next",
    ["<Up>"] = "move_selection_previous",

    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",

    ["<C-c>"] = "close",

    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}

return pluginKeysMapping

