local colors = {
  base00 = "#303446", -- base
  base01 = "#292c3c", -- mantle
  base02 = "#414559", -- surface0
  base03 = "#51576d", -- surface1
  base04 = "#626880", -- surface2
  base05 = "#c6d0f5", -- text
  base06 = "#f2d5cf", -- rosewater
  base07 = "#babbf1", -- lavender
  base08 = "#e78284", -- red
  base09 = "#ef9f76", -- peach
  base0A = "#e5c890", -- yellow
  base0B = "#a6d189", -- green
  base0C = "#81c8be", -- teal
  base0D = "#8caaee", -- blue
  base0E = "#ca9ee6", -- mauve
  base0F = "#eebebe", -- flamingo
}

require("mini.base16").setup({
  palette = colors,
})

vim.g.colors_name = "catppuccin-frappe-base16"

local function hl(highlight, options)
  vim.api.nvim_set_hl(0, highlight, options)
end

local function fg(color)
  return { fg = color, bg = nil, attr = nil, sp = nil }
end

----------------------------
-- Further customizations --
----------------------------

-- General
hl("Delimiter", fg(colors.base05))
hl("Tag", fg(colors.base08))

-- Treesitter
hl("@keyword.return", fg(colors.base0E))
hl("@variable", fg(colors.base08))

-- Tags
hl("@tag.attribute", fg(colors.base09))
hl("@tag.delimiter", fg(colors.base05))

-- LSP Semantic Highlight
hl("@lsp.mod.deprecated", fg(colors.base0F))
hl("@lsp.type.parameter", fg(colors.base05))
hl("@lsp.type.property", fg(colors.base05))
hl("@lsp.type.variable", fg(colors.base08))
