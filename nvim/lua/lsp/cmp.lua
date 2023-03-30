return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind-nvim",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  event = "VeryLazy",
  -- event = "InsertEnter",

  config = function()
    local format = {
      format = require("lspkind").cmp_format({
        -- mode = 'symbol_text',
        mode = "symbol",
        maxwidth = 60,
        before = function(entry, vim_item)
          vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
          return vim_item
        end,
      }),
    }

    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      sources = cmp.config.sources({
        { name = "luasnip", group_index = 1 },
        { name = "nvim_lsp", group_index = 1 },
        { name = "nvim_lsp_signature_help", group_index = 1 },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "calc", group_index = 3 },
      }),

      mapping = require("core.keybindings").cmp(cmp),
      formatting = format,
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
