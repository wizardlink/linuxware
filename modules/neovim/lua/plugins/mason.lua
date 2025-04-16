-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = function(_, opts)
      opts.ensure_installed = nil -- We should always have everything available to neovim,
      opts.run_on_start = false -- and we make sure this never runs so it can't install anything.

      return opts
    end,
  },
}
