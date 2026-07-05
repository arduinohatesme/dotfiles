return {
  { "rafamadriz/friendly-snippets" },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },

    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
}
