vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = {
  noremap = true,
  silent = true,
}

map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
map("n", "sc", "<C-w>c", opt)

map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

map("n", "q", ":q<CR>", opt)
map("n", "Q", ":wqa<CR>", opt)

-- nvim-tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>m", ":NvimTreeToggle<CR>", opt)

-- bufferline
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
map("n", "<C-x>", ":Bdelete!<CR>", opt)

-- telescope
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

-- anytasks
map("n", "<F5>", ":AsyncTasks project-build project-run<CR>", opt)
map("n", "<F6>", ":AsyncTasks project-build<CR>", opt)
map("n", "<F7>", ":AsyncTasks file-build file-run<CR>", opt)

local pluginKeysMapping = {}

pluginKeysMapping.nvimTreeList = {
  { key = { "o", "<2-LeftMouse>" }, action = "edit" },
  { key = "<CR>", action = "system_open" },

  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },

  { key = "i", action = "toggle_ignored" },
  { key = ".", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },

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

  { key = { "]" }, action = "cd" },
  { key = { "[" }, action = "dir_up" },
}

-- lsp
pluginKeysMapping.mapLSP = function(mapbuf)
  -- rename
  mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  -- code action
  mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  -- go xx
  mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  -- diagnostic
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  -- formatting
  mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true; }<CR>", opt)
end

-- nvim-cmp
pluginKeysMapping.cmp = function(cmp)
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  return {
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),

    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

    ["<C-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-,>"] = cmp.mapping({
      i = cmp.mapping.close(),
      c = cmp.mapping.close(),
    }),

    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_locally_jumpable() then
        require("luasnip").expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "c" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "c",
    }),
  }
end

-- gitsigns
pluginKeysMapping.gitsigns_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "<leader>gj", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)

    return "<Ignore>"
  end, {
    expr = true,
  })

  map("n", "<leader>gk", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, {
    expr = true,
  })

  map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
  map("n", "<leader>gS", gs.stage_buffer)
  map("n", "<leader>gu", gs.undo_stage_hunk)
  map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
  map("n", "<leader>gR", gs.reset_buffer)
  map("n", "<leader>gp", gs.preview_hunk)
  map("n", "<leader>gb", function()
    gs.blame_line({ full = true })
  end)
  map("n", "<leader>gd", gs.diffthis)
  map("n", "<leader>gD", function()
    gs.diffthis("~")
  end)
  -- toggle
  map("n", "<leader>gtd", gs.toggle_deleted)
  map("n", "<leader>gtb", gs.toggle_current_line_blame)
  -- Text object
  map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
end

pluginKeysMapping.telescopeList = {
  i = {
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",

    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",

    ["<C-c>"] = "close",
    ["q"] = "close",

    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}

pluginKeysMapping.mapDAP = function()
  -- 继续
  map("n", "<F5>", ":lua require('dap').continue()<CR>", opt)
  --  stepOver, stepOut, stepInto
  map("n", "<F10>", ":lua require('dap').step_over()<CR>", opt)
  map("n", "<F11>", ":lua require('dap').step_into()<CR>", opt)
  map("n", "<F12>", ":lua require('dap').step_out()<CR>", opt)
  -- 设置断点
  map("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>", opt)
  -- map("n", "<leader>dT", ":lua require('dap').clear_breakpoints()<CR>", opt)
  -- 弹窗
  map("n", "<leader>dh", ":lua require('dapui').eval()<CR>", opt)

  -- 结束
  map(
    "n",
    "<leader>de",
    ":lua require'dap'.close()<CR>"
      .. ":lua require'dap'.terminate()<CR>"
      .. ":lua require'dap.repl'.close()<CR>"
      .. ":lua require'dapui'.close()<CR>"
      .. ":lua require('dap').clear_breakpoints()<CR>"
      .. "<C-w>o<CR>",
    opt
  )
end

return pluginKeysMapping
