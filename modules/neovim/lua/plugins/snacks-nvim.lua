--- @type LazySpec
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.zen = { enabled = true }
  end,
}
