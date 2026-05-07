-- Customize Treesitter
-- --------------------
-- Treesitter customizations are handled with AstroCore
-- as nvim-treesitter simply provides a download utility for parsers

---@type LazySpec
return {
	"AstroNvim/astrocore",
	---@type AstroCoreOpts
	opts = {
		treesitter = {
			highlight = true, -- enable/disable treesitter based highlighting
			indent = true, -- enable/disable treesitter based indentation
			auto_install = false, -- enable/disable automatic installation of detected languages
			ensure_installed = {
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
			},
		},
	},
}
