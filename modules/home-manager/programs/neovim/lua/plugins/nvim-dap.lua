---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  config = function()
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

    ---@type dap.Adapter
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.get_nix_store "vscode-extensions.ms-vscode.cpptools"
          .. "/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7",
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

    ---@type dap.Adapter
    dap.adapters.godot = {
      type = "server",
      host = "127.0.0.1",
      port = 6006,
    }

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
  end,
}
