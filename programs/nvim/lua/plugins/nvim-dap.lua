return {
  "mfussenegger/nvim-dap",
  config = function (_, opts)
    local dap = require("dap")
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "/nix/store/7hv4l0bkai8r6yi59aw6s43jyszwsd91-vscode-extension-vadimcn-vscode-lldb-1.9.2/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
        args = {"--port", "${port}"},
      },
    }
  end
}
