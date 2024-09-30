-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
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
      "svelte",
      "tsx",
      "typescript",
      "vue",
      -- Scripting
      "bash",
      "glsl",
      -- Configuring
      "dockerfile",
      "json",
      "jsonc",
      "nix",
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
