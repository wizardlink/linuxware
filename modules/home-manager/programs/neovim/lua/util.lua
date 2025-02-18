--- Helper function to allow me to run commands grabbed
--- by the current selection.
--- @param isLua boolean
--- @return string
vim.fn.runcmdonmark = function(isLua)
  local beginRow, beginCol = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local endRow, endCol = unpack(vim.api.nvim_buf_get_mark(0, ">"))

  if beginRow == nil or beginCol == nil or endRow == nil or endCol == nil then
    return ""
  end

  local text = table.concat(
    vim.tbl_map(function(incoming)
      return vim.trim(incoming)
    end, vim.api.nvim_buf_get_text(0, beginRow - 1, beginCol, endRow - 1, endCol + 1, {})),
    " "
  )

  vim.notify("Running expression: " .. text, vim.log.levels.INFO)

  return vim.api.nvim_cmd(
    vim.api.nvim_parse_cmd((isLua == true and ":lua " or "") .. text, {}) --[[@as vim.api.keyset.cmd]],
    {}
  )
end

--- Register the function as a command as well, to facilitate things.
vim.api.nvim_create_user_command("RunCmdOnMark", function(opts)
  vim.fn.runcmdonmark((opts.args == "v:false" or opts.args == "false") and false or true)
end, { range = true, nargs = "?" })
