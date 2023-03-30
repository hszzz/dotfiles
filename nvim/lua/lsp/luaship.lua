return {
  "L3MON4D3/LuaSnip",
  event = "VeryLazy",

  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()

    require("luasnip").config.set_config({
      history = true,
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            -- virt_text = { { "choiceNode", "Comment" } },
            virt_text = { { "<--", "Error" } },
          },
        },
      },
    })
  end,
}
