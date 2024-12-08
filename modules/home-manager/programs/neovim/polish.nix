pkgs:
#lua
''
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

  local dap = require("dap")

  -- @type DapAdapter
  dap.adapters.codelldb = {
    port = "''${port}",
    type = "server",
    executable = {
      command = "codelldb",
      args = { "--port", "''${port}" },
    },
  }

  -- @type DapAdapter
  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command =
    "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7",
  }

  -- @type DapAdapter
  dap.adapters.coreclr = {
    type = "executable",
    command = "${pkgs.netcoredbg}/bin/netcoredbg",
    args = {"--interpreter=vscode"}
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
      cwd = "''${workspaceFolder}",
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
      cwd = "''${workspaceFolder}",
      stopAtEntry = true,
    },
    {
      name = "Attach to gdbserver :1234",
      type = "cppdbg",
      request = "launch",
      MIMode = "gdb",
      miDebuggerServerAddress = "localhost:1234",
      miDebuggerPath = "/usr/bin/gdb",
      cwd = "''${workspaceFolder}",
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
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end,
    },
  }
''
