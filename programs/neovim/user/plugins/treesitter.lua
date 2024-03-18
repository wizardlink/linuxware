return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    local utils = require "astronvim.utils"
    opts.incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>", -- Ctrl + Space
        node_incremental = "<C-space>",
        scope_incremental = "<A-space>", -- Alt + Space
        node_decremental = "<bs>", -- Backspace
      },
    }
    opts.ignore_install = { "gotmpl" }
    opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, {
      -- Programming
      "c",
      "cmake",
      "cpp",
      "css",
      "gdscript",
      "godot_resource",
      "html",
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
