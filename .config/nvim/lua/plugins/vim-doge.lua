return {
  "kkoomen/vim-doge",
  build = ":call doge#install()",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.g.doge_doc_standard_python = "google"
    vim.g.doge_doc_standard_c = "doxygen"
    vim.g.doge_enable_mappings = 1
  end,
}
