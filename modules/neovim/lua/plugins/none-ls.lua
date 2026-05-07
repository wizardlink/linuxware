-- Customize None-ls sources

---@type LazySpec
return {
	"nvimtools/none-ls.nvim",
	opts = function(_, opts)
		-- opts variable is the default configuration table for the setup function call
		local null_ls = require "null-ls"

		-- Check supported formatters and linters
		-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
		-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

		-- Only insert new sources, do not replace the existing ones
		-- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
		opts.sources = require("astrocore").list_insert_unique(opts.sources, {
			-- Set a formatter
			-- require "none-ls.diagnostics.flake8",
			-- require "none-ls.formatting.ruff",
			null_ls.builtins.formatting.clang_format.with {
				disabled_filetypes = { "cs" },
			},
			null_ls.builtins.formatting.csharpier,
			null_ls.builtins.formatting.nixfmt,
			null_ls.builtins.formatting.stylua,
			--deno_fmt,
			null_ls.builtins.formatting.prettierd,

			null_ls.builtins.code_actions.statix,

			null_ls.builtins.diagnostics.deadnix,
		})
	end,
}
