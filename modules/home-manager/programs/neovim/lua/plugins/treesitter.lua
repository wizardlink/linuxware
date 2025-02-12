-- Customize Treesitter

---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	---@param _ LazyPlugin
	---@param opts TSConfig
	opts = function(_, opts)
		-- disable automatically installing parsers
		opts.auto_install = false

		-- add more things to the ensure_installed table protecting against community packs modifying it
		opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed --[[@as string[]], {
			-- Programming
			"c",
			"c_sharp",
			"cmake",
			"cpp",
			"css",
			"gdscript",
			"godot_resource",
			"html",
			"hyprlang",
			"javascript",
			"jsdoc",
			"lua",
			"nim",
			"nim_format_string",
			"objc",
			"proto",
			"python",
			"razor",
			"svelte",
			"tsx",
			"typescript",
			"vue",
			-- Scripting
			"bash",
			"fish",
			"glsl",
			-- Configuring
			"dockerfile",
			"json",
			"jsonc",
			"nix",
			"vhs",
			"yaml",
			-- Misc
			"cuda",
			"markdown",
			"markdown_inline",
			"query",
			-- VIM
			"vim",
			"vimdoc",
		})
	end,
}
