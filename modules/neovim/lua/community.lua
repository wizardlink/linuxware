-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.catppuccin" },

  { import = "astrocommunity.media.vim-wakatime" },

  { import = "astrocommunity.editing-support.todo-comments-nvim" },

  { import = "astrocommunity.motion.flit-nvim" },
  { import = "astrocommunity.motion.mini-ai" },
  { import = "astrocommunity.motion.mini-surround" },

  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.recipes.diagnostic-virtual-lines-current-line" },

  { import = "astrocommunity.test.neotest" },

  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  -- { import = "astrocommunity.pack.cs" }, Trying out roslyn.nvim
  { import = "astrocommunity.pack.godot" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.yaml" },
}
