-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      autopairs = true,  -- enable autopairs at start
      cmp = true,        -- enable completion at start
      diagnostics = true, -- enable diagnostics at start
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
      large_buf = {      -- set global limits for large files for disabling features like treesitter
        size = 1024 * 100,
        lines = 10000,
        line_length = 1000,
      },
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_lines = { current_line = true },
      virtual_text = true,
    },
    -- vim options can be configured here
    options = {
      opt = {                 -- vim.opt.<key>
        autoindent = true,    -- indents automatically based on context
        expandtab = true,     -- use spaces instead of tabs
        grepprg = "rg --vimgrep", -- use ripgrep on grep actions
        number = true,        -- sets vim.opt.number
        relativenumber = true, -- sets vim.opt.relativenumber
        shiftwidth = 2,       -- how many spaces after indentation
        signcolumn = "auto",  -- sets vim.opt.signcolumn to auto
        smartindent = true,   -- smartly indent
        spell = false,        -- sets vim.opt.spell
        tabstop = 2,          -- how many spaces to indent when pressing tab
        wrap = false,         -- sets vim.opt.wrap
      },
      g = {                   -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        -- L = {
        --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- H = {
        --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              require("astrocore.buffer").close(bufnr)
            end)
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
