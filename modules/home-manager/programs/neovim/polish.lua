-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add({
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
})

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
  local exceptions = {
    rzls = "callPackage ~/.system/modules/home-manager/programs/rzls { }",
  }

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
      ),
      {
        output = true,
      }
    ),
    "\n"
  )[3]
end

local dap = require("dap")

-- @type DapAdapter
dap.adapters.codelldb = {
  port = "${port}",
  type = "server",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

-- @type DapAdapter
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command =
  "{pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7",
}

-- @type DapAdapter
dap.adapters.coreclr = {
  type = "executable",
  command = "netcoredbg",
  args = { "--interpreter=vscode" },
}

-- @type DapAdapter
dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

-- @type DapConfiguration
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

-- @type DapConfiguration
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

-- @type DapConfiguration
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
}

-- @type DapConfiguration
dap.configurations.gdscript = {
  {
    name = "Launch scene",
    type = "godot",
    request = "launch",
    project = "${workspaceFolder}",
    scene = "current",
  },
}
