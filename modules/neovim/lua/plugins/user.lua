-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  -- Customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣶⣶⣾⣿⣿⣿⣿⣷⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣾⣿⣿⣿⣿⣷⣶⣶⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⢀⣠⡴⠾⠟⠋⠉⠉⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠛⠷⢦⣄⡀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠘⠋⠁⠀⠀⢀⣀⣤⣶⣖⣒⣒⡲⠶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠶⢖⣒⣒⣲⣶⣤⣀⡀⠀⠀⠈⠙⠂⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⣠⢖⣫⣷⣿⣿⣿⣿⣿⣿⣶⣤⡙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⢋⣤⣾⣿⣿⣿⣿⣿⣿⣾⣝⡲⣄⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⣄⣀⣠⢿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠻⢿⣿⣿⣦⣳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣟⣴⣿⣿⡿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⡻⣄⣀⣤⠀⠀⠀",
            "⠀⠀⠀⠈⠟⣿⣿⣿⡿⢻⣿⣿⣿⠃⠀⠀⠀⠀⠙⣿⣿⣿⠓⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠚⣿⣿⣿⠋⠀⠀⠀⠀⠘⣿⣿⣿⡟⢿⣿⣿⣟⠻⠁⠀⠀⠀",
            "⠤⣤⣶⣶⣿⣿⣿⡟⠀⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⢻⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⡏⠀⠀⠀⠀⠀⠀⣹⣿⣿⣷⠈⢻⣿⣿⣿⣶⣦⣤⠤",
            "⠀⠀⠀⠀⠀⢻⣟⠀⠀⣿⣿⣿⣿⡀⠀⠀⠀⠀⢀⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⡀⠀⠀⠀⠀⢀⣿⣿⣿⣿⠀⠀⣿⡟⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠻⣆⠀⢹⣿⠟⢿⣿⣦⣤⣤⣴⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡿⢷⣤⣤⣤⣴⣿⣿⣿⣿⡇⠀⣰⠟⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠙⠂⠀⠙⢀⣀⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⠁⠀⣻⣿⣿⣿⣿⣿⣿⠏⠀⠘⠃⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡈⠻⠿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠻⢿⣿⣿⣿⠿⠛⢁⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠚⠛⣶⣦⣤⣤⣤⡤⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢤⣤⣤⣤⣶⣾⠛⠓⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          }, "\n"),
        },
      },
    },
  },

  -- Add the catppuccin colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    ---@type CatppuccinOptions
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        blink_cmp = true,
        cmp = false,
        colorful_winsep = { enabled = true, color = "lavender" },
        dap = true,
        dap_ui = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = true,
        markdown = true,
        mason = true,
        native_lsp = { enabled = true },
        neotree = true,
        semantic_tokens = true,
        snacks = { enabled = true, indent_scope_color = "lavender" },
        symbols_outline = true,
        telescope = { enabled = false },
        treesitter = true,
        ts_rainbow = false,
        ufo = true,
        which_key = true,
        window_picker = true,
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          return require("astrocore").extend_tbl(opts, {
            highlights = require("catppuccin.groups.integrations.bufferline").get(),
          })
        end,
      },
      {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = {
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
        },
      },
    },
  },

  -- Makes most if not all groups have a transparent background.
  {
    "xiyaowong/transparent.nvim",
    opts = function(_, opts)
      local transparent = require "transparent"

      opts.exclude_groups = {
        "StatusLine",
        "StatusLineNC",
      }

      opts.extra_groups = {
        "BlinkCmpSignatureHelpActiveParameter",
        "CursorColumn",
        "CursorLineFold",
        "CursorLineSign",
        "FloatBorder",
        "FoldColumn",
        "Folded",
        "GitSignsAdd",
        "GitSignsChange",
        "GitSignsDelete",
        "LineNr",
        "LineNrAbove",
        "LineNrBelow",
        "LineNrBelow",
        "LspInlayHint",
        "NeoTreeFloatingBorder",
        "NeoTreeMessage",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeStatusLine",
        "NeoTreeStatusLineNC",
        "NeoTreeTabActive",
        "NeoTreeTabInactive",
        "NeoTreeTabSeparatorActive",
        "NeoTreeTabSeparatorInactive",
        "NeoTreeVertSplit",
        "NeoTreeWinSeparator",
        "NormalFloat",
        "Pmenu",
        "TabLine",
        "TabLineFill",
        "VertSplit",
        "WinBar",
        "WinBarNC",
        "WinSeparator",
      }

      transparent.clear_prefix "BufferLine"
      transparent.clear_prefix "Diagnostic"
      transparent.clear_prefix "NvimTree"
    end,
  },

  -- Adds highlighting and lsp features for embedded code in documents.
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },

  -- Better UI hooks
  {
    "stevearc/dressing.nvim",
  },
}
