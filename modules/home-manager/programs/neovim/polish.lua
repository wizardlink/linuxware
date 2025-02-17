-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

--- Define PackageOutput
--- @enum PackageOutput
local PACKAGEOUTPUT = {
  out = 0,
  lib = 1,
}

--- Get the store path of a package
--- @param packagename NixSearchExceptions | string
--- @param packageoutput PackageOutput?
--- @return string | nil
vim.fn.getnixpath = function(packagename, packageoutput)
  ---@enum (key) NixSearchExceptions
  local exceptions = {}

  return vim.split(
    vim.api.nvim_cmd(
      vim.api.nvim_parse_cmd(
        string.format(
          "silent !nix eval --raw --expr 'with import <nixpkgs> { }; (%s).%s' --impure",
          exceptions[packagename] or packagename,
          (packageoutput == PACKAGEOUTPUT.out or packageoutput == nil) and "outPath"
          or string.format("lib.getLib %s", packagename)
        ),
        {}
      ) --[[@as vim.api.keyset.cmd]],
      {
        output = true,
      }
    ),
    "\n"
  )[3]
end

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

local dap = require "dap"

---@type dap.Adapter
dap.adapters.codelldb = {
  port = "${port}",
  type = "server",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

---@type dap.Adapter
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command =
  "{pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7",
}

---@type dap.Adapter
dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

---@type dap.Configuration[]
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

---@type dap.Configuration[]
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/usr/bin/gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  },
}

dap.configurations.c = dap.configurations.cpp

---@type dap.Configuration[]
dap.configurations.gdscript = {
  {
    name = "Launch scene",
    type = "godot",
    request = "launch",
    project = "${workspaceFolder}",
    scene = "current",
  },
}
