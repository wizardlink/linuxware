-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")

    -- local deno_fmt = helpers.make_builtin({
    --   name = "deno_fmt",
    --   filetypes = {
    --     "angular",
    --     "astro",
    --     "css",
    --     "html",
    --     "javascript",
    --     "json",
    --     "jsonc",
    --     "less",
    --     "markdown",
    --     "sass",
    --     "scss",
    --     "svelte",
    --     "typescript",
    --     "vue",
    --     "yaml",
    --   },
    --   method = { null_ls.methods.FORMATTING },
    --   generator_opts = {
    --     command = "deno",
    --     args = { "fmt", "--unstable-component", "-" },
    --     to_stdin = true,
    --   },
    --   factory = helpers.formatter_factory,
    -- })

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      require("none-ls.diagnostics.flake8"),
      require("none-ls.formatting.ruff"),
      null_ls.builtins.formatting.clang_format.with({
        disabled_filetypes = { "cs" },
      }),
      null_ls.builtins.formatting.csharpier,
      null_ls.builtins.formatting.nixfmt,
      null_ls.builtins.formatting.stylua,
      --deno_fmt,
      null_ls.builtins.formatting.prettierd,
    }
    return config -- return final config table
  end,
}
